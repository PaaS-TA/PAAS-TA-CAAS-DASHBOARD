package org.paasta.caas.dashboard.common.model;

/**
 * User Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
public class Users {

    private long id;
    private String userId;
    private String serviceInstanceId;
    private String caasNamespace;
    private String  caasAccountTokenName;
    private String namespace;
    private String caasAccountAccessToken;
    private String caasAccountName;
    private String organizationGuid;
    private String spaceGuid;
    private String roleName;
    private String roleSetCode;
    private String description;
    private String created;
    private String lastModified;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getServiceInstanceId() {
        return serviceInstanceId;
    }

    public void setServiceInstanceId(String serviceInstanceId) {
        this.serviceInstanceId = serviceInstanceId;
    }

    public String getCaasNamespace() {
        return caasNamespace;
    }

    public void setCaasNamespace(String caasNamespace) {
        this.caasNamespace = caasNamespace;
    }

    public String getCaasAccountTokenName() {
        return caasAccountTokenName;
    }

    public void setCaasAccountTokenName(String caasAccountTokenName) {
        this.caasAccountTokenName = caasAccountTokenName;
    }

    public String getNamespace() {
        return namespace;
    }

    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }

    public String getCaasAccountAccessToken() {
        return caasAccountAccessToken;
    }

    public void setCaasAccountAccessToken(String caasAccountAccessToken) {
        this.caasAccountAccessToken = caasAccountAccessToken;
    }

    public String getCaasAccountName() {
        return caasAccountName;
    }

    public void setCaasAccountName(String caasAccountName) {
        this.caasAccountName = caasAccountName;
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

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleSetCode() {
        return roleSetCode;
    }

    public void setRoleSetCode(String roleSetCode) {
        this.roleSetCode = roleSetCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getLastModified() {
        return lastModified;
    }

    public void setLastModified(String lastModified) {
        this.lastModified = lastModified;
    }
}
