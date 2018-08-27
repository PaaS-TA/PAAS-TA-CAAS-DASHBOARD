package org.paasta.caas.dashboard.workload.deployments.support;

import lombok.Data;

/**
 * RollingUpdateDeployments
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class RollingUpdateDeployments {
    private String maxSurge;

    private String maxUnavailable;
}
