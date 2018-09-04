package org.paasta.caas.dashboard.accessInfo;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Access Info Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.23
 */
@Controller
@RequestMapping
public class AccessInfoController {
    private static final String BASE_URL = "/admin/accessInfo";
    private final CommonService commonService;
    private final AccessInfoService accessInfoService;

    private static final Logger LOGGER = LoggerFactory.getLogger(AccessInfoController.class);

    /**
     * Instantiates a new Access info controller.
     *
     * @param commonService the common service
     * @param accessInfoService
     */
    @Autowired
    public AccessInfoController(CommonService commonService, AccessInfoService accessInfoService) {this.commonService = commonService;
        this.accessInfoService = accessInfoService;
    }


    /**
     * Gets custom service main.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom service main
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/accessInfo")
    public ModelAndView getCustomServiceMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }


    @GetMapping(value = Constants.CAAS_BASE_URL + "/accessInfo/namespace/{namespace}/accessTokenName/{accessTokenName}")
    @ResponseBody
    public AccessInfo getSecret(@PathVariable("namespace") String namespace, @PathVariable("accessTokenName") String accessTokenName) {
        return accessInfoService.getToken(namespace, accessTokenName);
   }

}
