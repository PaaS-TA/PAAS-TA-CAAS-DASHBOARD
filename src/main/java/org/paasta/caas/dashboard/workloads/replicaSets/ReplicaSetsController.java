package org.paasta.caas.dashboard.workloads.replicaSets;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;

//import java.util.Map;

/**
 * ReplicaSet 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
@RequestMapping
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
     * Gets custom service main.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom service main
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/workloads" + BASE_URL)
    public ModelAndView getReplicaSetListMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * ReplicaSet 객체의 리스트를 조회한다.
     *
     * @param namespace 조회 대상 네임스페이스
     * @return ReplicaSetList
     * @see ReplicaSetsService#getReplicasetList
     */
    @GetMapping(value = "/workloads/namespaces/{namespace}/replicasets")
    @ResponseBody
    public ReplicaSetsList getReplicaSetList(@PathVariable("namespace") String namespace ){
        return replicaSetService.getReplicasetList(namespace);
    }

    /**
     * ReplicaSet 객체를 조회한다.
     *
     * @param namespace 조회 대상 네임스페이스
     * @return ReplicaSetList
     * @see ReplicaSetsService#getReplicasetList
     */
    @GetMapping(value = "/workloads/namespaces/{namespace}/replicasets/{replicasetName}")
    @ResponseBody
    public ReplicaSets getReplicaSet(@PathVariable("namespace") String namespace, @PathVariable("replicasetName") String replicasetName ){
        return replicaSetService.getReplicaset(namespace, replicasetName);
    }


    /**
     * ReplicaSet 객체를 labelSelector로 필터링해서 조회한다.
     *
     * @param namespace 조회 대상 네임스페이스
     * @return ReplicaSetList
     * @see ReplicaSetsService#getReplicasetList
     */
    @GetMapping(value = "/workloads/namespaces/{namespace}/replicasets/resource/{selector}")
    @ResponseBody
    public ReplicaSetsList getReplicaSetLabelSelector(@PathVariable("namespace") String namespace, @PathVariable("selector") String selectors ){
        return replicaSetService.getReplicasetListLabelSelector(namespace, selectors);
    }

}
