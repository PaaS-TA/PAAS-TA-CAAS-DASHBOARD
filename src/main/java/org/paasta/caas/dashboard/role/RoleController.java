package org.paasta.caas.dashboard.role;

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
 * Role 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author hrjin
 * @version 1.0
 * @since 2018-08-16
 */
@Controller
@RequestMapping(value = "/roles")
public class RoleController {

    private static final String BASE_URL = "/roles";
    private final CommonService commonService;
    private final RoleService roleService;
    /**
     * Instantiates a new Custom service controller.
     * @param commonService    the common service
     * @param roleService
     */
    @Autowired
    public RoleController(CommonService commonService, RoleService roleService) {
        this.commonService = commonService;
        this.roleService = roleService;
    }

    /**
     * Role 메인 화면으로 이동
     *
     * @param httpServletRequest the http servlet request
     * @return the role main
     */
    @GetMapping
    public ModelAndView getRoleMain(HttpServletRequest httpServletRequest){
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Role 상세 화면으로 이동
     *
     * @param httpServletRequest the http servlet request
     * @param roleName the role name
     * @return the role detail
     */
    @GetMapping(value = "/{roleName:.+}")
    public ModelAndView getRoleDetail(HttpServletRequest httpServletRequest, @PathVariable("roleName") String roleName){
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    /**
     * Gets Role List (모든 네임스페이스에서 조회)
     *
     * @return RoleList
     */
    @GetMapping(value = "/getListByAllNamespaces.do")
    @ResponseBody
    public RoleList getRoleListByAllNamespaces(){
        return roleService.getRoleListByAllNamespaces();
    }

    /**
     * Gets Role List (특정 네임스페이스에서 조회)
     *
     * @return RoleList
     */
    @GetMapping(value = "/getList.do")
    @ResponseBody
    public RoleList getRoleList(){
        return roleService.getRoleList();
    }

    /**
     * Gets Role Detail (특정 네임스페이스에서 조회)
     *
     * @param role the role
     * @return the role
     */
    @GetMapping(value = "/get.do")
    @ResponseBody
    public Role getRole(Role role){
        return roleService.getRole(role.getRoleName());
    }
}
