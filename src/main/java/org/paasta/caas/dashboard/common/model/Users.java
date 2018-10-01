package org.paasta.caas.dashboard.common.model;

import lombok.Data;

/**
 * Users Model 클래스
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.22
 */
@Data
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

}
