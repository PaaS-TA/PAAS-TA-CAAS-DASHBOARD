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
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.06
 */
@RestController
public class PodsController {
    private static final String VIEW_URL = "/pods";
    private final CommonService commonService;
    private final PodsService podsService;

    /**
     * Instantiates a new Pods controller.
     *
     * @param commonService the common service
     * @param podsService   the pods service
     */
    @Autowired
    public PodsController(CommonService commonService, PodsService podsService) {
        this.commonService = commonService;
        this.podsService = podsService;
    }

    /**
     * Pods main 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the pods main
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS)
    public ModelAndView getPodList(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/main", new ModelAndView());
    }

    /**
     * Pods details 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @param podName            the pods name
     * @return the pods details
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS + "/{podName:.+}")
    public ModelAndView getPodDetails(HttpServletRequest httpServletRequest, @PathVariable(value = "podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/details", new ModelAndView());
    }

    /**
     * Pods events 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @param podName            the pods name
     * @return the pods events
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS + "/{podName:.+}/events")
    public ModelAndView getPodEvents(HttpServletRequest httpServletRequest, @PathVariable(value = "podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/events", new ModelAndView());
    }

    /**
     * Pods yaml 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @param podName            the pods name
     * @return the pods yaml
     */
    @GetMapping(value = Constants.URI_WORKLOAD_PODS + "/{podName:.+}/yaml")
    public ModelAndView getPodYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "podName") String podName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/yaml", new ModelAndView());
    }

    /**
     * Pods 목록을 조회한다.
     *
     * @param namespace the namespace
     * @return the pods list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_LIST)
    public PodsList getPodList(@PathVariable(value = "namespace") String namespace) {
        return podsService.getPodList(namespace);
    }

    /**
     * Pods 상세 정보를 조회한다.
     *
     * @param namespace the namespace
     * @param podName   the pods name
     * @return the pods
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_DETAIL)
    public Pods getPod(@PathVariable(value = "namespace") String namespace,
                       @PathVariable(value = "podName") String podName) {
        return podsService.getPod(namespace, podName);
    }

    /**
     * Pods YAML을 조회한다.
     *
     * @param namespace the namespace
     * @param podName   the pods name
     * @return the pods
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_YAML)
    public Pods getPodYaml(@PathVariable(value = "namespace") String namespace,
                           @PathVariable(value = "podName") String podName) {
        return podsService.getPodYaml(namespace, podName);
    }

    /**
     * Selector를 이용해 Pods 목록을 조회한다.
     *
     * @param namespace the namespace
     * @param selector  the selector
     * @return the pods list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_LIST_BY_SELECTOR)
    @ResponseBody
    public PodsList getPodListBySelector(@PathVariable("namespace") String namespace,
                                         @PathVariable("selector") String selector) {
        return podsService.getPodListBySelector(namespace, selector);
    }


    /**
     * Selector와 Service 이름을 이용해 Pods 목록을 조회한다.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @param selector    the selector
     * @return the pods list
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

    /**
     * Node 이름을 이용해 Pods 목록을 조회한다.
     *
     * @param namespace the namespace
     * @param nodeName  the node name
     * @return the pods list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_PODS_LIST_BY_NODE)
    @ResponseBody
    public PodsList getPodListByNode(@PathVariable(value = "namespace") String namespace,
                                     @PathVariable(value = "nodeName") String nodeName) {
        return podsService.getPodListNamespaceByNode(namespace, nodeName);
    }
}