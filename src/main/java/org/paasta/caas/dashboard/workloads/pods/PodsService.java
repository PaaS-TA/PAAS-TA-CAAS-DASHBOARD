package org.paasta.caas.dashboard.workloads.pods;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Pods Service
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.01
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
     * Selector를 이용해 Pods 목록을 조회한다.
     *
     * @param namespace the namespace
     * @param selector  the selector
     * @return the pods list
     */
    PodsList getPodListBySelector(String namespace, String selector) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_LIST_BY_SELECTOR
                .replace("{namespace:.+}", namespace).replace("{selector:.+}", selector), HttpMethod.GET, null, PodsList.class);
    }

    /**
     * Pods 목록을 조회한다. (특정 네임스페이스)
     *
     * @param namespace the namespace
     * @return the pods list
     */
    PodsList getPodList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_LIST
                .replace("{namespace:.+}", namespace), HttpMethod.GET, null, PodsList.class);
    }

    /**
     * Node 이름을 이용해 Pods 목록을 조회한다.
     *
     * @param namespace the namespace
     * @param nodeName  the node name
     * @return the pods list
     */
    PodsList getPodListNamespaceByNode(String namespace, String nodeName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_LIST_BY_NODE
                .replace("{namespace:.+}", namespace).replace("{nodeName:.+}", nodeName), HttpMethod.GET, null, PodsList.class);
    }

    /**
     * Pods 상세 정보를 조회한다.
     *
     * @param namespace the namespace
     * @param podName   the pods name
     * @return the pods
     */
    Pods getPod(String namespace, String podName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_DETAIL
                .replace("{namespace:.+}", namespace).replace("{podName:.+}", podName), HttpMethod.GET, null, Pods.class);
    }

    /**
     * Pods YAML을 조회한다.
     *
     * @param namespace the namespace
     * @param podName   the pods name
     * @return the pods
     */
    Pods getPodYaml(String namespace, String podName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_PODS_YAML
                .replace("{namespace:.+}", namespace).replace("{podName:.+}", podName), HttpMethod.GET, null, Pods.class);
    }
}
