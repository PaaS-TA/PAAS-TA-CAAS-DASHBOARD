package org.paasta.caas.dashboard.node;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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
@RequestMapping(value = "/nodes")
public class NodeController {
    private final CommonService commonService;
    private final NodeService nodeService;

    private static final String BASE_URL = "/nodes";

    /**
     * Instantiates a new Node controller.
     *
     * @param nodeService the node service
     * @param commonService the common service
     */
    @Autowired
    public NodeController(CommonService commonService, NodeService nodeService) {
        this.commonService = commonService;
        this.nodeService = nodeService;
    }

    @GetMapping
    public ModelAndView getUserMain( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }


    /**
     * Gets node list.
     *
     * @return the node list
     */
    @GetMapping(value = "/getList.do")
    public NodeList getNodeList() {
        return nodeService.getNodeList();
    }


    /**
     * Gets node.
     *
     * @param name node's name
     * @return the node
     */
    @GetMapping( value = "/get.do" )
    public Node getNode ( @RequestParam String name ) {
        return nodeService.getNode( name );
    }
}
