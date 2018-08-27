package org.paasta.caas.dashboard.workload.pods;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

// TODO :: REMOVE
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;

//import java.util.Map;

/**
 * Pod 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class PodController {
    // URL Rule : Constants.API_URL + /workload/namespaces/{namespace}/pods[/.+]
    private static final String BASE_URL = "/workloads/namespaces/{namespace}/pods";
    private static final String POD_PAGE_URL = "/workloads/pods";
    private static final String VIEW_BASE_URL = "/pods/main";
    private final CommonService commonService;
    private final PodService podService;

    /**
     * Instantiates a new Pod controller.
     *
     * @param podService the pod service
     */
    @Autowired
    public PodController( CommonService commonService, PodService podService) {
        this.commonService = commonService;
        this.podService = podService;
    }

    @GetMapping(value = POD_PAGE_URL)
    public ModelAndView getUserMain( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL, new ModelAndView());
    }

    @GetMapping(value = Constants.API_URL + "/workloads/pods")
    public PodList getPodList() {
        return podService.getPodList();
    }

    /**
     * Get pod list using namespace (_all is All namespaces)
     * @param namespace
     * @return
     */
    @GetMapping(value = Constants.API_URL + BASE_URL)
    public PodList getPodList( @PathVariable String namespace ) {
        return podService.getPodList( namespace );
    }

    /**
     * Get pod using namespace and pod's name
     * @param namespace
     * @param podName
     * @return
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{podName:.+}")
    public Pod getPod( @PathVariable String namespace, @PathVariable String podName ) {
        return podService.getPod(namespace, podName);
    }


    /**
     * Gets pod list.
     *
     * @param selector the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/resource/{selector:.+}")
    @ResponseBody
    public PodList getPodListBySelector(@PathVariable("namespace") String namespace,
                                        @PathVariable("selector") String selector) {
        return podService.getPodListBySelector(namespace, selector);
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
    public PodList getPodListBySelector(@PathVariable("namespace") String namespace,
                                        @PathVariable("serviceName") String serviceName,
                                        @PathVariable("selector") String selector) {
        PodList podList = podService.getPodListBySelector(namespace, selector);

        // FOR DASHBOARD
        podList.setServiceName(serviceName);
        podList.setSelector(selector);

        return podList;
    }

    @GetMapping(value = Constants.API_URL + "/workloads/pods/node/{nodeName:.+}")
    @ResponseBody
    public PodList getPodListAllNamespacesByNode(@PathVariable String nodeName) {
        return podService.getPodListAllNamespacesByNode( nodeName );
    }
}
