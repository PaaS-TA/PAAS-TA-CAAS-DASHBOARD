package org.paasta.caas.dashboard.roles;

import org.codehaus.jackson.map.ObjectMapper;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.config.security.userdetail.User;
import org.paasta.caas.dashboard.users.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Objects;

/**
 * Roles service 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Service
public class RolesService {

    private static final String REQ_URL = "/roles";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Roles service
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public RolesService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     * Roles 목록을 조회한다.
     *
     * @return the roles list
     */
    RolesList getRoleList() {
        // url :: /cluster/namespaces/{namespace}/roles
        return restTemplateService.send(Constants.TARGET_CAAS_API,REQ_URL, HttpMethod.GET, null, RolesList.class);
    }


    /**
     * 사용자가 처음 들어올 때 권한을 설정해준다.
     *
     * @param user the user
     */
    public void setRolesListFirst(User user){
        ObjectMapper mapper = new ObjectMapper();

        Users users = restTemplateService.send(Constants.TARGET_COMMON_API,Constants.URI_COMMON_API_USERS_DETAIL
                .replace("{serviceInstanceId:.+}", user.getServiceInstanceId())
                .replace("{organizationGuid:.+}", user.getOrganizationGuid())
                .replace("{userId:.+}", user.getUsername()), HttpMethod.GET, null, Users.class);

        // users.getRoleSetCode()로 role_set_code 목록을 불러온다.
        RolesList rolesList = restTemplateService.send(Constants.TARGET_COMMON_API, Constants.URI_COMMON_API_ROLES_LIST
                .replace("{roleSetCode:.+}", users.getRoleSetCode()), HttpMethod.GET, null, RolesList.class);
        HttpServletRequest request = ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();

        HttpSession session = request.getSession();

        for (Object aRolesList : rolesList.getItems()) {
            Roles resultRole = mapper.convertValue(aRolesList, Roles.class);
            session.setAttribute("RS_" + (resultRole.getResourceCode()).toUpperCase() + "_" + (resultRole.getVerbCode()).toUpperCase(), "TRUE");
        }
    }


    /**
     * 권한이 변경되었을 때 변경된 권한 대로 세션을 다시 설정해준다.
     *
     * @param rsCode the rsCode
     */
    public void setRolesListAfter(String rsCode){
        ObjectMapper mapper = new ObjectMapper();

        RolesList rolesList = restTemplateService.send(Constants.TARGET_COMMON_API, Constants.URI_COMMON_API_ROLES_LIST
                .replace("{roleSetCode:.+}", rsCode), HttpMethod.GET, null, RolesList.class);
        HttpServletRequest request = ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();

        HttpSession session = request.getSession();

        for (Object aRolesList : rolesList.getItems()) {
            Roles resultRole = mapper.convertValue(aRolesList, Roles.class);
            session.setAttribute("RS_" + (resultRole.getResourceCode()).toUpperCase() + "_" + (resultRole.getVerbCode()).toUpperCase(), "TRUE");
        }

    }
}
