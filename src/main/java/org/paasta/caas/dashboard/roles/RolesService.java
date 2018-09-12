package org.paasta.caas.dashboard.roles;

import com.google.gson.Gson;
import org.codehaus.jackson.map.ObjectMapper;
import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.common.model.Users;
import org.paasta.caas.dashboard.config.security.userdetail.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.List;

/**
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Service
public class RolesService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RolesService.class);
    private static final String REQ_URL = "/roles";
    private final RestTemplateService restTemplateService;
    private final CommonService commonService;


    @Autowired
    public RolesService(RestTemplateService restTemplateService, CommonService commonService) {
        this.restTemplateService = restTemplateService;
        this.commonService = commonService;
    }

    /**
     * Gets role list (특정 네임스페이스에서 조회)
     *
     * @return the role list
     */
    public RolesList getRoleList() {
        // url :: /cluster/namespaces/{namespace}/roles
        return restTemplateService.send(Constants.TARGET_CAAS_API,REQ_URL, HttpMethod.GET, null, RolesList.class);
    }
//
//    /**
//     * Gets role (특정 네임스페이스에서 조회)
//     *
//     * @param roleName the role name
//     * @return the role
//     */
//    public Roles getRole(String roleName) {
//        return restTemplateService.send(Constants.TARGET_CAAS_API,REQ_URL + "/" + roleName, HttpMethod.GET, null, Roles.class);
//    }

    /*public List<Roles> getRolesList(String roleSetCode, HttpServletRequest request) {
        List<Roles> rolesList = restTemplateService.send(Constants.TARGET_COMMON_API,REQ_URL + "/" + roleSetCode, HttpMethod.GET, null, List.class);
        setRolesList(rolesList, request);
        return rolesList;
    }*/


    /**
     * 사용자가 처음 들어올 때 권한을 설정해준다.
     *
     * @param user
     */
    public void setRolesListFirst(User user){
        ObjectMapper mapper = new ObjectMapper();
        //RestTemplateService restTemplateService = new RestTemplateService()
        Users users = (Users) restTemplateService.send(Constants.TARGET_COMMON_API,"/users/serviceInstanceId/"+ user.getServiceInstanceId() + "/organizationGuid/" + user.getOrganizationGuid() + "/userId/" + user.getUsername(), HttpMethod.GET, null, Users.class);

        LOGGER.info("users 는 :::: {}", users.toString());
        LOGGER.info("role_set_code 는 :::: {}", users.getRoleSetCode());


        // users.getRoleSetCode()로 role_set_code 목록을 불러온다.

        List<Roles> rolesList = restTemplateService.send(Constants.TARGET_COMMON_API, "/roles/" + users.getRoleSetCode(), HttpMethod.GET, null, List.class);
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        HttpSession session = request.getSession();

        for(int index =0; index < rolesList.size(); index++){
            Roles resultRole = mapper.convertValue(rolesList.get(index), Roles.class);
            session.setAttribute("RS_" + (resultRole.getResourceCode()).toUpperCase() + "_" + (resultRole.getVerbCode()).toUpperCase(),"TRUE");
            LOGGER.info("role set code는 :::: {}", resultRole.getCreated());
        }
    }


    /**
     * 권한이 변경되었을 때 변경된 권한 대로 세션을 다시 설정해준다.
     *
     * @param rsCode
     */
    public void setRolesListAfter(String rsCode){
        ObjectMapper mapper = new ObjectMapper();

        List<Roles> rolesList = restTemplateService.send(Constants.TARGET_COMMON_API, "/roles/" + rsCode, HttpMethod.GET, null, List.class);
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        HttpSession session = request.getSession();

        for(int index =0; index < rolesList.size(); index++){
            Roles resultRole = mapper.convertValue(rolesList.get(index), Roles.class);
            session.setAttribute("RS_" + (resultRole.getResourceCode()).toUpperCase() + "_" + (resultRole.getVerbCode()).toUpperCase(),"TRUE");
            LOGGER.info("role set code는 :::: {}", resultRole.getCreated());
        }

    }
}
