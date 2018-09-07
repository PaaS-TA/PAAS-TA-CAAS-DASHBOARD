package org.paasta.caas.dashboard.users;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.common.TemplateService;
import org.paasta.caas.dashboard.roles.Roles;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    private final TemplateService templateService;

    private static final Logger LOGGER = LoggerFactory.getLogger(UsersService.class);
    /**
     * Instantiates a new User service.
     *
     * @param restTemplateService the rest template service
     * @param templateService
     */
    @Autowired
    public UsersService(RestTemplateService restTemplateService, TemplateService templateService) {this.restTemplateService = restTemplateService;
        this.templateService = templateService;
    }

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
        // Todo 세션을 지우는 서비스를 탄다.(refreshSession)

        String userName = user.getUserId();
        String userId[] = userName.split("@");
        String realUserName = (userId[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase();

        Map<String, Object> model = new HashMap<>();
        model.put("spaceName", user.getCaasNamespace());
        model.put("userName", realUserName);
        model.put("roleName", user.getCaasNamespace() + "-" + realUserName + "-role");
        String roleYml = null;
        String roleBindingYml = null;
        String resultCode = null;
        String resultCodeBinding = null;

        Roles roles = null;

        // 1. roleSetCode 가 뭐 인지 확인 후 role-name 찾아서 해당 role.ftl 로 replace 해준다.
        if(user.getRoleSetCode().equals("RS0001")){
            roleYml = templateService.convert("instance/create_admin_role.ftl", model);
            resultCode = restTemplateService.send(Constants.TARGET_CAAS_API, "/roles/namespaces/" + user.getCaasNamespace() + "/roles/" + user.getCaasNamespace() + "-" + realUserName + "-role", HttpMethod.PUT, roleYml, String.class);
        }else if(user.getRoleSetCode().equals("RS0002")){
            roleYml = templateService.convert("instance/create_regular_role.ftl", model);
            resultCode = restTemplateService.send(Constants.TARGET_CAAS_API, "/roles/namespaces/" + user.getCaasNamespace() + "/roles/" + user.getCaasNamespace() + "-" + realUserName + "-role", HttpMethod.PUT, roleYml, String.class);
        }else if(user.getRoleSetCode().equals("RS0003")){
            roleYml = templateService.convert("instance/create_init_role.ftl", model);
            resultCode = restTemplateService.send(Constants.TARGET_CAAS_API, "/roles/namespaces/" + user.getCaasNamespace() + "/roles/" + user.getCaasNamespace() + "-" + realUserName + "-role", HttpMethod.PUT, roleYml, String.class);
        }

        LOGGER.info("role.ftl 는???? {}", roleYml);



        // 2. 해당 role-binding 찾아서 바꿔 준 role-name 넣어줘서 rolebinding replace 해준다.
        roleBindingYml = templateService.convert("instance/create_roleBinding.ftl", model);
        resultCodeBinding = restTemplateService.send(Constants.TARGET_CAAS_API, "/roleBindings/namespaces/" + user.getCaasNamespace() + "/rolebindings/" + user.getCaasNamespace() + "-" + realUserName + "-role-binding", HttpMethod.PUT, roleBindingYml, String.class);



        // 3. DB 의 role 변경
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL+"/serviceInstanceId/" + serviceInstanceId + "/organizationGuid/" + organizationGuid + "/userId/" + user.getUserId(), HttpMethod.POST, user, Users.class);
    }

    public Users deleteUserByServiceInstanceId(Users user) {
        // Todo.. 나중에 어디서든 삭제하다 에러가 날 시 rollback 을 어떻게 할 지 로직 수정해야 함.

        String userName = user.getUserId();
        String userId[] = userName.split("@");
        String roleName = (userId[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase();

        // role binding 삭제
        String successRoleBinding = restTemplateService.send(Constants.TARGET_CAAS_API, "/roleBindings/namespaces/" + user.getCaasNamespace() + "/rolebindings/" + user.getCaasNamespace() + "-" + roleName + "-role-binding", HttpMethod.DELETE, null, String.class);
        System.out.println("######################## 와댜댜댜댜댜1 : " + successRoleBinding);

        // role 삭제
        String successRole = restTemplateService.send(Constants.TARGET_CAAS_API, "/roles/namespaces/" + user.getCaasNamespace() + "/roles/" + user.getCaasNamespace() + "-" + roleName + "-role", HttpMethod.DELETE, null, String.class);
        System.out.println("######################## 와댜댜댜댜댜2 : " + successRole);

        // service account 삭제
        String successServiceAccount = restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL +"/namespaces/" + user.getCaasNamespace() + "/serviceaccounts/" + user.getCaasAccountName(), HttpMethod.DELETE, null, String.class);
        System.out.println("######################## 와댜댜댜댜댜3 : " + successServiceAccount);

        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.DELETE, user, Users.class);
    }
}
