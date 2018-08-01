package org.paasta.caas.dashboard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by indra on 2018-07-31.
 */
@Controller
public class testController {

    private static final Logger LOGGER = LoggerFactory.getLogger(testController.class);

    @RequestMapping(value = {"/dashboard/test"}, method = RequestMethod.GET)
    public ModelAndView testPage() {
        LOGGER.info("test controller in!!");
        ModelAndView model = new ModelAndView();

        model.setViewName("/test/test");
        return model;
    }

    @RequestMapping(value = {"/dashboard/500ErrorTest"}, method = RequestMethod.GET)
    public ModelAndView testPage500() {
        LOGGER.info("test 500 error controller in!!");
        ModelAndView model = new ModelAndView();

        Integer.parseInt("aaa");

        model.setViewName("/test/test");
        return model;
    }
}
