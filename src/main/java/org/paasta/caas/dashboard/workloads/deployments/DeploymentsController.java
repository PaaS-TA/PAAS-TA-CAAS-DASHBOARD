package org.paasta.caas.dashboard.workloads.deployments;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Deployments 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author Hyungu Cho
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
     * Deployments 메인페이지 (리스트 페이지) 로 이동한다.
     * @param httpServletRequest the http servlet request
     * @return ModelAndView(Spring 클래스)
     */
    // TODO :: MODIFY
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments")
    public ModelAndView getDashboardMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Deployments detail 페이지로 이동한다.
     * @param httpServletRequest the http servlet request
     * @param deploymentsName deployments name
     * @return ModelAndView(Spring 클래스)
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentsName}")
    public ModelAndView getDashboardDetail(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentsName") String deploymentsName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    /**
     * Deployments detail events 페이지로 이동한다.
     * @param httpServletRequest the http servlet request
     * @param deploymentsName deployments name
     * @return ModelAndView(Spring 클래스)
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentsName}/events")
    public ModelAndView getDashboardEvent(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentsName") String deploymentsName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/events", new ModelAndView());
    }

    /**
     * Deployments detail yaml 페이지로 이동한다.
     * @param httpServletRequest the http servlet request
     * @param deploymentsName deployments name
     * @return ModelAndView(Spring 클래스)
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentsName}/yaml")
    public ModelAndView getDashboardYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentsName") String deploymentsName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/yaml", new ModelAndView());
    }

    /**
     * 지정한 네임스페이스에 있는 deployment의 목록을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace namespace
     * @return List of deployments (specific namespace)
     */
    @GetMapping( Constants.URI_API_DEPLOYMENTS_LIST )
    public DeploymentsList getDeploymentsList(@PathVariable String namespace) {
        return deploymentsService.getDeploymentsList(namespace);
    }

    /**
     * 지정한 네임스페이스에 있는 특정한 deployment의 상세 내역을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace request namespace
     * @param deploymentName request deploymentName
     * @return Deployments's detail content (specific namespace and deployment)
     */
    @GetMapping( Constants.URI_API_DEPLOYMENTS_DETAIL )
    public Deployments getDeployments(@PathVariable String namespace, @PathVariable String deploymentName) {
        return deploymentsService.getDeployments(namespace, deploymentName);
    }

    /**
     * deployments 목록을 조회한다. (Label Selector)
     *
     * @param namespace the namespace
     * @param selector  the selector for filter
     * @return List of deployments
     */
    @GetMapping( Constants.URI_API_DEPLOYMENTS_RESOURCES )
    @ResponseBody
    public DeploymentsList getDeploymentsListLabelSelector(@PathVariable("namespace") String namespace, @PathVariable("selector") String selector) {
        return deploymentsService.getDeploymentsListLabelSelector(namespace, selector);
    }
}
