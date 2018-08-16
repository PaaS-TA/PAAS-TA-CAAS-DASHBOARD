package org.paasta.caas.dashboard.workload.replicaset;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;

import java.util.ArrayList;
import java.util.List;

/**
 * Replicaset Model 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.07
 */
@Data
public class ReplicasetList {

//    private String kind;
//    private String apiVersion;
//    private CommonMetaData metadata;
    private String resultCode;
    private String resultMessage;

    private List<Replicaset> items = new ArrayList<Replicaset>();
}
