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

    private String roleSetCode;
    private String resourceCode;
    private String verbCode;
    private String description;
    private String created;
    private String resultCode;

}
