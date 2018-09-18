package org.paasta.caas.dashboard.nodes;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Nodes Controller 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@RestController
public class NodesController {
    private static final String VIEW_URL = "/nodes";
    private final CommonService commonService;
    private final NodesService nodesService;

    /**
     * Instantiates a new Nodes controller.
     *
     * @param commonService the common service
     * @param nodesService  the nodes service
     */
    @Autowired
    public NodesController(CommonService commonService, NodesService nodesService) {
        this.commonService = commonService;
        this.nodesService = nodesService;
    }

    /**
     * Nodes detail 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @param nodeName           the nodes name
     * @return the nodes details
     */
    @GetMapping(value = Constants.URI_CLUSTER_NODES + "/{nodeName:.+}")
    public ModelAndView getNodeDetails(HttpServletRequest httpServletRequest, @PathVariable(value = "nodeName") String nodeName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/details", new ModelAndView());
    }

    /**
     * Nodes summary 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @param nodeName           the nodes name
     * @return the nodes summary
     */
    @GetMapping(value = Constants.URI_CLUSTER_NODES + "/{nodeName:.+}/summary")
    public ModelAndView getNodeSummary(HttpServletRequest httpServletRequest, @PathVariable("nodeName") String nodeName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/summary", new ModelAndView());
    }

    /**
     * Nodes event 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @param nodeName           the nodes name
     * @return the nodes events
     */
    @GetMapping(value = Constants.URI_CLUSTER_NODES + "/{nodeName:.+}/events")
    public ModelAndView getNodeEvents(HttpServletRequest httpServletRequest, @PathVariable("nodeName") String nodeName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/events", new ModelAndView());
    }

    /**
     * Nodes 상세 정보를 조회한다.
     *
     * @param nodeName the nodes name
     * @return the nodes
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_NODES_LIST)
    public Nodes getNode(@PathVariable("nodeName") String nodeName) {
        return nodesService.getNode(nodeName);
    }
}