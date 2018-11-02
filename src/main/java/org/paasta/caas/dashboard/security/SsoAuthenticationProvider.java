package org.paasta.caas.dashboard.security;

import org.paasta.caas.dashboard.config.security.userdetail.CustomUserDetailsService;
import org.paasta.caas.dashboard.config.security.userdetail.User;
import org.paasta.caas.dashboard.roles.RolesService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Collection;


public class SsoAuthenticationProvider implements AuthenticationProvider {
    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationProvider.class);

    private final CustomUserDetailsService customUserDetailsService;



    public SsoAuthenticationProvider(CustomUserDetailsService customUserDetailsService){
        this.customUserDetailsService = customUserDetailsService;
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        final Object details = authentication.getDetails();
        LOGGER.info("############### authenticate in!!!!!!!!!!");
        Collection<? extends GrantedAuthority> role;
        User user;

        if (!(details instanceof SsoAuthenticationDetails)) {
            throw new InternalAuthenticationServiceException("The authentication details [" + details
                    + "] are not an instance of " + SsoAuthenticationDetails.class.getSimpleName());
        }

        try {
            /*
             *   SSO 를 통해서 들어온 정보를 이용하여, PaasTa DB상에 사용자 정보를 취득한다.
             *   취득후 사용자 롤을 이용하여, 권한을 부여한다.
             */
            SsoAuthenticationDetails ssoAuthenticationDetails = (SsoAuthenticationDetails) details;
            String accessToken = ssoAuthenticationDetails.getAccessToken().getValue();
            LOGGER.info("AccessToken : "+accessToken);

            customUserDetailsService.setToken(accessToken);

            user = (User) customUserDetailsService.loadUserBySsoAuthenticationDetails(ssoAuthenticationDetails);
            role = user.getAuthorities();

            ssoAuthenticationDetails.setUsername(user.getUsername());
            ssoAuthenticationDetails.setImgPath(user.getImgPath());
            ssoAuthenticationDetails.setServiceInstanceId(user.getServiceInstanceId());
            ssoAuthenticationDetails.setOrganizationGuid(user.getOrganizationGuid());
            ssoAuthenticationDetails.setSpaceGuid(user.getSpaceGuid());
            ssoAuthenticationDetails.setNameSpace(user.getNameSpace());

            authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(ssoAuthenticationDetails.getUserId(), "N/A", role));
            ((OAuth2Authentication) authentication).setDetails(ssoAuthenticationDetails);


            // 권한 변경 시 세션 처리를 위한 로직. custom_user_role 이름으로 user 객체 저장해서 ClusterOverviewController 에서 사용함.
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

            HttpSession session = request.getSession();
            session.setAttribute("custom_user_role",user);

            LOGGER.info("############### authenticate out!!!!!!!!!!");

        } catch(UsernameNotFoundException e) {
            LOGGER.info(e.toString());
            throw new UsernameNotFoundException(e.getMessage());
        } catch(BadCredentialsException e) {
            LOGGER.info(e.toString());
            throw new BadCredentialsException(e.getMessage());
        } catch(Exception e) {
            LOGGER.info(e.toString());
        }

        return authentication;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return OAuth2Authentication.class.isAssignableFrom(authentication);
    }
}