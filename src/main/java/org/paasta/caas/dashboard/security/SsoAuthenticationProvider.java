package org.paasta.caas.dashboard.security;

/**
 * 스프링 시큐리티의 사용자 인증방식을 구현한 클래스
 * 기존의 id를 이용하여 Password를 비교하여 인증하는 방식대신
 * PaaS-TA API의 Login 을 사용하여 인증하도록 수정하였다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-05-12
 */
//import org.openpaas.paasta.common.security.userdetails.User;
//import org.openpaas.paasta.portal.web.user.config.security.userdetail.CustomUserDetailsService;
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
/*

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
*/

	/**
	 * 로그인 폼에서 입력받은 id와 password를 이용하여 사용자 인증을 수행하는 메소드
	 *
	 * @param authentication
	 * @return Authentication 사용자 인증정보
	 * @throws AuthenticationException
	 */
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
            user = (User) customUserDetailsService.loadUserByUsername(ssoAuthenticationDetails.getUserid());

            role = user.getAuthorities();
            ssoAuthenticationDetails.setUsername(user.getUsername());
            ssoAuthenticationDetails.setImgPath(user.getImgPath());
            authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(ssoAuthenticationDetails.getUserid(), "N/A", role));
            ((OAuth2Authentication) authentication).setDetails(ssoAuthenticationDetails);
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