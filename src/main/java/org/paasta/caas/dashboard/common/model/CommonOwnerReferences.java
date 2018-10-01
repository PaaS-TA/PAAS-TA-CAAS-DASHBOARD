package org.paasta.caas.dashboard.common.model;

import lombok.Data;

/**
 * Common CommonOwnerReferences Model 클래스
 *
 * @author hyerin
 * @version 1.0
 * @since 2018.09.19
 */
@Data
class CommonOwnerReferences {
    private String name;
    private boolean controller;
}
