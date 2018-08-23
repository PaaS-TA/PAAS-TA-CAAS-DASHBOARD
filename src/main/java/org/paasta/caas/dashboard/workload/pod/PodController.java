package org.paasta.caas.dashboard.workload.pod;

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
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class PodController {
    private static final String BASE_URL = "/workloads/pods";
    private final CommonService commonService;
    private final PodService podService;

    private static final String VIEW_BASE_URL = "/pods";
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

    @GetMapping(value = BASE_URL)
    public ModelAndView getUserMain( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Gets pod list. (kube-system)
     *
     * @return the custom service list
     */
    @GetMapping(value = BASE_URL + "/getList.do")
    @ResponseBody
    public PodList getPodList() {
        return podService.getPodList();
    }


    /**
     * Gets pod list using selector.
     *
     * @param pod the pod
     * @return the custom service list
     */
    @GetMapping(value = BASE_URL + "/getListBySelector.do")
    @ResponseBody
    public PodList getPodListBySelector(Pod pod) {
        PodList podList = podService.getPodListBySelector(pod.getSelector());
        podList.setServiceName(pod.getServiceName()); // FOR DASHBOARD

        return podList;
    }

    /**
     * Get pod list using namespace (_all is All namespaces)
     * @param namespace
     * @return
     */
    @GetMapping(value = BASE_URL + "/{namespace:.+}/getList.do" )
    public PodList getPodList( @PathVariable String namespace ) {
        return podService.getPodListInNamespace(namespace);
    }

    /**
     * Get pod using namespace
     * @param namespace
     * @param podName
     * @return
     */
    @GetMapping(value = BASE_URL + "/{namespace:.+}/getPod.do" )
    public Pod getPod( @PathVariable String namespace, @RequestParam String podName ) {
        return podService.getPod(namespace, podName);
    }


    /**
     * Gets pod list.
     *
     * @param selector the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{selector:.+}")
    @ResponseBody
    public PodList getPodListBySelector(@PathVariable("selector") String selector) {
        return podService.getPodListBySelector(selector);
    }


    /**
     * Gets pod list.
     *
     * @param serviceName the service name
     * @param selector    the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{serviceName:.+}/{selector:.+}")
    @ResponseBody
    public PodList getPodListBySelector(@PathVariable("serviceName") String serviceName, @PathVariable("selector") String selector) {
        PodList podList = podService.getPodListBySelector(selector);

        // FOR DASHBOARD
        podList.setServiceName(serviceName);
        podList.setSelector(selector);

        return podList;
    }

}
