package org.paasta.caas.dashboard.workload.replicaset;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.common.CommonService;
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
@RequestMapping("/workload")
public class ReplicasetController {

    private final ReplicasetService replicaSetService;
    private final CommonService commonService;

    /**
     * Instantiates a Replicaset controller.
     *
     * @param commonService     the common service
     * @param replicasetService the replicaset service
     */
    @Autowired
    public ReplicasetController(CommonService commonService, ReplicasetService replicasetService) {
        this.commonService = commonService;
        this.replicaSetService = replicasetService;
    }

    /**
     * Gets custom service main.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom service main
     */
    @GetMapping(value = "/replicasets")
    public ModelAndView getReplicaSetListMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, "/replicasets/replicasets", new ModelAndView());
    }

    /**
     * ReplicaSet 객체의 리스트를 조회한다.
     *
     * @param namespace 조회 대상 네임스페이스
     * @return ReplicaSetList
     * @see ReplicasetService#getReplicasetList
     */
    @GetMapping(value = "/namespaces/{namespace}/replicasets")
    @ResponseBody
    public ReplicasetList getReplicaSetList(@PathVariable("namespace") String namespace ){
        return replicaSetService.getReplicasetList(namespace);
    }

    /**
     * ReplicaSet 객체를 조회한다.
     *
     * @param namespace 조회 대상 네임스페이스
     * @return ReplicaSetList
     * @see ReplicasetService#getReplicasetList
     */
    @GetMapping(value = "/namespaces/{namespace}/replicasets/{replicasetName}")
    @ResponseBody
    public Replicaset getReplicaSet(@PathVariable("namespace") String namespace, @PathVariable("replicasetName") String replicasetName ){
        return replicaSetService.getReplicaset(namespace, replicasetName);
    }

    // TOBE
}
