package org.paasta.caas.dashboard.workloads.replicaSets;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * ReplicaSets Service 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class ReplicaSetsService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new ReplicaSets service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public ReplicaSetsService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * ReplicaSets 목록을 조회한다.
     * @param namespace   the namespace
     * @return the replicaSets list
     */
    ReplicaSetsList getReplicaSetsList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICA_SETS_LIST
                        .replace("{namespace:.+}", namespace),
                HttpMethod.GET, null, ReplicaSetsList.class);
    }


    /**
     * ReplicaSets 상세 정보를 조회한다.
     *
     * @param namespace   the namespace
     * @param replicaSetName the replicaSet name
     * @return the replicaSets
     */
    ReplicaSets getReplicaSets(String namespace, String replicaSetName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICA_SETS_DETAIL
                        .replace("{namespace:.+}", namespace)
                        .replace("{replicaSetName:.+}", replicaSetName)
                , HttpMethod.GET, null, ReplicaSets.class);
    }


    /**
     * ReplicaSets YAML을 조회한다.
     *
     * @param namespace   the namespace
     * @param replicaSetName the service name
     * @return the replicaSets yaml
     */
    ReplicaSets getReplicaSetsYaml(String namespace, String replicaSetName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICA_SETS_YAML
                        .replace("{namespace:.+}", namespace)
                        .replace("{replicaSetName:.+}", replicaSetName),
                HttpMethod.GET, null, ReplicaSets.class);
    }


    /**
     * ReplicaSets 목록을 조회한다. (Label Selector)
     *
     * @param namespace the namespace
     * @param selectors the selectors
     * @return the replicaSets list
     */
    ReplicaSetsList getReplicaSetsListLabelSelector(String namespace, String selectors) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICA_SETS_RESOURCES
                     .replace("{namespace:.+}", namespace)
                        .replace("{selector:.+}", selectors),
                HttpMethod.GET, null, ReplicaSetsList.class);
    }

}
