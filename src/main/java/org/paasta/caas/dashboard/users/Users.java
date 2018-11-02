package org.paasta.caas.dashboard.users;

import lombok.Data;

/**
 * User Model 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2018.08.02
 */
@Data
public class Users {

    private String resultCode;
    private String resultMessage;

    private long id;
    private String userId;
    private String serviceInstanceId;
    private String caasNamespace;
    private String caasAccountTokenName;
    private String caasAccountName;
    private String organizationGuid;
    private String spaceGuid;
    private String roleSetCode;

    private String description;
    private String created;
    private String lastModified;

    private String caasUrl;
    private String caasClusterName;

    private String planName;
    private String planDescription;
}
