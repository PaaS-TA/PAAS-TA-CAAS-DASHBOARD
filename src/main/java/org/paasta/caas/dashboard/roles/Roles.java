package org.paasta.caas.dashboard.roles;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonRoleRule;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Data
public class Roles {

    private String resultCode;
    private String resultMessage;

    private CommonMetaData metadata;
    private List<CommonRoleRule> rules = new ArrayList<>();

    // FOR DASHBOARD
    private String roleName;
}
