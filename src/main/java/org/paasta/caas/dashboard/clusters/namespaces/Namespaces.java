package org.paasta.caas.dashboard.clusters.namespaces;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonSpec;
import org.paasta.caas.dashboard.common.model.CommonStatus;

/**
 * Namespace Model 클래스
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@Data
public class Namespaces {

    private String resultCode;
    private String resultMessage;

    private String kind;
    private String apiVersion;

    private CommonMetaData metadata;
    private CommonSpec spec;
    private CommonStatus status;
}