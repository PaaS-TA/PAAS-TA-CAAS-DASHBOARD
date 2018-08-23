package org.paasta.caas.dashboard.cluster.overview;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Namespace 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class ClusterOverviewController {

    private static final String BASE_URL = "/clusters";
    private final CommonService commonService;

    /**
     * Instantiates a new Cluster overview controller.
     *
     * @param commonService the common service
     */
    @Autowired
    public ClusterOverviewController(CommonService commonService) {this.commonService = commonService;}


    /**
     * Gets clusters overview.
     *
     * @param httpServletRequest the http servlet request
     * @return the clusters overview
     */
    @GetMapping(value = BASE_URL + "/overview")
    public ModelAndView getClustersOverview(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/overview", new ModelAndView());
    }

}
