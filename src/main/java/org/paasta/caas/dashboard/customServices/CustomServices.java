package org.paasta.caas.dashboard.customServices;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonSpec;
import org.paasta.caas.dashboard.common.model.CommonStatus;

/**
 * Custom Services Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.09
 */
@Data
class CustomServices {

    private String resultCode;
    private String resultMessage;

    private CommonMetaData metadata;
    private CommonSpec spec;
    private CommonStatus status;
    private String sourceTypeYaml;

    // FOR DASHBOARD
    private String serviceName;

}
