package org.paasta.caas.dashboard.common.model;

import lombok.Data;

import java.util.List;

/**
 * Common Status Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.09
 */
@Data
public class CommonStatus {
    private int availableReplicas;
    private int fullyLabeledReplicas;
    private long observedGeneration;
    private int readyReplicas;
    private int replicas;
    private String phase;
    private List containerStatuses;
    private List<CommonCondition> conditions;
    private String podIP;
    private String qosClass;
}
