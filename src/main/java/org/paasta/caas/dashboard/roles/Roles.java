package org.paasta.caas.dashboard.roles;

import lombok.Data;

/**
 * Roles Model 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Data
public class Roles {

    private String roleSetCode;
    private String resourceCode;
    private String verbCode;
    private String description;
    private String created;
    private String resultCode;

}
