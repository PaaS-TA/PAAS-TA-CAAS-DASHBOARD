package org.paasta.caas.dashboard.security;

import org.paasta.caas.dashboard.config.security.userdetail.CustomUserDetailsService;
import org.paasta.caas.dashboard.config.security.userdetail.User;
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
        Collection<? extends GrantedAuthority> role = null;
        User user = null;


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
            customUserDetailsService.setToken(ssoAuthenticationDetails.getAccessToken().getValue());

            user = (User) customUserDetailsService.loadUserBySsoAuthenticationDetails(ssoAuthenticationDetails);
            role = user.getAuthorities();
//            LOGGER.info("uaa user guid : "+ssoAuthenticationDetails.getId());
//            LOGGER.info("uaa user token : "+ssoAuthenticationDetails.getAccessToken().toString());
            ssoAuthenticationDetails.setUsername(user.getUsername());
            ssoAuthenticationDetails.setImgPath(user.getImgPath());
            ssoAuthenticationDetails.setServiceInstanceId(user.getServiceInstanceId());
            ssoAuthenticationDetails.setOrganizationGuid(user.getOrganizationGuid());
            ssoAuthenticationDetails.setSpaceGuid(user.getSpaceGuid());
            ssoAuthenticationDetails.setNameSpace(user.getNameSpace());
            authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(ssoAuthenticationDetails.getUserid(), "N/A", role));
            ((OAuth2Authentication) authentication).setDetails(ssoAuthenticationDetails);

            // TODO :: DB 조회 - 권한 조회하여 Session에 저장
            // 1. 위 user 객체의 name / serviceInstanceId 로 user table에서 사용자 조회
            // 2. (JPA로 JOIN이 용이하지 않을시) 1의 결과값 rule_set_code 으로, rule_set 리스트 조회
            // 3. 2의 결과 리스트를 session에 저장

            LOGGER.info(((SsoAuthenticationDetails) details).getAccessToken().getValue());
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