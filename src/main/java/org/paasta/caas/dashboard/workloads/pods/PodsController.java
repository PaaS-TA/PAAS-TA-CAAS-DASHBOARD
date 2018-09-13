package org.paasta.caas.dashboard.workloads.pods;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// TODO :: REMOVE
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;

//import java.util.Map;

/**
 * Pods 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class PodsController {
    // URL Rule : Constants.API_URL + /workload/namespaces/{namespace}/pods[/.+]
    private static final String BASE_URL = "/workloads/namespaces/{namespace}/pods";
    private final CommonService commonService;
    private final PodsService podsService;

    /**
     * Instantiates a new Pods controller.
     *
     * @param podsService the pod service
     */
    @Autowired
    public PodsController(CommonService commonService, PodsService podsService) {
        this.commonService = commonService;
        this.podsService = podsService;
    }

    @GetMapping(value = "/caas/workloads/pods")
    public ModelAndView getPodList( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, "/pods/main", new ModelAndView());
    }

    @GetMapping(value = "/caas/workloads/pods/{podName:.+}")
    public ModelAndView getPodDetails( HttpServletRequest httpServletRequest, @PathVariable("podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, "/pods/details", new ModelAndView());
    }

    @GetMapping(value = "/caas/workloads/pods/{podName:.+}/events")
    public ModelAndView getPodEvents( HttpServletRequest httpServletRequest, @PathVariable("podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, "/pods/events", new ModelAndView());
    }

    @GetMapping(value = "/caas/workloads/pods/{podName:.+}/yaml")
    public ModelAndView getPodYaml( HttpServletRequest httpServletRequest, @PathVariable("podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, "/pods/yaml", new ModelAndView());
    }

    @GetMapping(value = "/caas/workloads/pods/{podName:.+}/details")
    public void getPodDetailsRedirect( HttpServletResponse httpServletResponse, @PathVariable("podName") String podName) throws IOException {
        httpServletResponse.sendRedirect("/caas/workloads/pods/" + podName);
    }

    @GetMapping(value = Constants.API_URL + "/workloads/pods")
    public PodsList getPodList() {
        return podsService.getPodList();
    }

    /**
     * Get pod list using namespace (_all is All namespaces)
     * @param namespace
     * @return
     */
    @GetMapping(value = Constants.API_URL + BASE_URL)
    public PodsList getPodList(@PathVariable String namespace ) {
        return podsService.getPodList( namespace );
    }

    /**
     * Get pod using namespace and pod's name
     * @param namespace
     * @param podName
     * @return
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{podName:.+}")
    public Pods getPod(@PathVariable String namespace, @PathVariable String podName ) {
        return podsService.getPod(namespace, podName);
    }

    /**
     * Gets pod list.
     *
     * @param selector the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/resource/{selector:.+}")
    @ResponseBody
    public PodsList getPodListBySelector(@PathVariable("namespace") String namespace, @PathVariable("selector") String selector) {
        return podsService.getPodListBySelector(namespace, selector);
    }


    /**
     * Gets pod list.
     *
     * @param serviceName the service name
     * @param selector    the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/service/{serviceName:.+}/{selector:.+}")
    @ResponseBody
    public PodsList getPodListBySelector(@PathVariable("namespace") String namespace,
                                         @PathVariable("serviceName") String serviceName,
                                         @PathVariable("selector") String selector) {
        PodsList podsList = podsService.getPodListBySelector(namespace, selector);

        // FOR DASHBOARD
        podsList.setServiceName(serviceName);
        podsList.setSelector(selector);

        return podsList;
    }

    /**
     * Gets pod list by node.
     * @param namespace
     * @param nodeName
     * @return
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/node/{nodeName:.+}")
    @ResponseBody
    public PodsList getPodListNamespaceByNode(@PathVariable String namespace, @PathVariable String nodeName) {
        return podsService.getPodListNamespaceByNode( namespace, nodeName );
    }
}