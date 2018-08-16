package org.paasta.caas.dashboard.workload.deployment.support;

import com.google.gson.annotations.SerializedName;
import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonContainer;
import org.paasta.caas.dashboard.common.model.CommonLabelSelector;
import org.paasta.caas.dashboard.common.model.CommonPodTemplateSpec;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
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
    @SerializedName("minReadySeconds")
    private int minReadySeconds;

    @SerializedName("paused")
    private boolean paused;

    @SerializedName("progressDeadlineSeconds")
    private int progressDeadlineSeconds;

    @SerializedName("replicas")
    private int replicas;

    @SerializedName("revisionHistoryLimit")
    private int revisionHistoryLimit;

    @SerializedName("selector")
    private CommonLabelSelector selector;

    @SerializedName("strategy")
    private DeploymentStrategy strategy;

    @SerializedName("template")
    private CommonPodTemplateSpec template;

    @SerializedName( "images" )
    public Set<String> images;
}
