package org.paasta.caas.dashboard.workloads.replicaSets;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * ReplicaSets List Model 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.07
 */
@Data
public class ReplicaSetsList {

    private String resultCode;
    private String resultMessage;

    private List<ReplicaSets> items;

}
