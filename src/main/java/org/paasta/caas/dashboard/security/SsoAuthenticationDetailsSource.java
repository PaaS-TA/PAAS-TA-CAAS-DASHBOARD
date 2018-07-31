package org.paasta.caas.dashboard.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * {@link AuthenticationDetailsSource} providing extra details about the current
 * user and his grant to manage the current service instance.
 *
 * @author Sebastien Gerard
 */
public class SsoAuthenticationDetailsSource
        implements AuthenticationDetailsSource<HttpServletRequest, OAuth2AuthenticationDetails> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationDetailsSource.class);

    private final RestTemplate restTemplate;
    private final String userInfoUrl;

    protected static String getUserId(Map<String, String> map) {
        if (map.containsKey("user_name")) {
            return map.get("user_name");
        }
        return null;
    }


    protected static String getUserName(Map<String, String> map) {
        if (map.containsKey("user_name")) {
            return map.get("user_name");
        }
        return null;
    }



    /**
     * @param restTemplate the template to use to contact Cloud components
     * @param userInfoUrl the URL used to get the current OAuth user details
     */
    public SsoAuthenticationDetailsSource(RestTemplate restTemplate,
                                          String userInfoUrl) {
        this.restTemplate = restTemplate;
        this.userInfoUrl = userInfoUrl;
    }

    @Override
    public SsoAuthenticationDetails buildDetails(HttpServletRequest request) {

        Map<String, String> uaaUserInfo = null;
        try {
            uaaUserInfo = restTemplate.getForObject(userInfoUrl, Map.class);
        } catch (RestClientException e) {
            LOGGER.error("Error while user full name from [" + userInfoUrl + "].", e);
        }

        String token_id = uaaUserInfo.get("user_id");
        SsoAuthenticationDetails authenticationDetails = new SsoAuthenticationDetails(request, token_id, getUserId(uaaUserInfo));
        authenticationDetails.setAccessToken(((OAuth2RestTemplate) restTemplate).getAccessToken());

        return authenticationDetails;

    }
}
