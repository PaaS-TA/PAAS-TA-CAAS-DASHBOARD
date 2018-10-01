package org.paasta.caas.dashboard.config.security.userdetail;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.paasta.caas.dashboard.cf.CfService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.common.TemplateService;
import org.paasta.caas.dashboard.common.model.Users;
import org.paasta.caas.dashboard.security.SsoAuthenticationDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CustomUserDetails service 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
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
                    certificationFlag = true;
                }
            }
        }

        if(certificationFlag) {
            List commonGetUsers = restTemplateService.send(Constants.TARGET_COMMON_API, "/users/serviceInstanceId/"+serviceInstanceId+"/organizationGuid/"+organization_guid, HttpMethod.GET, null, List.class);

            spaceName = "paas-"+serviceInstanceId+"-caas";

            if(commonGetUsers != null && commonGetUsers.size() > 0) {
                if(commonGetUsers.toString().contains("userId="+username+",")) {
                    role.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
                } else {
                    String tmpString[] = username.split("@");
                    String userName = (organization_guid + "-" + tmpString[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase() + "-user";
                    String roleName = (tmpString[0].replaceAll("([:.#$&!_\\(\\)`*%^~,\\<\\>\\[\\];+|-])+", "")).toLowerCase();
                    createUser(spaceName, userName);
                    createRole(spaceName, userName, roleName);
                    createRoleBinding(spaceName, userName, roleName);

                    String cubeToken = getToken(spaceName, userName);

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

                    Users commonCreateUser = restTemplateService.send(Constants.TARGET_COMMON_API, "/users", HttpMethod.POST, user, Users.class);

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

    public void createUser(String spaceName, String userName) {
        LOGGER.info("createUser spaceName~~ {}", spaceName);
        LOGGER.info("createUser userName~~ {}", userName);

        Map<String, Object> model = new HashMap<>();
        model.put("spaceName", spaceName);
        model.put("userName", userName);
        String yml = null;
        yml = templateService.convert("instance/create_account.ftl", model);

        restTemplateService.send(Constants.TARGET_CAAS_API, "/authenticate/namespaces/" + spaceName + "/serviceaccounts", HttpMethod.POST, yml, null);
        LOGGER.info("createUser end~~");
    }

    public void createRole(String spaceName, String userName, String roleName) {
        LOGGER.info("createRole spaceName~~ {}", spaceName);
        LOGGER.info("createRole userName~~ {}", userName);
        LOGGER.info("createRole roleName~~ {}", roleName);

        Map<String, Object> model = new HashMap<>();
        model.put("spaceName", spaceName);
        model.put("userName", userName);
        model.put("roleName", spaceName + "-" + roleName + "-role");
        String yml = null;
        yml = templateService.convert("instance/create_init_role.ftl", model);

        try {
            restTemplateService.send(Constants.TARGET_CAAS_API, "/authenticate/namespaces/" + spaceName + "/roles", HttpMethod.POST, yml, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        LOGGER.info("createRole end~~");
    }

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
            restTemplateService.send(Constants.TARGET_CAAS_API, "/authenticate/namespaces/" + spaceName + "/rolebindings", HttpMethod.POST, yml, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        LOGGER.info("createRoleBinding end~~");
    }

    public String getToken(String spaceName, String userName) {
        LOGGER.info("getToken spaceName~~ {}", spaceName);
        LOGGER.info("getToken userName~~ {}", userName);

        String jsonObj = restTemplateService.send(Constants.TARGET_CAAS_API, "/authenticate/namespaces/" + spaceName + "/serviceaccounts/" + userName, HttpMethod.GET, null, String.class);
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
