package org.paasta.caas.dashboard.customServices;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Custom Services Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.09
 */
@Controller
public class CustomServicesController {

    private static final String BASE_URL = "/services";
    private final CommonService commonService;
    private final CustomServicesService customServicesService;

    /**
     * Instantiates a new Custom services controller.
     *
     * @param commonService        the common service
     * @param customServicesService the custom services service
     */
    @Autowired
    public CustomServicesController(CommonService commonService, CustomServicesService customServicesService) {
        this.commonService = commonService;
        this.customServicesService = customServicesService;
    }


    /**
     * Gets custom services main.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services main
     */
    @GetMapping(value = BASE_URL)
    public ModelAndView getCustomServicesMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }


    /**
     * Gets custom services detail.
     *
     * @param httpServletRequest the http servlet request
     * @param serviceName        the service name
     * @return the custom services detail
     */
    @GetMapping(value = BASE_URL + "/{serviceName:.+}")
    public ModelAndView getCustomServicesDetail(HttpServletRequest httpServletRequest, @PathVariable("serviceName") String serviceName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }


    /**
     * Gets custom services list.
     *
     * @return the custom services list
     */
    @GetMapping(value = Constants.API_URL + BASE_URL)
    @ResponseBody
    public CustomServicesList getCustomServicesList() {
        return customServicesService.getCustomServicesList();
    }


    /**
     * Gets custom services.
     *
     * @param serviceName the service name
     * @return the custom services
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{serviceName:.+}")
    @ResponseBody
    public CustomServices getCustomService(@PathVariable("serviceName") String serviceName) {
        return customServicesService.getCustomServices(serviceName);
    }

}
