package org.paasta.caas.dashboard.intro.privateRegistryInfo;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Private Registry Info Controller 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2019.11.19
 */
@Controller
public class PrivateRegistryInfoController {

    private static final String VIEW_URL = "/intro";
    private final CommonService commonService;
    private final PropertyService propertyService;

    /**
     * Instantiates a new Access info controller.
     * @param commonService     the common service
     * @param propertyService the property service
     */
    @Autowired
    public PrivateRegistryInfoController(CommonService commonService, PropertyService propertyService) {
        this.commonService = commonService;
        this.propertyService = propertyService;
    }


    /**
     * Private Registry info 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the model and view
     */
    @GetMapping(value = Constants.URI_INTRO_PRIVATE_REGISTRY_INFO)
    public ModelAndView getIntroAccessInfo(HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("privateRegistryImageName", propertyService.getPrivateRegistryImageName());
        mv.addObject("privateRegistryUrl", propertyService.getPrivateRegistryUrl());

        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/privateRegistryInfo", mv);
    }


}
