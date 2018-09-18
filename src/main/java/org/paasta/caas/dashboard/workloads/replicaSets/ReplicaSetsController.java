package org.paasta.caas.dashboard.workloads.replicaSets;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


/**
 * ReplicaSet Controller 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.06
 */
@Controller
public class ReplicaSetsController {

    private static final String VIEW_URL = "/replicasets";
    private final CommonService commonService;
    private final ReplicaSetsService replicaSetService;

    /**
     * Instantiates a new ReplicaSets controller.
     *
     * @param commonService      the common service
     * @param replicaSetsService the replicaSet service
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
    @GetMapping(value = Constants.URI_WORKLOAD_REPLICA_SETS)
    public ModelAndView getReplicaSetsMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/main", new ModelAndView());
    }


    /**
     * Gets replicaSet detail.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services detail
     */
    @GetMapping(value = Constants.URI_WORKLOAD_REPLICA_SETS + "/{replicaSetName:.+}")
    public ModelAndView getReplicaSetsDetail(HttpServletRequest httpServletRequest, @PathVariable("replicaSetName") String replicaSetName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/detail", new ModelAndView());
    }


    /**
     * Gets custom services detail events.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services detail events
     */
    @GetMapping(value = Constants.URI_WORKLOAD_REPLICA_SETS + "/{replicaSetName:.+}/events")
    public ModelAndView getReplicaSetsDetailEvents(HttpServletRequest httpServletRequest, @PathVariable("replicaSetName") String replicaSetName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/events", new ModelAndView());
    }


    /**
     * Gets replicaSet detail yaml.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services detail events
     */
    @GetMapping(value = Constants.URI_WORKLOAD_REPLICA_SETS + "/{replicaSetName:.+}/yaml")
    public ModelAndView getReplicaSetsDetailYaml(HttpServletRequest httpServletRequest, @PathVariable("replicaSetName") String replicaSetName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/yaml", new ModelAndView());
    }


    /**
     * Gets replicaSet list.
     *
     * @param namespace the namespace
     * @return the replicaSet list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_REPLICA_SETS_LIST)
    @ResponseBody
    public ReplicaSetsList getReplicaSetsList(@PathVariable("namespace") String namespace){
        return replicaSetService.getReplicasetList(namespace);
    }


    /**
     * Gets replicaSet.
     *
     * @param namespace the namespace
     * @param replicaSetName the replicaSet name
     * @return the replicaSet
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_REPLICA_SETS_DETAIL)
    @ResponseBody
    public ReplicaSets getReplicaSets(@PathVariable("namespace") String namespace, @PathVariable("replicaSetName") String replicaSetName ){
        return replicaSetService.getReplicaset(namespace, replicaSetName);
    }


    /**
     * Gets replicaSet yaml.
     *
     * @param namespace the namespace
     * @param replicaSetName the replicaSetName name
     * @return the replicaSet
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_REPLICA_SETS_YAML)
    @ResponseBody
    public ReplicaSets getReplicaSetsYaml(@PathVariable("namespace") String namespace, @PathVariable("replicaSetName") String replicaSetName ){
        return replicaSetService.getReplicaSetYaml(namespace, replicaSetName);
    }


    /**
     * Gets replicaSet refer list filter selector.
     *
     * @param namespace the namespace
     * @param selector the selector for filter
     * @return ReplicaSetList
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_REPLICA_SETS_RESOURCES)
    @ResponseBody
    public ReplicaSetsList getReplicaSetsLabelSelector(@PathVariable("namespace") String namespace, @PathVariable("selector") String selector ){
        return replicaSetService.getReplicasetListLabelSelector(namespace, selector);
    }

}
