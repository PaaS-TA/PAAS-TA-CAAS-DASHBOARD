package org.paasta.caas.dashboard.clusters.namespaces;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;

/**
 * ResourceQuota Model 클래스
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@Data
public class ResourceQuota {

  private String resultCode;
  private String resultMessage;

  private String apiVersion;
  private String kind;
  private CommonMetaData metadata;
  private ResourceQuotaSpec spec;
  private ResourceQuotaStatus status;

}

