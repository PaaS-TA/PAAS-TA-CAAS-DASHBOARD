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
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.context.request.RequestContextListener;

import static org.paasta.caas.dashboard.config.security.SsoSecurityConfiguration.isManagingApp;

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
//                    .requestMatcher(ssoEntryPointMatcher)
                    .authorizeRequests()
                    .antMatchers("/dashboard/**").permitAll()
                    .antMatchers("/main").access("hasRole('ROLE_ADMIN')")
//                    .anyRequest().access(isManagingApp())
                    .and()
                    .addFilterBefore(ssoClientContextFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
                    .addFilterBefore(ssoSocialClientFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
                    .logout()
                    .logoutSuccessHandler(ssoLogoutSuccessHandler)
                    .logoutRequestMatcher(ssoLogoutUrlMatcher)
                    .and().formLogin().loginPage("/common/error/401")
                    .and().exceptionHandling().accessDeniedPage("/common/error/401");

//            http
//                    .csrf().disable()
//                    .authorizeRequests()
//                    .antMatchers("/").permitAll()
//                    .antMatchers("/index").permitAll()
//                    .antMatchers("/invitations/*").permitAll()
//                    .antMatchers("/main").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
//                    .antMatchers("/org/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
//                    .antMatchers("/space/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
//                    .antMatchers("/app/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
//                    .antMatchers("/user/authResetPassword").permitAll()
//                    .antMatchers("/user/authPassword").permitAll()
//                    .antMatchers("/user/authUser").permitAll()
//                    .antMatchers("/user/authErrorUser").permitAll()
//                    .antMatchers("/user/resetPassword").permitAll()
//                    .antMatchers("/user/addUser").permitAll()
//                    .antMatchers("/user/authUpdateUser").permitAll()
//                    .antMatchers("/requestEmailAuthentication").permitAll()
//                    .antMatchers("/user/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
//                    .antMatchers("/main/userPage").access("hasRole('ROLE_USER')")
//                    .antMatchers("/main/adminPage").access("hasRole('ROLE_ADMIN')")
//                    .and()
//                    .formLogin().loginPage("/login")
//                    .defaultSuccessUrl("/org/orgMain")
//                    .failureUrl("/login?error")
//                    .usernameParameter("id").passwordParameter("password")
//                    .and()
//                    .addFilterBefore(ssoClientContextFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
//                    .addFilterBefore(ssoSocialClientFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
//                    .logout()
//                    .logoutSuccessUrl("/index")
//                    .addLogoutHandler(new SsoLogoutHandler())
//                    .logoutSuccessHandler(ssoLogoutSuccessHandler)
//                    .logoutRequestMatcher(ssoLogoutUrlMatcher)
//                    .deleteCookies("JSESSIONID")
//                    .invalidateHttpSession(true)
//                    .and()
//                    .exceptionHandling().accessDeniedPage("/login");
        }
    }
}
