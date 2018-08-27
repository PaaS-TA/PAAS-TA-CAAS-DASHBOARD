package org.paasta.caas.dashboard.node;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Node Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.13
 */
@Controller
@RequestMapping(value = "/nodes")
public class NodeController {

    private final NodeService nodeService;

    /**
     * Instantiates a new Node controller.
     *
     * @param nodeService the node service
     */
    @Autowired
    public NodeController(NodeService nodeService) {this.nodeService = nodeService;}


    /**
     * Gets node list.
     *
     * @return the node list
     */
    @GetMapping(value = "/getList.do")
    @ResponseBody
    public NodeList getNodeList() {
        return nodeService.getNodeList();
    }


    /**
     * Gets node.
     *
     * @param node the node
     * @return the node
     */
//    @GetMapping(value = "/get.do")
//    @ResponseBody
//    public Node getNode(Node node) {
//        return nodeService.getNode(node.getNodeName());
//    }

}
