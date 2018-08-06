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

    private long id;
    private String userId;
    private String userName;
    private String email;
    private String description;
    private String created;
    private String lastModified;
}
