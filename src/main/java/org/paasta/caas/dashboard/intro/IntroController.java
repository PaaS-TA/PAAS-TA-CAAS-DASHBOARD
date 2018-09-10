package org.paasta.caas.dashboard.intro;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Intro Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.09.10
 */
@Controller
public class IntroController {

    private static final String VIEW_URL = "/intro";
    private final CommonService commonService;


    @Autowired
    public IntroController(CommonService commonService) {this.commonService = commonService;}


    @GetMapping(value = Constants.URI_INTRO_OVERVIEW)
    public ModelAndView getIntroOverview(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/overview", new ModelAndView());
    }


    @GetMapping(value = Constants.URI_INTRO_ACCESS_INFO)
    public ModelAndView getIntroAccessInfo(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/accessInfo", new ModelAndView());
    }

}
