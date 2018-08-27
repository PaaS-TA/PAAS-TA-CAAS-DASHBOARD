package org.paasta.caas.dashboard.customService;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Custom Service Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.09
 */
@Controller
@RequestMapping(value = "/services")
public class CustomServiceController {

    private static final String BASE_URL = "/services";
    private final CommonService commonService;
    private final CustomServiceService customServiceService;

    /**
     * Instantiates a new Custom service controller.
     *
     * @param commonService        the common service
     * @param customServiceService the custom service service
     */
    @Autowired
    public CustomServiceController(CommonService commonService, CustomServiceService customServiceService) {
        this.commonService = commonService;
        this.customServiceService = customServiceService;
    }

    /**
     * Gets custom service main.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom service main
     */
    @GetMapping
    public ModelAndView getCustomServiceMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Gets custom service detail.
     *
     * @param httpServletRequest the http servlet request
     * @param serviceName        the service name
     * @return the custom service detail
     */
    @GetMapping(value = "/{serviceName:.+}")
    public ModelAndView getCustomServiceDetail(HttpServletRequest httpServletRequest, @PathVariable("serviceName") String serviceName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    /**
     * Gets custom service list.
     *
     * @return the custom service list
     */
    @GetMapping(value = "/getList.do")
    @ResponseBody
    public CustomServiceList getCustomServiceList() {
        return customServiceService.getCustomServiceList();
    }

    /**
     * Gets custom service.
     *
     * @param customService the custom service
     * @return the custom service
     */
//    @GetMapping(value = "/get.do")
//    @ResponseBody
//    public CustomService getCustomService(CustomService customService) {
//        return customServiceService.getCustomService(customService.getServiceName());
//    }

}
