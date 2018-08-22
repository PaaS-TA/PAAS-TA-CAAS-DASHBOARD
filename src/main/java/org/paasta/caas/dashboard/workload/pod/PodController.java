package org.paasta.caas.dashboard.workload.pod;

import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * Pod 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class PodController {

    private static final String BASE_URL = "/workload/pods";
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


    /**
     * Gets pod list.
     *
     * @param selector the selector
     * @return the pod list
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{selector:.+}")
    @ResponseBody
    public PodList getPodList(@PathVariable("selector") String selector) {
        return podService.getPodList(selector);
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
    public PodList getPodList(@PathVariable("serviceName") String serviceName, @PathVariable("selector") String selector) {
        PodList podList = podService.getPodList(selector);

        // FOR DASHBOARD
        podList.setServiceName(serviceName);
        podList.setSelector(selector);

        return podList;
    }

}
