package org.paasta.caas.dashboard.intro.accessInfo;

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
 * Intro AccessInfo Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.09.10
 */
@Controller
public class AccessInfoController {

    private static final String VIEW_URL = "/intro";
    private final CommonService commonService;
    private final AccessInfoService accessInfoService;

    /**
     * Instantiates a new Access info controller.
     *
     * @param commonService     the common service
     * @param accessInfoService the access info service
     */
    @Autowired
    public AccessInfoController(CommonService commonService, AccessInfoService accessInfoService) {
        this.commonService = commonService;
        this.accessInfoService = accessInfoService;
    }


    /**
     * Intro access info 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the intro access info
     */
    @GetMapping(value = Constants.URI_INTRO_ACCESS_INFO)
    public ModelAndView getIntroAccessInfo(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/accessInfo", new ModelAndView());
    }


    /**
     * Secret을 조회한다.
     *
     * @param namespace       the namespace
     * @param accessTokenName the access token name
     * @return the secret
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + "/accessInfo/namespace/{namespace}/accessTokenName/{accessTokenName}")
    @ResponseBody
    public AccessInfo getSecret(@PathVariable("namespace") String namespace, @PathVariable("accessTokenName") String accessTokenName) {
        return accessInfoService.getToken(namespace, accessTokenName);
    }

}
