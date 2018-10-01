package org.paasta.caas.dashboard.intro.accessInfo;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

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
    private final PropertyService propertyService;

    /**
     * Instantiates a new Access info controller.
     *  @param commonService     the common service
     * @param accessInfoService the access info service
     * @param propertyService the property service
     */
    @Autowired
    public AccessInfoController(CommonService commonService, AccessInfoService accessInfoService, PropertyService propertyService) {
        this.commonService = commonService;
        this.accessInfoService = accessInfoService;
        this.propertyService = propertyService;
    }


    /**
     * Intro access info 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the intro access info
     */
    @GetMapping(value = Constants.URI_INTRO_ACCESS_INFO)
    public ModelAndView getIntroAccessInfo(HttpServletRequest httpServletRequest) {
        Map<String, String> roleSetCodeList = new HashMap<>();
        roleSetCodeList.put("administratorCode", propertyService.getAdministratorCode());
        roleSetCodeList.put("regularUserCode", propertyService.getRegularUserCode());
        roleSetCodeList.put("initUserCode", propertyService.getInitUserCode());

        Map<String, String> roleSetNameList = new HashMap<>();
        roleSetNameList.put("administratorName", propertyService.getAdministratorName());
        roleSetNameList.put("regularUserName", propertyService.getRegularUserName());
        roleSetNameList.put("initUserName", propertyService.getInitUserName());

        ModelAndView mv = new ModelAndView();
        mv.addObject("roleSetCodeList", roleSetCodeList);
        mv.addObject("roleSetNameList", roleSetNameList);
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/accessInfo", mv);
    }


    /**
     * Secret을 조회한다.
     *
     * @param namespace       the namespace
     * @param accessTokenName the access token name
     * @return the secret
     */
    @GetMapping(value = Constants.CAAS_BASE_URL + Constants.URI_API_SECRETS_DETAIL)
    @ResponseBody
    public AccessInfo getSecret(@PathVariable("namespace") String namespace, @PathVariable("accessTokenName") String accessTokenName) {
        return accessInfoService.getToken(namespace, accessTokenName);
    }

}
