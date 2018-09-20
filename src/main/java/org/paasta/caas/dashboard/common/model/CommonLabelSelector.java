package org.paasta.caas.dashboard.common.model;

import lombok.Data;

import java.util.Map;

/**
 * ReplicaSets Model 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.07
 */
@Data
public class CommonLabelSelector {
    private Map<String, String> matchLabels;
}
