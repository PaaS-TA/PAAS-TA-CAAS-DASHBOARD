package org.paasta.caas.dashboard.config.security.userdetail;

//import org.openpaas.paasta.portal.web.user.service.CommonService;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.paasta.caas.dashboard.cf.CfService;
import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.common.TemplateService;
import org.paasta.caas.dashboard.common.model.AdminToken;
import org.paasta.caas.dashboard.common.model.Users;
import org.paasta.caas.dashboard.security.SsoAuthenticationDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class CustomUserDetailsService implements UserDetailsService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CustomUserDetailsService.class);

    @Value("${caas.url}")
    private String caasUrl;

    @Value("${roleSet.initUserCode}")
    private String initUserCode;

    @Value("${caas.admin-token}")
    private String caasAdminToken;

    @Autowired
    private CfService cfService;

//    @Autowired
    private TemplateService templateService;

    private final RestTemplateService restTemplateService;


    private String token;

    private String caas_adminValue;

    public void setToken(String token){
        this.token = token;
    }

    @Autowired
    public CustomUserDetailsService(RestTemplateService restTemplateService, TemplateService templateService) {
        this.restTemplateService = restTemplateService;
        this.templateService = templateService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        List role = new ArrayList();

        LOGGER.info("name : "+username);
        if(username.equals("demo")) {
            role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else {
            role.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        User user = new User(username, "N/A", role);

        return user;
    }

    public UserDetails loadUserBySsoAuthenticationDetails(SsoAuthenticationDetails ssoAuthenticationDetails) {
        List role = new ArrayList();

        LOGGER.info("username : "+ssoAuthenticationDetails.getUserid());
        LOGGER.info("uaaid : "+ssoAuthenticationDetails.getId());
        LOGGER.info("token : "+ssoAuthenticationDetails.getAccessToken());
        LOGGER.info("Instance id : "+ssoAuthenticationDetails.getManagingServiceInstance());

        String username = ssoAuthenticationDetails.getUserid();
        String uaaid = ssoAuthenticationDetails.getId();
        String token = ssoAuthenticationDetails.getAccessToken().toString();
        String serviceInstanceId = ssoAuthenticationDetails.getManagingServiceInstance();

        boolean certificationFlag = false;
        String space_guid = "";
        String organization_guid = "";
        //TODO namespace가 아닌가??
        String spaceName = "";

        Map adminToken = restTemplateService.send(Constants.TARGET_COMMON_API, "/adminToken/"+caasAdminToken, HttpMethod.GET, null, Map.class);

        if(adminToken != null && !adminToken.get("tokenValue").toString().equals("")) {
            caas_adminValue = adminToken.get("tokenValue").toString();

            Map cfResult = cfService.getCfOrgsByUaaId(uaaid, token);

            if(serviceInstanceId != null && !serviceInstanceId.equals("")) {
                Map cfServiceInstancesByIdResult = cfService.getCfServiceInstancesById(serviceInstanceId, token);
                String serviceInstancesByIdResultEntity  = cfServiceInstancesByIdResult.get("entity").toString();
                space_guid =  serviceInstancesByIdResultEntity.substring(serviceInstancesByIdResultEntity.indexOf("space_guid=")+11, serviceInstancesByIdResultEntity.indexOf(", gateway_data="));
                LOGGER.info("space_guid = "+space_guid);

                Map cfServiceByIdResult = cfService.getCfServiceById(space_guid, token);
                String serviceByIdResultEntity  = cfServiceByIdResult.get("entity").toString();
                organization_guid = serviceByIdResultEntity.substring(serviceByIdResultEntity.indexOf("organization_guid=")+18, serviceByIdResultEntity.indexOf(", space_quota_definition_guid="));
                LOGGER.info("organization_guid = "+organization_guid);

                Map cfOrgByIdResult = cfService.getCfOrgById(organization_guid, token);
                String orgName  = cfOrgByIdResult.get("name").toString();
                LOGGER.info("orgName = "+orgName);

                if(cfResult.toString().contains("entity={name="+orgName+",")) {
                    LOGGER.info("org in.");
                    certificationFlag = true;
                }
            }
        }

        if(certificationFlag) {
            LOGGER.info("flag in!");
            List commonGetUsers = restTemplateService.send(Constants.TARGET_COMMON_API, "/users/serviceInstanceId/"+serviceInstanceId+"/organizationGuid/"+organization_guid, HttpMethod.GET, null, List.class);

            spaceName = "paas-"+serviceInstanceId+"-caas";
            LOGGER.info("spaceName : "+spaceName);

//            List commonGetUsers = restTemplateService.send(Constants.TARGET_COMMON_API, "/users/serviceInstanceId/79018229-f37a-44ff-864b-c486eabb3306/organizationGuid/6cb8be0d-67c6-4326-a78d-9a323a13ad19", HttpMethod.GET, null, List.class);
            if(commonGetUsers != null && commonGetUsers.size() > 0) {
                if(commonGetUsers.toString().contains("userId="+username+",")) {
                    role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
                } else {
                    LOGGER.info("start~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                    String tmpString[] = username.split("@");
                    String userName = (organization_guid + "-" + tmpString[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase() + "-user";
                    String roleName = (tmpString[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase();
                    LOGGER.info("userName : "+userName);
                    createUser(spaceName, userName);
                    createRole(spaceName, userName, roleName);
                    createRoleBinding(spaceName, userName, roleName);

                    String cubeToken = getToken(spaceName, userName);
                    LOGGER.info("cubeToken : "+cubeToken);

                    Users user = new Users();
                    user.setUserId(username);
                    user.setServiceInstanceId(serviceInstanceId);
                    user.setCaasNamespace(spaceName);
                    user.setCaasAccountTokenName(cubeToken);
                    user.setCaasAccountName(userName);
                    user.setOrganizationGuid(organization_guid);
                    user.setSpaceGuid(space_guid);
                    user.setRoleSetCode(initUserCode);
                    user.setDescription("user information");
//                    user.setCreated("1");
//                    user.setLastModified("2");
//                    user.setCaasAccountAccessToken("1");
//                    user.setNamespace("2");
//                    user.setRoleName("3");

                    Users commonCreateUser = restTemplateService.send(Constants.TARGET_COMMON_API, "/users", HttpMethod.POST, user, Users.class);
                    LOGGER.info(commonCreateUser.getUserId());
                    LOGGER.info("end!!!");

                    role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
                }
            } else {
                role.add(new SimpleGrantedAuthority("ROLE_USER"));
            }
        } else {
            role.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        User user = new User(username, "N/A", role);
        user.setServiceInstanceId(ssoAuthenticationDetails.getManagingServiceInstance());
        user.setOrganizationGuid(organization_guid);
        user.setSpaceGuid(space_guid);
        user.setNameSpace(spaceName);
        return user;
    }

    /**
     * parameter에 넘어온 userName 값으로 생선된 namespace의 관리자 계정을 생성한다. user명은 web 등에서
     * kubernetes 명명규칙에 맞는 변수가 넘어왔다고 가정한다. instance/create_account.ftl의 변수를 채운 후
     * restTemplateService로 rest 통신한다.
     *
     * @author Hyerin
     * @since 2018.07.30
     */
    public void createUser(String spaceName, String userName) {
        LOGGER.info("createUser spaceName~~ {}", spaceName);
        LOGGER.info("createUser userName~~ {}", userName);

        Map<String, Object> model = new HashMap<>();
        model.put("spaceName", spaceName);
        model.put("userName", userName);
        String yml = null;
        yml = templateService.convert("instance/create_account.ftl", model);

        restTemplateService.cubeSend(caasUrl+"/api/v1/namespaces/" + spaceName + "/serviceaccounts", yml, caas_adminValue, HttpMethod.POST, String.class);
        LOGGER.info("createUser end~~");
    }

    /**
     * 생성된 namespace에 role을 생성한다. role이름은 'namespace명-role' 이다.
     * instance/create_role.ftl의 변수를 채운 후 restTemplateService로 rest 통신한다.
     *
     * @author Hyerin
     * @since 2018.07.30
     */
    public void createRole(String spaceName, String userName, String roleName) {
        LOGGER.info("createRole spaceName~~ {}", spaceName);
        LOGGER.info("createRole userName~~ {}", userName);
        LOGGER.info("createRole roleName~~ {}", roleName);

        Map<String, Object> model = new HashMap<>();
        model.put("spaceName", spaceName);
        model.put("userName", userName);
        model.put("roleName", spaceName + "-" + roleName + "-role");
        String yml = null;
        yml = templateService.convert("instance/create_role.ftl", model);

        try {
            restTemplateService.cubeSend(caasUrl+"/apis/rbac.authorization.k8s.io/v1/namespaces/" + spaceName + "/roles", yml, caas_adminValue, HttpMethod.POST, String.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        LOGGER.info("createRole end~~");
    }

    /**
     * 생성된 namespace에 roleBinding을 생성한다. binding이름은 'namespace명-role-binding' 이다.
     * instance/create_roleBinding.ftl의 변수를 채운 후 restTemplateService로 rest 통신한다.
     *
     * @author Hyerin
     * @since 2018.07.30
     */
    public void createRoleBinding(String spaceName, String userName, String roleName) {
        LOGGER.info("createRoleBinding spaceName~~ {}", spaceName);
        LOGGER.info("createRoleBinding userName~~ {}", userName);
        LOGGER.info("createRoleBinding roleName~~ {}", roleName);

        Map<String, Object> model = new HashMap<>();
        model.put("spaceName", spaceName);
        model.put("userName", userName);
        model.put("roleName", spaceName + "-" + roleName + "-role");
        String yml = null;
        yml = templateService.convert("instance/create_roleBinding.ftl", model);

        try {
            restTemplateService.cubeSend(caasUrl+"/apis/rbac.authorization.k8s.io/v1/namespaces/" + spaceName + "/rolebindings", yml, caas_adminValue, HttpMethod.POST, String.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        LOGGER.info("createRoleBinding end~~");
    }

    /**
     * 생성한 유저의 토큰값을 가져온다.
     * JSON형태로 값이 넘어오니까 파싱하는 로직이 포함되어 있다.
     *
     * @author Hyerin
     * @since 2018.07.30
     */
    public String getToken(String spaceName, String userName) {
        LOGGER.info("getToken spaceName~~ {}", spaceName);
        LOGGER.info("getToken userName~~ {}", userName);

        String jsonObj = restTemplateService.cubeSend(caasUrl+"/api/v1/namespaces/" + spaceName + "/serviceaccounts/" + userName, caas_adminValue, HttpMethod.GET, String.class);
        LOGGER.info("getToken jsonObj~~ {}",jsonObj);
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(jsonObj);
        element = element.getAsJsonObject().get("secrets");
        element = element.getAsJsonArray().get(0);
        String token = element.getAsJsonObject().get("name").toString();
        token = token.replaceAll("\"", "");
        return token;
    }

}
