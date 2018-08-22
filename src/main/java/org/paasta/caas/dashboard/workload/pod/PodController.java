package org.paasta.caas.dashboard.workload.pod;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.common.CommonService;
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
@RequestMapping("/workload/pods")
public class PodController {
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

    @GetMapping
    public ModelAndView getUserMain( HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Gets pod list. (kube-system)
     *
     * @return the custom service list
     */
    @GetMapping(value = "/getList.do")
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
    @GetMapping(value = "/getListBySelector.do")
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
    @GetMapping( "/{namespace}/getList.do" )
    public PodList getPodList( @PathVariable String namespace ) {
        return podService.getPodListInNamespace(namespace);
    }

    /**
     * Get pod using namespace
     * @param namespace
     * @param podName
     * @return
     */
    @GetMapping( "/{namespace}/getPod.do" )
    public Pod getPod( @PathVariable String namespace, @RequestParam String podName ) {
        return podService.getPod(namespace, podName);
    }
}
