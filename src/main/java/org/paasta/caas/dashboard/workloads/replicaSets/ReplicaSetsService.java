package org.paasta.caas.dashboard.workloads.replicaSets;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Replicaset Service 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class ReplicaSetsService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new ReplicaSet service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public ReplicaSetsService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets replicaset list.
     * @param namespace   the namespace
     * @return the replicaset list
     */
    ReplicaSetsList getReplicasetList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICASETS_LIST
                        .replace("{namespace:.+}", namespace),
                HttpMethod.GET, null, ReplicaSetsList.class);
    }


    /**
     * Gets replicaset.
     *
     * @param namespace   the namespace
     * @param replicaSetName the replicaset name
     * @return the replicaset
     */
    ReplicaSets getReplicaset(String namespace, String replicaSetName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICASETS_DETAIL
                        .replace("{namespace:.+}", namespace)
                        .replace("{replicaSetName:.+}", replicaSetName)
                , HttpMethod.GET, null, ReplicaSets.class);
    }


    /**
     * Gets replicaset YAML.
     *
     * @param namespace   the namespace
     * @param replicaSetName the service name
     * @return the custom services yaml
     */
    ReplicaSets getReplicasetYaml(String namespace, String replicaSetName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICASETS_YAML
                        .replace("{namespace:.+}", namespace)
                        .replace("{replicaSetName:.+}", replicaSetName),
                HttpMethod.GET, null, ReplicaSets.class);
    }


    /**
     * Gets replicaset(Label Selector).
     *
     * @param namespace the namespace
     * @param selectors the selectors
     * @return the replicaset
     */
    ReplicaSetsList getReplicasetListLabelSelector(String namespace, String selectors) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_REPLICASETS_RESOURCES
                     .replace("{namespace:.+}", namespace)
                        .replace("{selector:.+}", selectors),
                HttpMethod.GET, null, ReplicaSetsList.class);
    }

}
