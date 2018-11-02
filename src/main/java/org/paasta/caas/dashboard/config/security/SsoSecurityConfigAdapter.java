package org.paasta.caas.dashboard.config.security;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.config.security.userdetail.CustomUserDetailsService;
import org.paasta.caas.dashboard.security.SsoAuthenticationProvider;
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
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.context.request.RequestContextListener;


/**
 * SsoSecurityConfigAdapter 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
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
        return authenticationManager();
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
                    .antMatchers(Constants.CAAS_INIT_URI).access("hasRole('ROLE_ADMIN')")
                    .antMatchers(Constants.CAAS_INIT_URI + "/**").authenticated()
                    .antMatchers("/caas/users").access("hasRole('ROLE_ADMIN')")
                    .antMatchers("/resources/**").permitAll()
                    .and()
                        .addFilterBefore(ssoClientContextFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
                        .addFilterBefore(ssoSocialClientFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
                        .logout()
                        .logoutSuccessHandler(ssoLogoutSuccessHandler)
                        .logoutRequestMatcher(ssoLogoutUrlMatcher)
                    .and()
                        .formLogin()
                        .loginPage("/common/error/unauthorized")
                    .and()
                        .exceptionHandling()
                        .accessDeniedPage("/common/error/unauthorized");
        }
    }
}
