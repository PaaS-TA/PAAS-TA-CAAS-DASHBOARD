package org.paasta.caas.dashboard.workloads.pods;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

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
    private static final String VIEW_URL = "/pods";
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

    /**
     * Gets pod list
     *
     * @param httpServletRequest the http servlet request
     * @return the pod list main
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS)
    public ModelAndView getPodList(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/main", new ModelAndView());
    }

    /**
     * Gets pod details
     *
     * @param httpServletRequest the http servlet request
     * @param podName            the pod name
     * @return the pod details
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS + "/{podName:.+}")
    public ModelAndView getPodDetails(HttpServletRequest httpServletRequest, @PathVariable(value = "podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/details", new ModelAndView());
    }

    /**
     * Gets pod events
     *
     * @param httpServletRequest the http servlet request
     * @param podName            the pod name
     * @return the pod events
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS + "/{podName:.+}/events")
    public ModelAndView getPodEvents(HttpServletRequest httpServletRequest, @PathVariable(value = "podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/events", new ModelAndView());
    }

    /**
     * Gets pod yaml
     *
     * @param httpServletRequest the http servlet request
     * @param podName            the pod name
     * @return the pod yaml
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS + "/{podName:.+}/yaml")
    public ModelAndView getPodYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/yaml", new ModelAndView());
    }

    /**
     * Gets pod list using namespace (_all is All namespaces)
     *
     * @param namespace the namespace
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_LIST)
    public PodsList getPodList(@PathVariable(value = "namespace") String namespace) {
        return podsService.getPodList(namespace);
    }

    /**
     * Gets pod using namespace and pod's name
     *
     * @param namespace the namespace
     * @param podName   the pod name
     * @return the pod
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_DETAIL)
    public Pods getPod(@PathVariable(value = "namespace") String namespace,
                       @PathVariable(value = "podName") String podName) {
        return podsService.getPod(namespace, podName);
    }

    /**
     * Gets pod list.
     *
     * @param namespace the namespace
     * @param selector  the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_LIST_BY_SELECTOR)
    @ResponseBody
    public PodsList getPodListBySelector(@PathVariable("namespace") String namespace,
                                         @PathVariable("selector") String selector) {
        return podsService.getPodListBySelector(namespace, selector);
    }

    /**
     * Gets pod list by node.
     *
     * @param namespace the namespace
     * @param nodeName  the node name
     * @return
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_LIST_BY_NODE)
    @ResponseBody
    public PodsList getPodListByNode(@PathVariable(value = "namespace") String namespace,
                                     @PathVariable(value = "nodeName") String nodeName) {
        return podsService.getPodListNamespaceByNode(namespace, nodeName);
    }

    /**
     * Gets pod list by selector as service name.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @param selector    the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE)
    @ResponseBody
    public PodsList getPodListBySelectorWithService(@PathVariable("namespace") String namespace,
                                                    @PathVariable("serviceName") String serviceName,
                                                    @PathVariable("selector") String selector) {
        PodsList podsList = podsService.getPodListBySelector(namespace, selector);
        podsList.setServiceName(serviceName);  // FOR DASHBOARD
        podsList.setSelector(selector);        // FOR DASHBOARD

        return podsList;
    }
}