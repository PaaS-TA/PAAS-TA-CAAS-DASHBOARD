package org.paasta.caas.dashboard.clusters.namespace;

import org.paasta.caas.dashboard.clusters.persistentVolumes.PersistentVolumes;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Namespace Service 클래스
 *
 * @author 김도현
 * @version 1.0
 * @since 2018.08.28
 */
@Service
public class NamespaceService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Namespace service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public NamespaceService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    Namespace getNamespaces(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, "/cluster/namespaces/"+namespace, HttpMethod.GET, null, Namespace.class);
    }
}
