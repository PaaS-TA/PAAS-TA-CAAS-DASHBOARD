package org.paasta.caas.dashboard.cluster.persistentvolume;

import com.google.gson.annotations.SerializedName;
import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonStatus;

/**
 * Persistentvolume Model 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.07
 */
@Data
public class Persistentvolume {

//    private String apiVersion = null;
//    private String kind = null;

    private CommonMetaData metadata;
    private PersistentvolumeSpec spec;
    private CommonStatus status;

    private String resultCode;
    private String resultMessage;
}
