package org.paasta.caas.dashboard.nodes;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Nodes Controller 클래스
 *
 * @author REX
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@RestController
public class NodesController {
    private static final String BASE_URL = "/nodes";
    private final CommonService commonService;
    private final NodesService nodesService;

    /**
     * Instantiates a new Nodes controller.
     *
     * @param commonService the common service
     * @param nodesService   the node service
     */
    @Autowired
    public NodesController(CommonService commonService, NodesService nodesService) {
        this.commonService = commonService;
        this.nodesService = nodesService;
    }

    /**
     * Gets node list
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping(value = "/caas/clusters" + BASE_URL)
    public ModelAndView getNodeList( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, "/clusters" + BASE_URL, new ModelAndView());
    }

    /**
     * Gets node detail
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping(value = "/caas/clusters" + BASE_URL + "/{nodeName}/details")
    public ModelAndView getNodeDetails( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/details", new ModelAndView());
    }

    /**
     * send redirect to /caas/clusters/nodes/{nodeName}/detail to /caas/clusters/nodes/{nodeName}
     *
     * @param httpServletResponse the http servlet response
     * @return the user main
     */
    @GetMapping(value = "/caas/clusters" + BASE_URL + "/{nodeName}")
    public void sendRedirectClusterOverview(HttpServletResponse httpServletResponse, @PathVariable String nodeName) throws IOException {
        httpServletResponse.sendRedirect( "/caas/clusters/nodes/" + nodeName + "/summary");
    }

    /**
     * Gets node summary
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping(value = "/caas/clusters" + BASE_URL + "/{nodeName}/summary")
    public ModelAndView getNodeSummary( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/summary", new ModelAndView());
    }

    /**
     * Gets node event
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping(value = "/caas/clusters" + BASE_URL + "/{nodeName}/events")
    public ModelAndView getNodeEvents( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/events", new ModelAndView());
    }

    /**
     * Gets node list.
     *
     * @return the node list
     */
    @GetMapping( value = Constants.API_URL + BASE_URL)
    public NodesList getNodeList() {
        return nodesService.getNodeList();
    }

    /**
     * Gets node.
     *
     * @param nodeName the node name
     * @return the node
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{nodeName:.+}")
    public Nodes getNode (@PathVariable("nodeName") String nodeName) {
        return nodesService.getNode(nodeName);
    }
}