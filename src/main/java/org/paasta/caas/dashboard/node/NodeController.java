package org.paasta.caas.dashboard.node;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Node Controller 클래스
 *
 * @author REX
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@RestController
public class NodeController {
    private static final String BASE_URL = "/nodes";
    private final CommonService commonService;
    private final NodeService nodeService;

    /**
     * Instantiates a new Node controller.
     *
     * @param commonService the common service
     * @param nodeService   the node service
     */
    @Autowired
    public NodeController(CommonService commonService, NodeService nodeService) {
        this.commonService = commonService;
        this.nodeService = nodeService;
    }

    // TODO :: MODIFY
    /**
     * Gets user main.
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping(value = "/clusters" + BASE_URL)
    public ModelAndView getUserMain( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }


    /**
     * Gets node list.
     *
     * @return the node list
     */
    @GetMapping( value = Constants.API_URL + BASE_URL)
    public NodeList getNodeList() {
        return nodeService.getNodeList();
    }

    /**
     * Gets node.
     *
     * @param nodeName the node name
     * @return the node
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{nodeName:.+}")
    public Node getNode (@PathVariable("nodeName") String nodeName) {
        return nodeService.getNode(nodeName);
    }

}
