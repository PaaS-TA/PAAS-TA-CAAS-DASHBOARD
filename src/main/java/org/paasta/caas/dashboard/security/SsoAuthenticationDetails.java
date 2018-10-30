package org.paasta.caas.dashboard.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Extension of {@link OAuth2AuthenticationDetails} providing extra details about the current
 * user and his grant to manage the current service instance.
 *
 * @author Sebastien Gerard
 */
@SuppressWarnings("serial")
public class SsoAuthenticationDetails extends OAuth2AuthenticationDetails {

    private String managingServiceInstance;
    //private String instanceId;
    private final String id;
    private final String userId;
    private String role;
    private String roleId;
    private String roleDisplayName;
    private List<GrantedAuthority> grantedAuthorities;
    private OAuth2AccessToken accessToken;

    private String username;
    private String imgPath;
    private String serviceInstanceId;
    private String organizationGuid;
    private String spaceGuid;
    private String nameSpace;


    public SsoAuthenticationDetails(HttpServletRequest request, String id, String userId) {
        super(request);
        this.id = id;
        this.userId = userId;
    }

    /**
     * Returns the current full user name (first name + last name).
     */
//    public String getUserFullName() {
//        return userFullName;
//    }

    /**
     * 관리 권한이 있는 serviceInstanceId를 입력한다.
     * @param serviceInstanceId
     */
    public void setManagingServiceInstance(String serviceInstanceId) {
        managingServiceInstance = serviceInstanceId;
    }
    public String getManagingServiceInstance() {
        return managingServiceInstance;
    }


    /**
     * Returns the flag indicating whether the current user is allowed to manage
     * the current service instance.
     */
//    public boolean isManagingService() {
//        return managingService;
//    }

    /**
     * 입력 받은 Service Instance Id가 일치하는지 여부를 체크한다.
     * @param serviceInstanceId
     * @return
     */
    public boolean isManagedServiceInstance(String serviceInstanceId) {
        return serviceInstanceId.equals(this.managingServiceInstance);
    }

    public String getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRoleDisplayName() {
        return roleDisplayName;
    }

    public void setRoleDisplayName(String roleDisplayName) {
        this.roleDisplayName = roleDisplayName;
    }

    public List<GrantedAuthority> getGrantedAuthorities() {
        return grantedAuthorities;
    }

    public void setGrantedAuthorities(List<GrantedAuthority> grantedAuthorities) {
        this.grantedAuthorities = grantedAuthorities;
    }

    public OAuth2AccessToken getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(OAuth2AccessToken accessToken) {
        this.accessToken = accessToken;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getServiceInstanceId() {
        return serviceInstanceId;
    }

    public void setServiceInstanceId(String serviceInstanceId) {
        this.serviceInstanceId = serviceInstanceId;
    }

    public String getOrganizationGuid() {
        return organizationGuid;
    }

    public void setOrganizationGuid(String organizationGuid) {
        this.organizationGuid = organizationGuid;
    }

    public String getSpaceGuid() {
        return spaceGuid;
    }

    public void setSpaceGuid(String spaceGuid) {
        this.spaceGuid = spaceGuid;
    }

    public String getNameSpace() {
        return nameSpace;
    }

    public void setNameSpace(String nameSpace) {
        this.nameSpace = nameSpace;
    }

}
