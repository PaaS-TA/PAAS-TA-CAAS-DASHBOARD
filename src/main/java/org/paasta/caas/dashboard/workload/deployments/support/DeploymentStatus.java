package org.paasta.caas.dashboard.workload.deployments.support;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonCondition;

import java.util.List;

/**
 * DeploymentStatus Model 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class DeploymentStatus {
    private int availableReplicas;

    private int collisionCount;

    private List<CommonCondition> conditions;

    private long observedGeneration;

    private int readyReplicas;

    private int replicas;

    private int unavailableReplicas;

    private int updatedReplicas;
}
