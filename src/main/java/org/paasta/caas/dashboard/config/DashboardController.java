package org.paasta.caas.dashboard.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DashboardController {

    @RequestMapping(value = {"/caas/dashboard"}, method = RequestMethod.GET)
    public ModelAndView testPage() {
        ModelAndView model = new ModelAndView();

        model.setViewName("/main/main");
        return model;
    }

    @RequestMapping(value = {"/caas/dashboard/{serviceInstanceId}"}, method = RequestMethod.GET)
    public ModelAndView test0Page() {
        ModelAndView model = new ModelAndView();

        model.setViewName("/main/main");
        return model;
    }

    @RequestMapping(value = "/common/error/unauthorized")
    public ModelAndView pageError401() {
        ModelAndView model = new ModelAndView();

        model.setViewName("/common/unauthorized");
        return model;
    }

    @RequestMapping(value = "/common/error/500")
    public ModelAndView pageError500Test() {
        ModelAndView model = new ModelAndView();

        Integer.parseInt("a");

        model.setViewName("/common/unauthorized");
        return model;
    }
}
