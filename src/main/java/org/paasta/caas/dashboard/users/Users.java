package org.paasta.caas.dashboard.users;

import lombok.Data;

/**
 * User Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
@Data
public class Users {

    // COMMON
    private String resultCode;
    private String resultMessage;

    private long id;
    private String userId;
    private String serviceInstanceId;
    private String namespace;
    private String caasAccountAccessToken;
    private String caasAcountName;
    private String organizationGuid;
    private String spaceGuid;
    private String roleName;
    private String roleSetCode;

    //private String roleDescription;
    private String description;
    private String created;
    private String lastModified;
}
