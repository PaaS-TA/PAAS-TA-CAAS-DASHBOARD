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
    private static final String POD_PAGE_URL = "/workloads/pods";
    private static final String VIEW_BASE_URL = "/pods/main";
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

    @GetMapping(value = POD_PAGE_URL)
    public ModelAndView getUserMain( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL, new ModelAndView());
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
    public PodsList getPodListBySelector(@PathVariable("namespace") String namespace,
                                         @PathVariable("selector") String selector) {
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

    @GetMapping(value = Constants.API_URL + "/workloads/pods/node/{nodeName:.+}")
    @ResponseBody
    public PodsList getPodListAllNamespacesByNode(@PathVariable String nodeName) {
        return podsService.getPodListAllNamespacesByNode( nodeName );
    }
}