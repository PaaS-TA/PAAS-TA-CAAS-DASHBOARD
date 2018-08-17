package org.paasta.caas.dashboard.node;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Node Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class NodeService {
    private static final String REQ_URL = "/nodes";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Node service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public NodeService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets node list.
     *
     * @return the node list
     */
    NodeList getNodeList() {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL, HttpMethod.GET, null, NodeList.class);
    }


    /**
     * Gets node.
     *
     * @param nodeName the node name
     * @return the node
     */
    Node getNode(String nodeName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API,
            REQ_URL + "/" + nodeName, HttpMethod.GET, null, Node.class);
    }

}
