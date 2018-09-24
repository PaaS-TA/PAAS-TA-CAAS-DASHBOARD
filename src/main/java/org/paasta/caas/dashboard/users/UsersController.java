package org.paasta.caas.dashboard.users;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    private final PropertyService propertyService;

    /**
     * Instantiates a new User controller.
     *  @param commonService the common service
     * @param userService   the user service
     * @param propertyService
     */
    @Autowired
    public UsersController(CommonService commonService, UsersService userService, PropertyService propertyService) {
        this.commonService = commonService;
        this.userService = userService;
        this.propertyService = propertyService;
    }

    /**
     * User 메인 화면으로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the user main
     */
    @GetMapping
    public ModelAndView getUserMain(HttpServletRequest httpServletRequest) {
        Map roleSetCodeList = new HashMap();
        roleSetCodeList.put("administratorCode", propertyService.getAdministratorCode());
        roleSetCodeList.put("regularUserCode", propertyService.getRegularUserCode());
        roleSetCodeList.put("initUserCode", propertyService.getInitUserCode());

        Map roleSetNameList = new HashMap();
        roleSetNameList.put("administratorName", propertyService.getAdministratorName());
        roleSetNameList.put("regularUserName", propertyService.getRegularUserName());
        roleSetNameList.put("initUserName", propertyService.getInitUserName());

        ModelAndView mv = new ModelAndView();
        mv.addObject("roleSetCodeList", roleSetCodeList);
        mv.addObject("roleSetNameList", roleSetNameList);

        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", mv);
    }

    /**
     * User 목록을 조회한다.
     *
     * @return the users list
     */
    @GetMapping(value = "/getList")
    @ResponseBody
    public List<Users> getUsesListByServiceInstanceId(@RequestParam("serviceInstanceId") String serviceInstanceId,
                                                      @RequestParam("organizationGuid") String organizationGuid) {
        return userService.getUsesListByServiceInstanceId(serviceInstanceId, organizationGuid);
    }

    /**
     * User 상세 정보를 조회한다.
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param userId the userId
     * @return the users
     */
    @GetMapping(value = "/getUser")
    @ResponseBody
    public Users getUserByServiceInstanceId(@RequestParam("serviceInstanceId") String serviceInstanceId,
                                            @RequestParam("organizationGuid") String organizationGuid,
                                            @RequestParam("userId") String userId) {
        return userService.getUserByServiceInstanceId(serviceInstanceId, organizationGuid, userId);
    }

    /**
     * User 의 권한을 변경한다.
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param users the users
     * @return the users
     */
    @PostMapping(value = "/updateUserRole")
    @ResponseBody
    public Users updateUserRole(@RequestParam("serviceInstanceId") String serviceInstanceId,
                                @RequestParam("organizationGuid") String organizationGuid,
                                @RequestBody Users users){
        Users user = userService.getUserByServiceInstanceId(serviceInstanceId, organizationGuid, users.getUserId());
        user.setRoleSetCode(users.getRoleSetCode());
        return userService.updateUserRole(serviceInstanceId, organizationGuid, user);
    }

    /**
     * User 를 삭제한다.
     *
     * @param serviceInstanceId the serviceInstanceId
     * @param organizationGuid the organizationGuid
     * @param users the users
     * @return the users
     */
    @PostMapping(value = "/deleteUser")
    @ResponseBody
    public Users deleteUser(@RequestParam("serviceInstanceId") String serviceInstanceId,
                            @RequestParam("organizationGuid") String organizationGuid,
                            @RequestBody Users users){
        Users user = userService.getUserByServiceInstanceId(serviceInstanceId, organizationGuid, users.getUserId());
        return userService.deleteUserByServiceInstanceId(user);
    }
}
