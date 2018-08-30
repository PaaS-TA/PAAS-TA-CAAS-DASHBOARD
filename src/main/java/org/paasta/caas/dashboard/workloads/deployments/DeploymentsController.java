package org.paasta.caas.dashboard.workloads.deployments;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

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
     * 메인페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
    // TODO :: MODIFY
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments")
    public ModelAndView getDashboardMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
//        return new ModelAndView() {{
//            setViewName("main/main");
//            addObject("ORGANIZATION_ID", "");
//        }};
    }

    /**
     * 모든 네임스페이스에 있는 deployment의 목록을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param headers request headers
     * @return List of deployment (All namespaces)
     */
    @GetMapping( "/workloads/deployments/getList.do" )
    public DeploymentsList getDeploymentListByAllNamespaces(@RequestHeader HttpHeaders headers) {
        return deploymentsService.getDeploymentsListByAllNamespaces();
    }

    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentsName}")
    public ModelAndView getDashboardDetail(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentsName") String deploymentsName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentsName}/events")
    public ModelAndView getDashboardEvent(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentsName") String deploymentsName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/events", new ModelAndView());
    }

    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads/deployments/{deploymentsName}/yaml")
    public ModelAndView getDashboardYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "deploymentsName") String deploymentsName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/yaml", new ModelAndView());
    }

    /**
     * 지정한 네임스페이스에 있는 deployment의 목록을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace namespace
     * @return List of deployment (specific namespace)
     */
    @GetMapping( "/workloads/deployments/{namespace}/getList.do" )
    public DeploymentsList getDeploymentsList(@PathVariable String namespace) {
        return deploymentsService.getDeploymentsList(namespace);
    }

    /**
     * 지정한 네임스페이스에 있는 특정한 deployment의 상세 내역을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace request namespace
     * @param params request parameters
     * @return Deployments's detail content (specific namespace and deployment)
     */
    @GetMapping( "/workloads/deployments/{namespace}/getDeployment.do")
    public Deployments getDeployments(@PathVariable String namespace, @RequestParam Map<String, Object> params) {
        String deploymentName = params.get("name").toString();
        return deploymentsService.getDeployments(namespace, deploymentName);
    }
}
