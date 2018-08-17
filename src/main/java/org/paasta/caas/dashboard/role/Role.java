package org.paasta.caas.dashboard.role;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonSpec;
import org.paasta.caas.dashboard.common.model.CommonStatus;

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
    private CommonSpec spec;
    private CommonStatus status;

    // FOR DASHBOARD
    private String roleName;
}
