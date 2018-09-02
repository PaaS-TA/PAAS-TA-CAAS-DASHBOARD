package org.paasta.caas.dashboard.users;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * User Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
@Controller
@RequestMapping(value = "/caas/users")
public class UsersController {

    private static final String BASE_URL = "/admin/users";
    private final CommonService commonService;
    private final UsersService userService;

    /**
     * Instantiates a new User controller.
     *
     * @param commonService the common service
     * @param userService   the user service
     */
    @Autowired
    public UsersController(CommonService commonService, UsersService userService) {
        this.commonService = commonService;
        this.userService = userService;
    }

    /**
     * Gets user main.
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping
    public ModelAndView getUserMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Gets user list by serviceInstanceId
     *
     * @return the user list
     */
    @GetMapping(value = "/getList.do")
    @ResponseBody
    public List<Users> getUsesListByServiceInstanceId(@RequestParam("serviceInstanceId") String serviceInstanceId,
                                                      @RequestParam("organizationGuid") String organizationGuid) {
        return userService.getUsesListByServiceInstanceId(serviceInstanceId, organizationGuid);
    }

    /**
     * Gets user by serviceInstanceId
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param userId the userId
     * @return the user
     */
    @GetMapping(value = "/getUser.do")
    @ResponseBody
    public Users getUserByServiceInstanceId(@RequestParam("serviceInstanceId") String serviceInstanceId,
                                            @RequestParam("organizationGuid") String organizationGuid,
                                            @RequestParam("userId") String userId) {
        return userService.getUserByServiceInstanceId(serviceInstanceId, organizationGuid, userId);
    }

    /**
     * Update role of user
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param users the user
     * @return the user
     */
    @PostMapping(value = "/updateUserRole.do")
    @ResponseBody
    public Users updateUserRole(@RequestParam("serviceInstanceId") String serviceInstanceId,
                                @RequestParam("organizationGuid") String organizationGuid,
                                @RequestBody Users users){
        Users user = userService.getUserByServiceInstanceId(serviceInstanceId, organizationGuid, users.getUserId());
        user.setRoleSetCode(users.getRoleSetCode());
        return userService.updateUserRole(serviceInstanceId, organizationGuid, user);
    }
}
