package org.paasta.caas.dashboard.workloads.deployments;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Deployments Controller 클래스
 *
 * @author PHR
 * @version 1.0
 * @since 2018.08.14
 */
@RestController
@RequestMapping
public class DeploymentsController {
    private final CommonService commonService;
    private final DeploymentsService deploymentsService;

    private static final String BASE_URL = "/deployments";

    @Autowired
    public DeploymentsController(CommonService commonService, DeploymentsService deploymentsService) {
        this.commonService = commonService;
        this.deploymentsService = deploymentsService;
    }

    /**
     * Deployments main 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the deployments main
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments")
    public ModelAndView getDashboardMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Deployments detail 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the deployments detail
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentName}")
    public ModelAndView getDashboardDetail(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentName") String deploymentName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    /**
     * Deployments events 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the deployments detail events
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentName}/events")
    public ModelAndView getDashboardEvent(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentName") String deploymentName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/events", new ModelAndView());
    }

    /**
     * Deployments yaml 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the replicaSets detail yaml
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentName}/yaml")
    public ModelAndView getDashboardYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentName") String deploymentName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/yaml", new ModelAndView());
    }

    /**
     * Deployments 목록을 조회한다.
     *
     * @param namespace the namespace
     * @return the deployments list
     */
    @GetMapping( value = Constants.API_URL + Constants.URI_API_DEPLOYMENTS_LIST )
    public DeploymentsList getDeploymentsList(@PathVariable String namespace) {
        return deploymentsService.getDeploymentsList(namespace);
    }

    /**
     * Deployments 상세 정보를 조회한다.
     *
     * @param namespace the namespace
     * @param deploymentName the deployments name
     * @return the deployments
     */
    @GetMapping( value = Constants.API_URL + Constants.URI_API_DEPLOYMENTS_DETAIL )
    public Deployments getDeployments(@PathVariable String namespace, @PathVariable String deploymentName) {
        return deploymentsService.getDeployments(namespace, deploymentName);
    }

    /**
     * Deployments YAML 정보를 조회한다.
     *
     * @param namespace the namespace
     * @param deploymentName the deployments name
     * @return the deployments yaml
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_DEPLOYMENTS_YAML)
    @ResponseBody
    public Deployments getDeploymentsYaml(@PathVariable(value = "namespace") String namespace, @PathVariable("deploymentName") String deploymentName) {
        return deploymentsService.getDeploymentsYaml(namespace, deploymentName);
    }

}
