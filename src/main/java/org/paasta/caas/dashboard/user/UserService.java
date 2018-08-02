package org.paasta.caas.dashboard.user;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * The type User service.
 */
@Service
public class UserService {

    private static final String REQ_URL = "/user";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new User service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public UserService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Gets user list.
     *
     * @return the user list
     */
    List<User> getUserList() {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.GET, null, List.class);
    }

}
