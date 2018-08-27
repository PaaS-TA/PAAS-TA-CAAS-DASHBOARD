package org.paasta.caas.dashboard.cluster.overview;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.cluster.namespace.Namespace;
import org.paasta.caas.dashboard.cluster.namespace.NamespaceService;
import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;

//import java.util.Map;

/**
 * Namespace 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
@RequestMapping("/caas/cluster")
public class OverviewController {

    private static final String BASE_URL = "/overview";

    private final CommonService commonService;
    private final NamespaceService namespaceService;

    @Autowired
    public OverviewController(CommonService commonService, NamespaceService namespaceService) {
        this.commonService = commonService;
        this.namespaceService = namespaceService;
    }

    // TODO :: REMOVE
    @GetMapping(value = {"/overview"})
    public ModelAndView goClusterOverview(HttpServletRequest httpServletRequest) {
        return new ModelAndView() {{
            setViewName("/cluster/overview");
        }};
    }
    @GetMapping(value = {"/overview/{serviceInstanceId}"})
    public ModelAndView goClusterOverviewInstanceId(HttpServletRequest httpServletRequest) {
        return new ModelAndView() {{
            setViewName("/cluster/overview");
        }};
    }

}
