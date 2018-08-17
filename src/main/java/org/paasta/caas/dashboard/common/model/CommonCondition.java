package org.paasta.caas.dashboard.common.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

/**
 * Common Condition Model 클래스
 *
 * @author REX
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class CommonCondition {
    // FOR NODE :: BEGIN
    /**
     * <pre>
     * DeploymentConditionType : [ Available, Progressing, ReplicaFailure ]
     * ReplicaSetConditionType : [ ReplicaFailure ]
     * DaemonSetConditionType : [ ]
     * </pre>
     */
    private String type;
    private String status;
    // FOR NODE :: END

    private String message;
    private String reason;

//    /* DeploymentCondition only variable. */
//    private String lastTransitionTime;
//    private String lastUpdateTime;
}
