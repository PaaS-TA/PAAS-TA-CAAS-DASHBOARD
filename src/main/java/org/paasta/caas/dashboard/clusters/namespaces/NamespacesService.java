package org.paasta.caas.dashboard.clusters.namespaces;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Namespaces Service 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@Service
public class NamespacesService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Namespace service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public NamespacesService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Namespaces 상세 정보를 조회한다.
     *
     * @param namespace the namespaces
     * @return the Namespaces
     */
    Namespaces getNamespaces(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_NAME_SPACES_DETAIL
                .replace("{namespace:.+}", namespace), HttpMethod.GET, null, Namespaces.class);
    }

    /**
     * Namespaces ResourceQuota 정보를 조회한다.
     *
     * @param namespace the namespaces
     * @return the ResourceQuotaList
     */
    ResourceQuotaList getResourceQuotaList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_NAME_SPACES_RESOURCE_QUOTAS
                .replace("{namespace:.+}", namespace), HttpMethod.GET, null, ResourceQuotaList.class);
    }
}
