package org.paasta.caas.dashboard.clusters.overview;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.config.security.userdetail.User;
import org.paasta.caas.dashboard.roles.RolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Namespace 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class ClusterOverviewController {

    private static final String BASE_URL = "/caas/clusters";
    private final CommonService commonService;
    private final RolesService rolesService;

    /**
     * Instantiates a new Cluster overview controller.
     *
     * @param commonService the common service
     * @param rolesService
     */
    @Autowired
    public ClusterOverviewController(CommonService commonService, RolesService rolesService) {this.commonService = commonService;
        this.rolesService = rolesService;
    }


    /**
     * Gets clusters overview.
     *
     * @param httpServletRequest the http servlet request
     * @return the clusters overview
     */
    @GetMapping(value = BASE_URL + "/overview")
    public ModelAndView getClustersOverview(HttpServletRequest httpServletRequest) {

        // TODO :: DB 조회 - 권한 조회하여 Session에 저장
        // 1. 위 user 객체의 name / serviceInstanceId 로 user table에서 사용자 조회
        // 2. (JPA로 JOIN이 용이하지 않을시) 1의 결과값 rule_set_code 으로, rule_set 리스트 조회
        // 3. 2의 결과 리스트를 session에 저장
        HttpSession session = httpServletRequest.getSession();
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! session" + session);
        User user = (User)session.getAttribute("custom_user_role");
        rolesService.setRolesList(user);

        return commonService.setPathVariables(httpServletRequest, "/clusters/overview", new ModelAndView());
    }

    @GetMapping(value = BASE_URL + "/overview/{serviceInstanceId}")
    public ModelAndView goClusterOverviewInstanceId(HttpServletRequest httpServletRequest) {
        return new ModelAndView() {{
            setViewName("/cluster/overview");
        }};
    }

}
