package org.paasta.caas.dashboard.users;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.PropertyService;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.common.TemplateService;
import org.paasta.caas.dashboard.config.security.userdetail.User;
import org.paasta.caas.dashboard.refreshSession.RefreshSessionService;
import org.paasta.caas.dashboard.roles.Roles;
import org.paasta.caas.dashboard.roles.RolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * User Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
@Service
public class UsersService {

    private final RestTemplateService restTemplateService;
    private final TemplateService templateService;
    private final RefreshSessionService refreshSessionService;
    private final RolesService rolesService;
    private final PropertyService propertyService;


    /**
     * Instantiates a new User service.
     * @param restTemplateService the rest template service
     * @param templateService the template service
     * @param refreshSessionService the refresh session service
     * @param rolesService the role service
     * @param propertyService the property service
     */
    @Autowired
    public UsersService(RestTemplateService restTemplateService, TemplateService templateService, RefreshSessionService refreshSessionService, RolesService rolesService, PropertyService propertyService) {this.restTemplateService = restTemplateService;
        this.templateService = templateService;
        this.refreshSessionService = refreshSessionService;
        this.rolesService = rolesService;
        this.propertyService = propertyService;
    }

    /**
     * User 목록을 조회한다.
     *
     * @return the user list
     */
    UsersList getUsesListByServiceInstanceId(String serviceInstanceId, String organizationGuid) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, Constants.URI_COMMON_API_USERS_LIST
                .replace("{serviceInstanceId:.+}", serviceInstanceId)
                .replace("{organizationGuid:.+}", organizationGuid), HttpMethod.GET, null, UsersList.class);
    }

    /**
     * User 상세 정보를 조회한다.
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param userId the userId
     * @return the user
     */
    Users getUserByServiceInstanceId(String serviceInstanceId, String organizationGuid, String userId) {
        Users users = restTemplateService.send(Constants.TARGET_COMMON_API, Constants.URI_COMMON_API_USERS_DETAIL
                .replace("{serviceInstanceId:.+}", serviceInstanceId)
                .replace("{organizationGuid:.+}", organizationGuid)
                .replace("{userId:.+}", userId), HttpMethod.GET, null, Users.class);
        users.setCaasUrl(propertyService.getCaasUrl());
        users.setCaasClusterName(propertyService.getCaasClusterName());
        return users;
    }

    /**
     * User 의 권한을 변경한다.
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param user the user
     * @return the user
     */
    Users updateUserRole(String serviceInstanceId, String organizationGuid, Users user) {

        HttpServletRequest request = ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
        HttpSession session = request.getSession();

        // Security User 객체
        User accessUser = (User)session.getAttribute("custom_user_role");

        // DB 용 User 객체
        Users users = new Users();
        users.setRoleSetCode(user.getRoleSetCode());

        // 현재 접속되어 있는 사람과 권한 바꾸는 사람이 일치할 경우 세션 지우고 다시 세션 설정해주는 로직.
        if(accessUser.getUsername().equals(user.getUserId())){
            refreshSessionService.removeRolesSession(request);
            rolesService.setRolesListAfter(user.getRoleSetCode());
        }

        // 아래부터는 직접적으로 권한 변경 로직 시작.
        String userName = user.getUserId();
        String userId[] = userName.split("@");
        String realUserName = (userId[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase();

        Map<String, Object> model = new HashMap<>();
        model.put("spaceName", user.getCaasNamespace());
        model.put("userName", user.getCaasAccountName());
        model.put("roleName", user.getCaasNamespace() + "-" + realUserName + "-role");
        String roleYml = null;
        String roleBindingYml = null;
        String resultCode = null;
        String resultCodeBinding = null;

        Roles roles = null;

        String rolesName = user.getCaasNamespace() + "-" + realUserName + "-role";
        String roleBindingsName = user.getCaasNamespace() + "-" + realUserName + "-role-binding";

        // 1. roleSetCode 가 뭐 인지 확인 후 role-name 찾아서 해당 role.ftl 로 replace 해준다.
        if(user.getRoleSetCode().equals(propertyService.getAdministratorCode())){
            roleYml = templateService.convert("instance/create_admin_role.ftl", model);
        }else if(user.getRoleSetCode().equals(propertyService.getRegularUserCode())){
            roleYml = templateService.convert("instance/create_regular_role.ftl", model);
        }else if(user.getRoleSetCode().equals(propertyService.getInitUserCode())){
            roleYml = templateService.convert("instance/create_init_role.ftl", model);
        }

        resultCode = restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_ROLES_DETAIL
                .replace("{namespace:.+}", user.getCaasNamespace())
                .replace("{roleName:.+}", rolesName) , HttpMethod.PUT, roleYml, String.class);

        // 2. 해당 role-binding 찾아서 바꿔 준 role-name 넣어줘서 rolebinding replace 해준다.
        roleBindingYml = templateService.convert("instance/create_roleBinding.ftl", model);

        resultCodeBinding = restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_ROLE_BINDINGS_DETAIL
                .replace("{namespace:.+}", user.getCaasNamespace())
                .replace("{roleBindingName:.+}", roleBindingsName), HttpMethod.PUT, roleBindingYml, String.class);


        // 3. DB 의 role 변경
        return restTemplateService.send(Constants.TARGET_COMMON_API, Constants.URI_COMMON_API_USERS_DETAIL
                .replace("{serviceInstanceId:.+}", serviceInstanceId)
                .replace("{organizationGuid:.+}", organizationGuid)
                .replace("{userId:.+}", user.getUserId()), HttpMethod.POST, user, Users.class);
    }


    /**
     * User 를 삭제한다.
     *
     * @param user the user
     * @return the Users
     */
    Users deleteUserByServiceInstanceId(Users user) {
        HttpServletRequest request = ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
        HttpSession session = request.getSession();

        // Security User 객체
        User accessUser = (User)session.getAttribute("custom_user_role");

        // 현재 접속되어 있는 사람과 삭제되는 사람이 일치할 경우 세션 지우기.
        if(accessUser.getUsername().equals(user.getUserId())){
            SecurityContextHolder.clearContext();
        }

        // Todo.. 나중에 어디서든 삭제하다 에러가 날 시 rollback 을 어떻게 할 지 로직 수정해야 함.

        String userName = user.getUserId();
        String userId[] = userName.split("@");
        String realName = (userId[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase();

        String rolesName = user.getCaasNamespace() + "-" + realName + "-role";
        String roleBindingsName = user.getCaasNamespace() + "-" + realName + "-role-binding";

        // role binding 삭제
        String successRoleBinding = restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_ROLE_BINDINGS_DETAIL
                .replace("{namespace:.+}", user.getCaasNamespace())
                .replace("{roleBindingName:.+}", roleBindingsName), HttpMethod.DELETE, null, String.class);

        // role 삭제
        String successRole = restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_ROLES_DETAIL
                .replace("{namespace:.+}", user.getCaasNamespace())
                .replace("{roleName:.+}", rolesName), HttpMethod.DELETE, null, String.class);

        // service account 삭제
        String successServiceAccount = restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_SERVICE_ACCOUNT_DETAIL
                .replace("{namespace:.+}", user.getCaasNamespace())
                .replace("{caasAccountName:.+}", user.getCaasAccountName()), HttpMethod.DELETE, null, String.class);

        return restTemplateService.send(Constants.TARGET_COMMON_API, Constants.URI_COMMON_API_USERS_DETAIL
                .replace("{serviceInstanceId:.+}", user.getServiceInstanceId())
                .replace("{organizationGuid:.+}", user.getOrganizationGuid())
                .replace("{userId:.+}", user.getUserId()), HttpMethod.DELETE, null, Users.class);
    }
}
