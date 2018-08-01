package org.paasta.caas.dashboard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/common/error")
public class CommonErrorController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CommonErrorController.class);


    @RequestMapping(value = "/unauthorized")
    public String pageError401(HttpServletRequest request, Model model) {
        LOGGER.info("page error code unauthorized");
        pageErrorLog(request);
        model.addAttribute("msg", "접근이 금지되었습니다.");
        return "common/error401";
    }

    private void pageErrorLog(HttpServletRequest request) {
        LOGGER.info("status_code : " + request.getAttribute("javax.servlet.error.status_code"));
        LOGGER.info("exception_type : " + request.getAttribute("javax.servlet.error.exception_type"));
        LOGGER.info("message : " + request.getAttribute("javax.servlet.error.message"));
        LOGGER.info("request_uri : " + request.getAttribute("javax.servlet.error.request_uri"));
        LOGGER.info("exception : " + request.getAttribute("javax.servlet.error.exception"));
        LOGGER.info("servlet_name : " + request.getAttribute("javax.servlet.error.servlet_name"));
    }
}