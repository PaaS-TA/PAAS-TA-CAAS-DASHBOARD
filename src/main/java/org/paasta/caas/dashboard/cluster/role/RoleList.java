package org.paasta.caas.dashboard.cluster.role;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Data
public class RoleList {
    private String resultCode;
    private String resultMessage;

    private List<Role> items = new ArrayList<>();
}
