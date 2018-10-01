package org.paasta.caas.dashboard.roles;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Roles controller 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Controller
@RequestMapping
public class RolesController {

    private static final String CAAS_BASE_URL = Constants.CAAS_BASE_URL;
    private static final String BASE_URL = "/admin/roles";
    private final CommonService commonService;
    private final RolesService roleService;

    /**
     * Instantiates a new Roles controller.
     *
     * @param commonService the common service
     * @param roleService the role service
     */
    @Autowired
    public RolesController(CommonService commonService, RolesService roleService) {
        this.commonService = commonService;
        this.roleService = roleService;
    }

    /**
     * Role 메인 화면으로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the role main
     */
    @GetMapping(value = CAAS_BASE_URL + "/roles")
    public ModelAndView getRoleMain(HttpServletRequest httpServletRequest){
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Roles 목록을 조회한다.
     *
     * @return RoleList
     */
    @GetMapping(value = "/roles/getList")
    @ResponseBody
    public RolesList getRoleList(){
        return roleService.getRoleList();
    }


}
