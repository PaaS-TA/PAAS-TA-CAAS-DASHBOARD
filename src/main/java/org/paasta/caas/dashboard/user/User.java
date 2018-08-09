package org.paasta.caas.dashboard.user;

import lombok.Data;

/**
 * User Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
@Data
public class User {

    // COMMON
    private String resultCode;
    private String resultMessage;

    private long id;
    private String userId;
    private String roleCode;
    private String roleDescription;
    private String description;
    private String created;
    private String lastModified;
}
