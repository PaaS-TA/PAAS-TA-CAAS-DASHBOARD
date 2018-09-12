package org.paasta.caas.dashboard.roles;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * Roles List Model 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Data
public class RolesList {
    private String resultCode;
    private String resultMessage;

    private List<Roles> items = new ArrayList<>();
}
