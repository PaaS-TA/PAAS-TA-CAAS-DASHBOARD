package org.paasta.caas.dashboard.workload.replicaset;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Endpoint Service 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class ReplicasetService {

    //private static final String REQ_URL = "/" + Constants.NAMESPACE_NAME + "/replicaset";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new replicaset service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public ReplicasetService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets replicaset list.
     *
     * @return the replicaset list
     */
    ReplicasetList getReplicasetList(String namespace) {
        // TODO :: reqUrl 따로 관리 여부 결정
        String reqUrl = "/workload/namespaces/{namespace}/replicasets"
                .replaceAll("\\{" + "namespace" + "\\}", namespace);
        return restTemplateService.send(Constants.TARGET_CAAS_API, reqUrl, HttpMethod.GET, null, ReplicasetList.class);
    }


    /**
     * Gets replicaset.
     *
     * @param replicasetsName the replicaset name
     * @return the replicaset
     */
    Replicaset getReplicaset(String namespace, String replicasetsName) {
        // TODO :: reqUrl 따로 관리 여부 결정
        String reqUrl = "/workload/namespaces/{namespace}/replicasets/{name}"
                .replaceAll("\\{" + "namespace" + "\\}", namespace)
                .replaceAll("\\{" + "name" + "\\}", replicasetsName);
        return restTemplateService.send(Constants.TARGET_CAAS_API, reqUrl, HttpMethod.GET, null, Replicaset.class);
    }

}
