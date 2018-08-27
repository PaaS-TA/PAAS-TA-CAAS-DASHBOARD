package org.paasta.caas.dashboard.common.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

import java.time.LocalDateTime;

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
    @SerializedName("type")
    private String type;

    @SerializedName("status")
    private String status;
    // FOR NODE :: END
    
    @SerializedName("lastTransitionTime")
    private String lastTransitionTime;

    @SerializedName("message")
    private String message;

    @SerializedName("reason")
    private String reason;

    /**
     * DeploymentCondition only variable.
     */
    @SerializedName("lastUpdateTime")
    private String lastUpdateTime;
}
