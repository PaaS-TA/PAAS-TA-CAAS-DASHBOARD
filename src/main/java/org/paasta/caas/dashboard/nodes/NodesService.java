package org.paasta.caas.dashboard.nodes;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Nodes Service 클래스
 *
 * @author REX
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class NodesService {
    private static final String REQ_URL = "/nodes";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Nodes service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public NodesService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets node.
     *
     * @param nodeName the node name
     * @return the node
     */
    Nodes getNode(String nodeName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API,
            REQ_URL + "/" + nodeName, HttpMethod.GET, null, Nodes.class);
    }

}
