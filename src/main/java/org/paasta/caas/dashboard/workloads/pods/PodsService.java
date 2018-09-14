package org.paasta.caas.dashboard.workloads.pods;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Pods Service
 *
 * @author 최윤석
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.8.01 최초작성
 */
@Service
public class PodsService {
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Pods service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public PodsService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     * Gets pod list by resource name
     *
     * @param namespace the namespace
     * @param selector  the selector
     * @return the pod list
     */
    PodsList getPodListBySelector(String namespace, String selector) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_LIST_BY_SELECTOR
                        .replace("{namespace:.+}", namespace).replace("{selector:.+}", selector)
                , HttpMethod.GET, null, PodsList.class);
    }

    /**
     * Get pod list
     *
     * @param namespace the namespace
     * @return the pod list
     */
    PodsList getPodList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_LIST
                .replace("{namespace:.+}", namespace), HttpMethod.GET, null, PodsList.class);
    }

    /**
     * Gets pod list by node name
     *
     * @param namespace the namespace
     * @param nodeName  the node name
     * @return the pod list
     */
    PodsList getPodListNamespaceByNode(String namespace, String nodeName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_LIST_BY_NODE
                        .replace("{namespace:.+}", namespace).replace("{nodeName:.+}", nodeName),
                HttpMethod.GET, null, PodsList.class);
    }

    /**
     * Get pod
     *
     * @param namespace the namespace
     * @param podName   the pod name
     * @return the pod
     */
    Pods getPod(String namespace, String podName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_DETAIL
                        .replace("{namespace:.+}", namespace).replace("{podName:.+}", podName),
                HttpMethod.GET, null, Pods.class);
    }
}
