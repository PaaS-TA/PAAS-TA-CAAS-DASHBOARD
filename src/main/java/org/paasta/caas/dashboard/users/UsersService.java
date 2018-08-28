package org.paasta.caas.dashboard.users;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
@Service
public class UsersService {

    private static final String REQ_URL = "/users";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new User service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public UsersService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Gets user list.
     *
     * @return the user list
     */
    public List<Users> getUsesListByServiceInstanceId(String serviceInstanceId, String organizationGuid) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL+"/serviceInstanceId/" + serviceInstanceId + "/organizationGuid/" + organizationGuid, HttpMethod.GET, null, List.class);
    }

}
