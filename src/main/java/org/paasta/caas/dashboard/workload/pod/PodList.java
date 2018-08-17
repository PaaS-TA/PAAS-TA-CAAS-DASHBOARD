package org.paasta.caas.dashboard.workload.pod;

import lombok.Data;

import java.util.List;

/**
 * Pod List Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.8.13
 */
@Data
class PodList {

    private String resultCode;
    private String resultMessage;

    private List<Pod> items;

    // FOR DASHBOARD
    private String serviceName;

}
