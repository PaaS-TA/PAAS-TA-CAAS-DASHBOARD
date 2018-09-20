package org.paasta.caas.dashboard.workloads.pods;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonSpec;
import org.paasta.caas.dashboard.common.model.CommonStatus;

import java.util.Map;

/**
 * Pods Model 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class Pods {
    private String resultCode;
    private String resultMessage;

    private CommonMetaData metadata;
    private CommonSpec spec;
    private CommonStatus status;

    private String selector;
    private String serviceName;

    private Map<String, Object> source;
    private String sourceTypeYaml;
}
