package org.paasta.caas.dashboard.config;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Dashboard Controller 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@Controller
public class DashboardController {


    /**
     * 권한없음 페이지로 이동한다.
     */
    @RequestMapping(value = "/common/error/unauthorized")
    public ModelAndView pageError401() {
        ModelAndView model = new ModelAndView();

        model.setViewName("/common/unauthorized");
        return model;
    }
}
