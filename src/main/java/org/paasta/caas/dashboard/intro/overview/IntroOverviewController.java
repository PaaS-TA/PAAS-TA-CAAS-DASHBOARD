package org.paasta.caas.dashboard.intro.overview;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.config.security.userdetail.User;
import org.paasta.caas.dashboard.roles.RolesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Intro Overview Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.09.10
 */
@Controller
public class IntroOverviewController {

    private static final String VIEW_URL = "/intro";
    private final CommonService commonService;
    private final RolesService rolesService;


    /**
     * Instantiates a new Intro overview controller.
     *
     * @param commonService the common service
     * @param rolesService  the roles service
     */
    @Autowired
    public IntroOverviewController(CommonService commonService, RolesService rolesService) {
        this.commonService = commonService;
        this.rolesService = rolesService;
    }


    /**
     * Intro overview 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the intro overview
     */
    @GetMapping(value = Constants.URI_INTRO_OVERVIEW)
    public ModelAndView getIntroOverview(HttpServletRequest httpServletRequest) {
        // 사용자가 처음 들어오는 곳에서 권한 관련 세션 설정
        HttpSession session = httpServletRequest.getSession();
        User user = (User) session.getAttribute("custom_user_role");
        rolesService.setRolesListFirst(user);

        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/overview", new ModelAndView());
    }


    /**
     * Intro overview 페이지로 이동한다. (Service instance id)
     *
     * @param httpServletRequest the http servlet request
     * @return the intro overview by service instance id
     */
    @GetMapping(value = Constants.URI_INTRO_OVERVIEW + "/{serviceInstanceId:.+}")
    public ModelAndView getIntroOverviewByServiceInstanceId(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/overview", new ModelAndView());
    }

}

