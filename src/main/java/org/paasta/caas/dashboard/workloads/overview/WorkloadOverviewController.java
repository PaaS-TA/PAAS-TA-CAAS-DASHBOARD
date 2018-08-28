package org.paasta.caas.dashboard.workloads.overview;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Workload Overview Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.23
 */
@RestController
public class WorkloadOverviewController {

    private static final String BASE_URL = "/workloads";
    private final CommonService commonService;

    /**
     * Instantiates a new Workload overview controller.
     *
     * @param commonService the common service
     */
    @Autowired
    public WorkloadOverviewController(CommonService commonService) {this.commonService = commonService;}


    /**
     * Gets workload overview.
     *
     * @param httpServletRequest the http servlet request
     * @return the workload overview
     */
    @GetMapping(value = BASE_URL + "/overview")
    public ModelAndView getWorkloadOverview(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/overview", new ModelAndView());
    }

}
