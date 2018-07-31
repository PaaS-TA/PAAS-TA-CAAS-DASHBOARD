package org.paasta.caas.dashboard.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Extension of {@link OAuth2AuthenticationDetails} providing extra details about the current
 * user and his grant to manage the current service instance.
 *
 * @author Sebastien Gerard
 */
@SuppressWarnings("serial")
public class SsoAuthenticationDetails extends OAuth2AuthenticationDetails {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationDetails.class);

    private final String token_id;
    private String userid;
    private String username;
    private String imgPath;

    private OAuth2AccessToken accessToken;
    private List<GrantedAuthority> authorities;


    /**
     * Records the access token value and remote address and will also set the session Id if a session already exists
     * (it won't create one).
     * @param request that the authentication request was received from
     * @param token_id
     */
    public SsoAuthenticationDetails(HttpServletRequest request, String token_id, String userid) {
        super(request);
        this.token_id = token_id;
        this.userid = userid;
    }

    public String getToken_id() {
        return token_id;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }




    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public OAuth2AccessToken getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(OAuth2AccessToken accessToken) {
        this.accessToken = accessToken;
    }

    public List<GrantedAuthority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<GrantedAuthority> authorities) {
        this.authorities = authorities;
    }
}
