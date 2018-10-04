package org.paasta.caas.dashboard.config.security;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.security.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.oauth2.client.DefaultOAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.filter.OAuth2ClientContextFilter;
import org.springframework.security.oauth2.client.token.AccessTokenRequest;
import org.springframework.security.oauth2.client.token.DefaultAccessTokenRequest;
import org.springframework.security.oauth2.client.token.grant.code.AuthorizationCodeResourceDetails;
import org.springframework.security.oauth2.provider.token.*;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.Enumeration;

import static java.util.Arrays.asList;

/**
 * SsoSecurityConfiguration 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@Configuration
public class SsoSecurityConfiguration {
    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationDetailsSource.class);

    public static String isManagingApp() {
        return "(authentication.details != null) " +
                "and (authentication.details instanceof T(" + SsoAuthenticationDetails.class.getName() + ")) "
                + "and authentication.details.managingService ";
    }

    private String sessionRedirectUrl = "";

    @Value("${cf.uaa.oauth.client.id}")
    private String clientId;

    @Value("${cf.uaa.oauth.client.secret}")
    private String clientSecret;

    @Value("${cf.uaa.oauth.info.uri}")
    private String oauthInfoUrl;

    @Value("${cf.api.url}")
    private String apiUrl;

    @Value("${cf.uaa.oauth.token.check.uri}")
    private String checkTokenUri;

    @Value("${cf.uaa.oauth.authorization.uri}")
    private String authorizationUri;

    @Value("${cf.uaa.oauth.token.access.uri}")
    private String accessUri;

    @Value("${cf.uaa.oauth.logout.url}")
    private String logoutUrl;

    @Autowired
    @Qualifier("authenticationManager")
    private AuthenticationManager authenticationManager;

    @Autowired
    private HttpServletRequest httpServletRequest;

    @Bean(name = "ssoEntryPointMatcher")
    public RequestMatcher ssoEntryPointMatcher() {
        return new AntPathRequestMatcher(Constants.CAAS_INIT_URI + "/**");
    }

    @Bean(name = "ssoClientContextFilter")
    public SsoFilterWrapper ssoClientContextFilter() {
        // If it was a Filter bean it would be automatically added out of the Spring security filter chain.
        return SsoFilterWrapper.wrap(new OAuth2ClientContextFilter());
    }

    @Bean(name = "ssoSocialClientFilter")
    @Autowired
    public SsoFilterWrapper ssoSocialClientFilter() {
        // If it was a Filter bean it would be automatically added out of the Spring security filter chain.
        final SsoAuthenticationProcessingFilter filter = new SsoAuthenticationProcessingFilter();

        filter.setRestTemplate(ssoRestOperations());
        filter.setTokenServices(ssoResourceServerTokenServices());
        filter.setAuthenticationManager(authenticationManager);
        filter.setRequiresAuthenticationRequestMatcher(ssoEntryPointMatcher());
        filter.setDetailsSource(ssoAuthenticationDetailsSource());
        filter.setAuthenticationSuccessHandler(new SsoAuthenticationSuccessHandler());
        filter.setAuthenticationFailureHandler(new SsoAuthenticationFailureHandler());

        return SsoFilterWrapper.wrap(filter);
    }

    @Bean(name = "ssoProtectedResourceDetails")
    @Scope(value = WebApplicationContext.SCOPE_SESSION)
    @Autowired
    public AuthorizationCodeResourceDetails ssoProtectedResourceDetails() {
        final AuthorizationCodeResourceDetails resourceDetails = new AuthorizationCodeResourceDetails() {
            @Override
            public boolean isClientOnly() {
                return true;
            }
        };
        resourceDetails.setClientId(clientId);
        resourceDetails.setClientSecret(clientSecret);
        resourceDetails.setUserAuthorizationUri(authorizationUri);
        resourceDetails.setAccessTokenUri(accessUri);
        resourceDetails.setScope(asList("openid", "cloud_controller_service_permissions.read", "cloud_controller.read", "cloud_controller.write"));
        resourceDetails.setUseCurrentUri(false);
        resourceDetails.setPreEstablishedRedirectUri(serverDomain(httpServletRequest));
        return resourceDetails;
    }

    @Bean(name = "ssoClientContext")
    @Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public OAuth2ClientContext ssoClientContext() {
        return new DefaultOAuth2ClientContext(ssoAccessTokenRequest());
    }

    @Bean(name = "ssoAccessTokenRequest")
    @Scope(value = WebApplicationContext.SCOPE_REQUEST, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public AccessTokenRequest ssoAccessTokenRequest() {
        final DefaultAccessTokenRequest request = new DefaultAccessTokenRequest(httpServletRequest.getParameterMap());

        final Object currentUri = httpServletRequest.getAttribute(OAuth2ClientContextFilter.CURRENT_URI);
        if (currentUri != null) {
            request.setCurrentUri(currentUri.toString());
        }

        return request;
    }

    @Bean(name = "ssoRestOperations")
    @Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public OAuth2RestTemplate ssoRestOperations() {

        try {
            SSLUtils.turnOffSslChecking();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }


        return new OAuth2RestTemplate(ssoProtectedResourceDetails(), ssoClientContext());
    }

    @Bean(name = "ssoAccessTokenConverter")
    public AccessTokenConverter ssoAccessTokenConverter() {
        final DefaultAccessTokenConverter defaultAccessTokenConverter = new DefaultAccessTokenConverter();
        final DefaultUserAuthenticationConverter userTokenConverter = new DefaultUserAuthenticationConverter();
        userTokenConverter.setDefaultAuthorities(new String[]{"ROLE_" + SsoSecurityConfigAdapter.ROLE_LOGIN});
        defaultAccessTokenConverter.setUserTokenConverter(userTokenConverter);

        return defaultAccessTokenConverter;
    }

    @Bean(name = "ssoResourceServerTokenServices")
    @Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public ResourceServerTokenServices ssoResourceServerTokenServices() {
        final RemoteTokenServices remoteTokenServices = new RemoteTokenServices();

        remoteTokenServices.setClientId(clientId);
        remoteTokenServices.setClientSecret(clientSecret);
        remoteTokenServices.setCheckTokenEndpointUrl(checkTokenUri);
        remoteTokenServices.setAccessTokenConverter(ssoAccessTokenConverter());

        return remoteTokenServices;
    }

    @Bean(name = "ssoAuthenticationDetailsSource")
    @Autowired
    public AuthenticationDetailsSource ssoAuthenticationDetailsSource() {
        return new SsoAuthenticationDetailsSource(ssoRestOperations(), oauthInfoUrl, apiUrl);
    }


    @Bean(name = "ssoLogoutSuccessHandler")
    public LogoutSuccessHandler ssoLogoutSuccessHandler() {
        final SimpleUrlLogoutSuccessHandler logoutSuccessHandler = new SimpleUrlLogoutSuccessHandler();
        logoutSuccessHandler.setRedirectStrategy(new SsoLogoutRedirectStrategy(logoutUrl));

        return logoutSuccessHandler;
    }

    @Bean(name = "ssoLogoutUrlMatcher")
    public RequestMatcher ssoLogoutUrlMatcher() {
        return new AntPathRequestMatcher("/logout");
    }


    private String serverDomain(HttpServletRequest request) {
        String serverDomain = request.getRequestURL().toString();
        try {
            HttpSession session =  request.getSession();
            String forward = session.getAttribute("x-forwarded-proto").toString();
            LOGGER.info("Forward ::::::::: " + forward);
            if (forward != null) {
                serverDomain = serverDomain.replace("http", "").replace("https", "");
                serverDomain = forward + serverDomain;
            }
        }catch (Exception e){

        }
        String uri = request.getRequestURI();
        StringBuffer addParam = new StringBuffer();
        Enumeration<String> paramNames = request.getParameterNames();

        int i = 0;
        while (paramNames.hasMoreElements()) {
            String key = (String) paramNames.nextElement();
            String value = request.getParameter(key);
            LOGGER.info(" RequestParameter Data ==>  " + key + " : " + value + "");
            if(i == 0) {
                addParam.append("?");
            } else {
                addParam.append("&");
            }
            addParam.append(key+"="+value);
            i++;
        }
        if(!addParam.toString().equals("") && !addParam.toString().contains("?code=") && !addParam.toString().contains("&state=")) {
            request.getSession().setAttribute("sessionRedirectUrl",uri+addParam);
            sessionRedirectUrl = uri+addParam;
        } else if(addParam.toString().equals("")) {
            request.getSession().setAttribute("sessionRedirectUrl","");
            sessionRedirectUrl = uri;
        }
        LOGGER.info("sessionRedirectUrl = "+sessionRedirectUrl);
        if(!sessionRedirectUrl.equals("")) {
            request.getSession().setAttribute("sessionRedirectUrl",sessionRedirectUrl);

            if(sessionRedirectUrl.contains("?serviceInstanceId=")) {
                request.getSession().setAttribute("serviceInstanceId", sessionRedirectUrl.substring(sessionRedirectUrl.indexOf("?serviceInstanceId=")+19));
            }
        }

        LOGGER.info("Login ::::::::  " + serverDomain);
        return serverDomain;
    }

}
