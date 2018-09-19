package org.paasta.caas.dashboard.common.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.SerializedName;
import lombok.Data;
import org.paasta.caas.dashboard.workloads.pods.support.OwnerReferences;

import java.util.List;
import java.util.Map;

/**
 * ListMeta Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.09
 */
@Data
public class CommonMetaData {

    @SerializedName( "labels" )
    private Map<String, String> labels;

    @SerializedName( "name" )
    private String name;

    @SerializedName( "namespace" )
    private String namespace;

    @SerializedName( "annotations" )
    private Map<String, String> annotations;

    @SerializedName( "clusterName" )
    private String clusterName;

    @SerializedName( "creationTimestamp" )
    private String creationTimestamp;

    @SerializedName( "deletionGracePeriodSeconds" )
    private long deletionGracePeriodSeconds;

    @SerializedName( "deletionTimestamp" )
    private String deletionTimestamp;

    @SerializedName( "finalizers" )
    private List<String> finalizers;

    @SerializedName( "generateName" )
    private String generateName;

    @SerializedName( "generation" )
    private long generation;

    @SerializedName( "uid" )
    private String uid;

    @SerializedName( "continue" )
    @JsonProperty( "continue" )
    private String _continue;

    @SerializedName( "resourceVersion" )
    private String resourceVersion;

    @SerializedName( "selfLink" )
    private String selfLink;

    @SerializedName("ownerReferences")
    private List<OwnerReferences> ownerReferences;
}
