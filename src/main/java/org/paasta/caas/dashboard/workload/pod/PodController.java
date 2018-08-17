package org.paasta.caas.dashboard.workload.pod;

//import org.springframework.http.HttpMethod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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

    private final PodService podService;

    /**
     * Instantiates a new Pod controller.
     *
     * @param podService the pod service
     */
    @Autowired
    public PodController(PodService podService) {
        this.podService = podService;
    }

    // TODO :: REMOVE
//    //private final String V2_URL = "/v2";
//
//    /**
//     * description.
//     *
//     * //@param req   HttpServletRequest(자바클래스)
//     * @return Map(자바클래스)
//     * @throws Exception Exception(자바클래스)
//     */
//    @GetMapping(value = "/namespaces/{namespace}/pods")
//    @ResponseBody
//    public Map<String, Object> getPodList(@PathVariable("namespace") String namespace, @RequestParam Map<String, Object> map) throws Exception {
//        return podService.getPodList(namespace, map);
//    }

    /**
     * Gets custom service list.
     *
     * @return the custom service list
     */
    @GetMapping(value = "/getList.do")
    @ResponseBody
    public PodList getCustomServiceList() {
        return podService.getPodList();
    }


    /**
     * Gets custom service list.
     *
     * @param pod the pod
     * @return the custom service list
     */
    @GetMapping(value = "/getListBySelector.do")
    @ResponseBody
    public PodList getCustomServiceList(Pod pod) {
        PodList podList = podService.getPodList(pod.getSelector());
        podList.setServiceName(pod.getServiceName()); // FOR DASHBOARD

        return podList;
    }

}
