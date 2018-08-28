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
     * send redirect to /caas/clusters/overview
     *
     * @param httpServletResponse the http servlet request
     * @return the user main
     */
    @GetMapping(value = "/caas/clusters" + BASE_URL)
    public void sendRedirectClusterOverview(HttpServletResponse httpServletResponse) {
        try {
            httpServletResponse.sendRedirect( "/caas/clusters/overview" );
        } catch (IOException ioe) {
            throw new RuntimeException(ioe);
        }
    }

    /**
     * Gets node detail main.
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping(value = "/caas/clusters" + BASE_URL + "/{nodeName}")
    public ModelAndView getNodeDetailMain( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
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