package org.paasta.caas.dashboard.config.security;

import org.paasta.caas.dashboard.config.security.userdetail.CustomUserDetailsService;
import org.paasta.caas.dashboard.security.SsoAuthenticationProvider;
import org.paasta.caas.dashboard.security.SsoLogoutHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;
import org.springframework.security.web.access.ExceptionTranslationFilter;
import org.springframework.security.web.authentication.Http403ForbiddenEntryPoint;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.context.request.RequestContextListener;


/**
 * Created by indra on 2018-07-31.
 */
@Configuration
@Order(1)
@EnableWebSecurity
public class SsoSecurityConfigAdapter extends WebSecurityConfigurerAdapter {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoSecurityConfigAdapter.class);

    public static final String ROLE_LOGIN = "N/A";

    @Autowired
    @Qualifier("ssoAuthenticationProvider")
    private AuthenticationProvider ssoAuthenticationProvider;

    @Bean(name = "ssoAuthenticationProvider")
    @Autowired
    public SsoAuthenticationProvider ssoAuthenticationProvider(CustomUserDetailsService customUserDetailsService) {
        return new SsoAuthenticationProvider(customUserDetailsService);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        if (ssoAuthenticationProvider != null){
            auth.authenticationProvider(ssoAuthenticationProvider);
        } else {
            LOGGER.info("ssoAuthenticationProvider is null");
        }
    }

    @Bean(name = "authenticationManager")
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManager();
    }

    @Bean
    @ConditionalOnMissingBean(RequestContextListener.class)
    public RequestContextListener requestContextListener() {
        return new RequestContextListener();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
                .antMatcher("/webjars/**")
                .antMatcher("/css/**")
                .antMatcher("/js/**")
                .antMatcher("/common/error/**")
                .antMatcher("/error/**")
                .antMatcher("/resources/**")
                .authorizeRequests()
                .anyRequest()
                .permitAll()
                .and().csrf().disable();
    }

    @Configuration
    @Order(2)
    public static class ssoWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
        @Autowired
        @Qualifier("ssoEntryPointMatcher")
        private RequestMatcher ssoEntryPointMatcher;

        @Autowired
        @Qualifier("ssoClientContextFilter")
        private SsoFilterWrapper ssoClientContextFilter;

        @Autowired
        @Qualifier("ssoSocialClientFilter")
        private SsoFilterWrapper ssoSocialClientFilter;

        @Autowired
        @Qualifier("ssoLogoutSuccessHandler")
        private LogoutSuccessHandler ssoLogoutSuccessHandler;

        @Autowired
        @Qualifier("ssoLogoutUrlMatcher")
        private RequestMatcher ssoLogoutUrlMatcher;

        @Override
        protected void configure(HttpSecurity http) throws Exception {

            http
//                    .csrf().disable()
//                    .requestMatcher(ssoEntryPointMatcher)
                    .authorizeRequests()
//                    .antMatchers("/dashboard/**").permitAll()
//                    .antMatchers("/caas/dashboard/main").permitAll()
                    .antMatchers("/caas/clusters/overview").access("hasRole('ROLE_ADMIN')")
                    .antMatchers("/caas/clusters/overview/**").authenticated()
                    .antMatchers("/caas/clusters/namespaces/**").access("hasRole('ROLE_ADMIN')")
                    .antMatchers("/caas/dashboard").access("hasRole('ROLE_ADMIN')")
                    .antMatchers("/caas/dashboard/**").authenticated()
                    .antMatchers("/caas/users").access("hasRole('ROLE_ADMIN')")
                    .antMatchers("/workload/replicasets").access("hasRole('ROLE_ADMIN')")
                    .antMatchers("/common/**").permitAll()
//                    .anyRequest().access(isManagingApp())
                    .and()
                        .addFilterBefore(ssoClientContextFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
                        .addFilterBefore(ssoSocialClientFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
                        .logout()
                        .logoutSuccessHandler(ssoLogoutSuccessHandler)
                        .logoutRequestMatcher(ssoLogoutUrlMatcher)
//                        .deleteCookies("JSESSIONID")
//                        .clearAuthentication(true)
//                        .invalidateHttpSession(true)
                    .and()
                        .formLogin()
                        .loginPage("/common/error/unauthorized")
                    .and()
                        .exceptionHandling()
                        .accessDeniedPage("/common/error/unauthorized");
        }
    }
}
