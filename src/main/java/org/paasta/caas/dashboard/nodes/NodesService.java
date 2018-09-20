package org.paasta.caas.dashboard.nodes;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Nodes Service 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class NodesService {
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Nodes service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public NodesService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }


    /**
     * Nodes 상세 정보를 조회한다.
     *
     * @param nodeName the node name
     * @return the node
     */
    Nodes getNode(String nodeName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API,
                Constants.URI_API_NODES_LIST.replace("{nodeName:.+}", nodeName), HttpMethod.GET, null, Nodes.class);
    }

}
