package org.paasta.caas.dashboard.clusters.namespaces;

import lombok.Data;

import java.util.List;

/**
 * ResourceQuotaList Model 클래스
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@Data
public class ResourceQuotaList {

  private String resultCode;
  private String resultMessage;
  private List<ResourceQuota> items;

}

