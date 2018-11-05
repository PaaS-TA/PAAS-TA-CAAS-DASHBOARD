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

    private static final String VIEW_URL = "/services";
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
     * Services main 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services main
     */
    @GetMapping(value = Constants.URI_SERVICES)
    public ModelAndView getCustomServicesMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/main", new ModelAndView());
    }


    /**
     * Services detail 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services detail
     */
    @GetMapping(value = Constants.URI_SERVICES + "/{serviceName:.+}")
    public ModelAndView getCustomServicesDetail(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/detail", new ModelAndView());
    }


    /**
     * Services events 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services detail events
     */
    @GetMapping(value = Constants.URI_SERVICES + "/{serviceName:.+}/events")
    public ModelAndView getCustomServicesDetailEvents(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/events", new ModelAndView());
    }


    /**
     * Services yaml 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom services detail yaml
     */
    @GetMapping(value = Constants.URI_SERVICES + "/{serviceName:.+}/yaml")
    public ModelAndView getCustomServicesDetailYaml(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/yaml", new ModelAndView());
    }


    /**
     * Services 목록을 조회한다.
     *
     * @param namespace the namespace
     * @return the custom services list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_SERVICES_LIST)
    @ResponseBody
    public CustomServicesList getCustomServicesList(@PathVariable(value = "namespace") String namespace) {
        return customServicesService.getCustomServicesList(namespace);
    }


    /**
     * Services 상세 정보를 조회한다.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @return the custom service
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_SERVICES_DETAIL)
    @ResponseBody
    public CustomServices getCustomServices(@PathVariable(value = "namespace") String namespace, @PathVariable("serviceName") String serviceName) {
        return customServicesService.getCustomServices(namespace, serviceName);
    }


    /**
     * Services YAML 정보를 조회한다.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @return the custom services yaml
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_SERVICES_YAML)
    @ResponseBody
    public CustomServices getCustomServicesYaml(@PathVariable(value = "namespace") String namespace, @PathVariable("serviceName") String serviceName) {
        return customServicesService.getCustomServicesYaml(namespace, serviceName);
    }

}
