package org.paasta.caas.dashboard.workload.deployment;

import com.google.gson.annotations.SerializedName;
import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.workload.deployment.support.DeploymentSpec;
import org.paasta.caas.dashboard.workload.deployment.support.DeploymentStatus;

/**
 * Deployment Model 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class Deployment {
//    @SerializedName("kind")
//    private String kind = null;

//    @SerializedName("apiVersion")
//    private String apiVersion = null;
    private String resultCode;
    private String resultMessage;


    @SerializedName( "metadata" )
    private CommonMetaData metadata;

    @SerializedName( "spec" )
    private DeploymentSpec spec;

    @SerializedName( "status" )
    private DeploymentStatus status;
}
