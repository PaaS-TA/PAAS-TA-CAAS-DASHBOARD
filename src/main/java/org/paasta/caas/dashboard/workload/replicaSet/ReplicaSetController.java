package org.paasta.caas.dashboard.workload.replicaSet;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.workload.pods.PodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

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
public class ReplicaSetController {

    private final PodService podService;

    @Autowired
    public ReplicaSetController(PodService podService) {
        this.podService = podService;
    }

    //private final String V2_URL = "/v2";

    /**
     * description.
     *
     * //@param req   HttpServletRequest(자바클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @GetMapping(value = "/namespaces/{namespace}/replicaset")
    @ResponseBody
    public Map<String, Object> getReplicaSetList(@PathVariable("namespace") String namespace, @RequestParam Map<String, Object> map) throws Exception {
        return null;//podService.getReplicaSetList(namespace, map);
    }

}
