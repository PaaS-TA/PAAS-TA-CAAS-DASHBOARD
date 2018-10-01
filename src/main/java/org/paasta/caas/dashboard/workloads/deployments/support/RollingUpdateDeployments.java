package org.paasta.caas.dashboard.workloads.deployments.support;

import lombok.Data;

/**
 * RollingUpdateDeployments
 *
 * @author PHR
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class RollingUpdateDeployments {
    private String maxSurge;
    private String maxUnavailable;
}
