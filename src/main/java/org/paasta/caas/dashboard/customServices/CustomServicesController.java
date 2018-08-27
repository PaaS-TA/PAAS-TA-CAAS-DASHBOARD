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

    private static final String CAAS_BASE_URL = Constants.CAAS_BASE_URL;
    private static final String API_URL = Constants.API_URL;
    private static final String BASE_URL = "/services";
    private final CommonService commonService;
    private final CustomServicesService customServicesService;

    /**
     * Instantiates a new Custom services controller.
     *
     * @param commonService         the common service
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
    @GetMapping(value = CAAS_BASE_URL + BASE_URL)
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
    @GetMapping(value = CAAS_BASE_URL + BASE_URL + "/{serviceName:.+}")
    public ModelAndView getCustomServicesDetail(HttpServletRequest httpServletRequest, @PathVariable(value = "serviceName") String serviceName) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }


    /**
     * Gets custom services list.
     *
     * @param namespace the namespace
     * @return the custom services list
     */
    @GetMapping(value = API_URL + "/namespaces/{namespace:.+}" + BASE_URL)
    @ResponseBody
    public CustomServicesList getCustomServicesList(@PathVariable(value = "namespace") String namespace) {
        return customServicesService.getCustomServicesList(namespace);
    }


    /**
     * Gets custom service.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @return the custom service
     */
    @GetMapping(value = API_URL + BASE_URL + "/namespaces/{namespace:.+}" + BASE_URL + "/{serviceName:.+}")
    @ResponseBody
    public CustomServices getCustomServices(@PathVariable(value = "namespace") String namespace, @PathVariable("serviceName") String serviceName) {
        return customServicesService.getCustomServices(namespace, serviceName);
    }

}
