package org.paasta.caas.dashboard.role;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonRoleRule;
import org.paasta.caas.dashboard.common.model.CommonSpec;
import org.paasta.caas.dashboard.common.model.CommonStatus;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Data
public class Role {

    private String resultCode;
    private String resultMessage;

    private CommonMetaData metadata;
    private List<CommonRoleRule> rules = new ArrayList<>();

    // FOR DASHBOARD
    private String roleName;
}
