package org.paasta.caas.dashboard.workload.deployments;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Deployment 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.14
 */
@RestController
@RequestMapping( "/workloads" )
public class DeploymentController {
    private final CommonService commonService;
    private final DeploymentService deploymentService;

    private static final String BASE_URL = "/deployments";

    @Autowired
    public DeploymentController(CommonService commonService, DeploymentService deploymentService) {
        this.commonService = commonService;
        this.deploymentService = deploymentService;
    }

    /**
     * 메인페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
    // TODO :: REMOVE
    @GetMapping(value = {"/deployments"})
    public ModelAndView getDashboardMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
//        return new ModelAndView() {{
//            setViewName("main/main");
//            addObject("ORGANIZATION_ID", "");
//        }};
    }

    // TODO :: REMOVE
//    @GetMapping( BASE_URL )
//    public ModelAndView getUserMain( HttpServletRequest httpServletRequest) {
//        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
//    }

    /**
     * 모든 네임스페이스에 있는 deployment의 목록을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param headers request headers
     * @return List of deployment (All namespaces)
     */
    @GetMapping( "/deployments/getList.do" )
    public DeploymentList getDeploymentListByAllNamespaces(@RequestHeader HttpHeaders headers) {
        return deploymentService.getDeploymentListByAllNamespaces();
    }

    /**
     * 지정한 네임스페이스에 있는 deployment의 목록을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace namespace
     * @return List of deployment (specific namespace)
     */
    @GetMapping( "/deployments/{namespace}/getList.do" )
    public DeploymentList getDeploymentList(@PathVariable String namespace) {
        return deploymentService.getDeploymentList(namespace);
    }

    /**
     * 지정한 네임스페이스에 있는 특정한 deployment의 상세 내역을 서비스를 통해 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace request namespace
     * @param params request parameters
     * @return Deployment's detail content (specific namespace and deployment)
     */
    @GetMapping( "/deployments/{namespace}/getDeployment.do")
    public Deployment getDeployment(@PathVariable String namespace, @RequestParam Map<String, Object> params) {
        String deploymentName = params.get("name").toString();
        return deploymentService.getDeployment(namespace, deploymentName);
    }
}
