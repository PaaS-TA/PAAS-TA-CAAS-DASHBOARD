package org.paasta.caas.dashboard.common.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

@Data
public class OwnerReferences {

    @SerializedName(value = "name")
    private String name;

}
/*{
                        "apiVersion": "apps/v1",
                        "kind": "ReplicaSet",
                        "name": "nginx-deployment-57b696c78d",
                        "uid": "ffeaf745-af44-11e8-8917-005056900b9f",
                        "controller": true,
                        "blockOwnerDeletion": true
                    }*/