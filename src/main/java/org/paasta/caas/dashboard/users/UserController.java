package org.paasta.caas.dashboard.users;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
@RequestMapping(value = "/users")
public class UserController {

    private static final String BASE_URL = "/users";
    private final CommonService commonService;
    private final UserService userService;

    /**
     * Instantiates a new User controller.
     *
     * @param commonService the common service
     * @param userService   the user service
     */
    @Autowired
    public UserController(CommonService commonService, UserService userService) {
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
     * Gets service instance list.
     *
     * @return the service instance list
     */
    @GetMapping(value = "/getList.do")
    @ResponseBody
    public List getServiceInstanceList() {
        return userService.getUserList();
    }
}
