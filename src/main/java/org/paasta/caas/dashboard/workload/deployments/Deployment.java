package org.paasta.caas.dashboard.workload.deployments;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.workload.deployments.support.DeploymentSpec;
import org.paasta.caas.dashboard.workload.deployments.support.DeploymentStatus;

/**
 * Deployment Model 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class Deployment {
    private String resultCode;
    private String resultMessage;

    private CommonMetaData metadata;
    private DeploymentSpec spec;
    private DeploymentStatus status;
}
