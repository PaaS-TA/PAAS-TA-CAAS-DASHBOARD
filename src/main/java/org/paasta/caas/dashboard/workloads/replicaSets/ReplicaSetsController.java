package org.paasta.caas.dashboard.workloads.replicaSets;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


/**
 * ReplicaSet Controller 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class ReplicaSetsController {

    private static final String BASE_URL = "/replicasets";
    private final ReplicaSetsService replicaSetService;
    private final CommonService commonService;

    /**
     * Instantiates a ReplicaSets controller.
     *
     * @param commonService     the common service
     * @param replicaSetsService the replicaset service
     */
    @Autowired
    public ReplicaSetsController(CommonService commonService, ReplicaSetsService replicaSetsService) {
        this.commonService = commonService;
        this.replicaSetService = replicaSetsService;
    }

    /**
     * Gets replicaSet main.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom service main
     */
    @GetMapping(value = "/caas/workloads/replicaSets")
    public ModelAndView getReplicaSetMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Gets replicaSet detail.
     *
     * @param httpServletRequest the http servlet request
     * @param replicaSetName        the replicaset name
     * @return the custom services detail
     */
    @GetMapping(value = "/caas/workloads/replicaSets/{replicaSetName:.+}")
    public ModelAndView getReplicaSetDetail(HttpServletRequest httpServletRequest, @PathVariable(value = "replicaSetName") String replicaSetName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    /**
     * Gets custom services detail events.
     *
     * @param httpServletRequest the http servlet request
     * @param replicaSetName        the replicaSet name
     * @return the custom services detail events
     */
    @GetMapping(value = "/caas/workloads/replicaSets/{replicaSetName:.+}/events")
    public ModelAndView getReplicaSetDetailEvents(HttpServletRequest httpServletRequest, @PathVariable(value = "replicaSetName") String replicaSetName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/events", new ModelAndView());
    }

    /**
     * Gets replicaSet detail yaml.
     *
     * @param httpServletRequest the http servlet request
     * @param replicaSetName        the replicaSet name
     * @return the custom services detail events
     */
    @GetMapping(value = "/caas/workloads/replicaSets/{replicaSetName:.+}/yaml")
    public ModelAndView getReplicaSetDetailYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "replicaSetName") String replicaSetName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/yaml", new ModelAndView());
    }

    /**
     * Gets replicaSet list.
     *
     * @param namespace the namespace
     * @return the replicaSet list
     */
    @GetMapping(value = "/api/namespaces/{namespace}/replicasets")
    @ResponseBody
    public ReplicaSetsList getReplicaSetList(@PathVariable("namespace") String namespace){
        return replicaSetService.getReplicasetList(namespace);
    }

    /**
     * Gets replicaSet.
     *
     * @param namespace the namespace
     * @param replicasetName the replicaset name
     * @return the replicaSet
     */
    @GetMapping(value = "/api/namespaces/{namespace}/replicasets/{replicasetName}")
    @ResponseBody
    public ReplicaSets getReplicaSet(@PathVariable("namespace") String namespace, @PathVariable("replicasetName") String replicasetName ){
        return replicaSetService.getReplicaset(namespace, replicasetName);
    }


    /**
     * Gets replicaSet refer list filter selector.
     *
     * @param namespace the namespace
     * @param selector the selector for filter
     * @return ReplicaSetList
     * @see ReplicaSetsService#getReplicasetList
     */
    @GetMapping(value = "/api/namespaces/{namespace}/replicasets/resource/{selector}")
    @ResponseBody
    public ReplicaSetsList getReplicaSetLabelSelector(@PathVariable("namespace") String namespace, @PathVariable("selector") String selector ){
        return replicaSetService.getReplicasetListLabelSelector(namespace, selector);
    }

}
