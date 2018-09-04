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

    /**
     * Gets user
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param userId the userId
     * @return the user
     */
    public Users getUserByServiceInstanceId(String serviceInstanceId, String organizationGuid, String userId) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL+"/serviceInstanceId/" + serviceInstanceId + "/organizationGuid/" + organizationGuid + "/userId/" + userId, HttpMethod.GET, null, Users.class);
    }

    /**
     * Update role of user
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param user the user
     * @return the user
     */
    public Users updateUserRole(String serviceInstanceId, String organizationGuid, Users user) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL+"/serviceInstanceId/" + serviceInstanceId + "/organizationGuid/" + organizationGuid + "/userId/" + user.getUserId(), HttpMethod.POST, user, Users.class);
    }

    public Users deleteUserByServiceInstanceId(Users user) {
        // Todo.. 나중에 custom role 이 생기면 role 도 삭제해야함.

        String userName = user.getUserId();
        String userId[] = userName.split("@");
        String roleName = (userId[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase();

        // role binding 삭제
        String successRoleBinding = restTemplateService.send(Constants.TARGET_CAAS_API, "/roleBindings/namespaces/" + user.getCaasNamespace() + "/rolebindings/" + user.getCaasNamespace() + "-" + roleName + "-role-binding", HttpMethod.DELETE, null, String.class);
        System.out.println("######################## 와댜댜댜댜댜1 : " + successRoleBinding);
        // service account 삭제
        String successServiceAccount = restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL +"/namespaces/" + user.getCaasNamespace() + "/serviceaccounts/" + user.getCaasAccountName(), HttpMethod.DELETE, null, String.class);
        System.out.println("######################## 와댜댜댜댜댜2 : " + successServiceAccount);

        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.DELETE, user, Users.class);
    }
}
