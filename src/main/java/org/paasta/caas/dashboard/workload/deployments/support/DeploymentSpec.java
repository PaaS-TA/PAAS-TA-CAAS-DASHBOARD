package org.paasta.caas.dashboard.workload.deployments.support;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonLabelSelector;
import org.paasta.caas.dashboard.common.model.CommonPodTemplateSpec;

import java.util.Set;

/**
 * DeploymentSpec Model 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class DeploymentSpec {
    private int minReadySeconds;

    private boolean paused;

    private int progressDeadlineSeconds;

    private int replicas;

    private int revisionHistoryLimit;

    private CommonLabelSelector selector;

    private DeploymentStrategy strategy;

    private CommonPodTemplateSpec template;

    public Set<String> images;
}
