package org.paasta.caas.dashboard.roles;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Role 관련 Caas API 를 호출 하는 컨트롤러이다.
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
     * Instantiates a new Custom service controller.
     * @param commonService    the common service
     * @param roleService
     */
    @Autowired
    public RolesController(CommonService commonService, RolesService roleService) {
        this.commonService = commonService;
        this.roleService = roleService;
    }
//
    /**
     * Role 메인 화면으로 이동
     *
     * @param httpServletRequest the http servlet request
     * @return the role main
     */
    @GetMapping(value = CAAS_BASE_URL + "/roles")
    public ModelAndView getRoleMain(HttpServletRequest httpServletRequest){
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }
//
//    /**
//     * Role 상세 화면으로 이동
//     *
//     * @param httpServletRequest the http servlet request
//     * @param roleName the role name
//     * @return the role detail
//     */
//    @GetMapping(value = CAAS_BASE_URL + "/roles/{roleName:.+}")
//    public ModelAndView getRoleDetail(HttpServletRequest httpServletRequest, @PathVariable("roleName") String roleName){
//        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
//    }
//
//    /**
//     * Gets Role List (모든 네임스페이스에서 조회)
//     *
//     * @return RoleList
//     */
//    @GetMapping(value = "/roles/getListByAllNamespaces.do")
//    @ResponseBody
//    public RolesList getRoleListByAllNamespaces(){
//        return roleService.getRoleListByAllNamespaces();
//    }
//
    /**
     * Gets Role List (특정 네임스페이스에서 조회)
     *
     * @return RoleList
     */
    @GetMapping(value = "/roles/getList.do")
    @ResponseBody
    public RolesList getRoleList(){
        return roleService.getRoleList();
    }
//
//    /**
//     * Gets Role Detail (특정 네임스페이스에서 조회)
//     *
//     * @param role the role
//     * @return the role
//     */
//    @GetMapping(value = "/roles/get.do")
//    @ResponseBody
//    public Roles getRole(Roles role){
//        return roleService.getRole(role.getRoleName());
//    }

    /*@GetMapping(CAAS_BASE_URL + "/roles/{id:.+}")
    @ResponseBody
    public List<Roles> getRolesList(@PathVariable("id") String roleSetCode, HttpServletRequest request){
        return roleService.getRolesList(roleSetCode, request);
    }*/

}
