package org.paasta.caas.dashboard.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

import static java.lang.System.out;
import static java.lang.System.setOut;

/**
 * {@link AuthenticationDetailsSource} providing extra details about the current
 * user and his grant to manage the current service instance.
 *
 * @author Sebastien Gerard
 */
public class SsoAuthenticationDetailsSource
        implements AuthenticationDetailsSource<HttpServletRequest, OAuth2AuthenticationDetails> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SsoAuthenticationDetailsSource.class);

    /**
     * Token to use in {@link #getCheckUrl(String serviceInstanceId)} to specify the service instance id.
     */
    public static final String TOKEN_SUID = "[SUID]";

    public static final String MANAGED_KEY = "manage";

    private final RestTemplate restTemplate;
    private final String userInfoUrl;
    private final String apiUrl;

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
                                          String userInfoUrl, String apiUrl) {
        this.restTemplate = restTemplate;
        this.userInfoUrl = userInfoUrl;
        this.apiUrl = apiUrl;
    }

    @Override
    public SsoAuthenticationDetails buildDetails(HttpServletRequest request) {
        LOGGER.info("** buildDetails");
        String serviceInstanceId = "";

        Map<String, String> uaaUserInfo = null;
        try {
            uaaUserInfo = restTemplate.getForObject(userInfoUrl, Map.class);
            LOGGER.info(uaaUserInfo.toString());
        } catch (RestClientException e) {
            LOGGER.error("Error while user full name from [" + userInfoUrl + "].", e);
            return null;
        }

        String id = uaaUserInfo.get("user_id");
        String userid = uaaUserInfo.get("user_name");
        SsoAuthenticationDetails authenticationDetails = new SsoAuthenticationDetails(request, id, userid);
        authenticationDetails.setManagingServiceInstance(serviceInstanceId);
        authenticationDetails.setAccessToken(((OAuth2RestTemplate) restTemplate).getAccessToken());

        return authenticationDetails;

    }

    /**
     * Checks whether the user is allowed to manage the current service instance.
     */
    private boolean isManagingApp(String serviceInstanceId) {
        final String url = getCheckUrl(serviceInstanceId);
        try {
            LOGGER.info("URL : " + url);
            final Map<?, ?> result = restTemplate.getForObject(url, Map.class);
            LOGGER.info(result.toString());
            return true;
//            return Boolean.TRUE.toString().equals(result.get(MANAGED_KEY).toString().toLowerCase());
        } catch (RestClientException e) {
            LOGGER.error("Error while retrieving authorization from [" + url + "].", e);
            return false;
        }
    }

    /**
     * Returns the URL used to check whether the current user is allowed
     * to access the current service instance.
     */
    private String getCheckUrl(String serviceInstanceId) {
        return apiUrl.replace(TOKEN_SUID, serviceInstanceId);
    }
}
