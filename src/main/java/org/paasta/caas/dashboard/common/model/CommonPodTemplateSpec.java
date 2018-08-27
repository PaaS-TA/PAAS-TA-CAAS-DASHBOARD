package org.paasta.caas.dashboard.common.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

/**
 * ReplicaSets Model 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.07
 */
@Data
public class CommonPodTemplateSpec {
    private CommonMetaData metadata;
    private CommonPodSpec spec;
}
