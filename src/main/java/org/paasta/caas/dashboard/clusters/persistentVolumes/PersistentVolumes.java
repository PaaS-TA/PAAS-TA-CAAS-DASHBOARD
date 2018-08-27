package org.paasta.caas.dashboard.clusters.persistentVolumes;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonStatus;

/**
 * PersistentVolumes Model 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.07
 */
@Data
public class PersistentVolumes {

//    private String apiVersion = null;
//    private String kind = null;

    private CommonMetaData metadata;
    private PersistentVolumesSpec spec;
    private CommonStatus status;

    private String resultCode;
    private String resultMessage;
}
