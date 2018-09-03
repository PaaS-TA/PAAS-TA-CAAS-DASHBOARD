package org.paasta.caas.dashboard.clusters.persistentVolumes;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonStatus;

import java.util.Map;

/**
 * PersistentVolumes Model 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.07
 */
@Data
public class PersistentVolumes {

    private CommonMetaData metadata;
    private PersistentVolumesSpec spec;
    private CommonStatus status;
    private Map<String, Object> source;
    private String resultCode;
    private String resultMessage;
}
