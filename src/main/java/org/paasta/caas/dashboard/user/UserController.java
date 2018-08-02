package org.paasta.caas.dashboard.user;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    private static final String BASE_URL = "/user";
    private final CommonService commonService;
    private final UserService userService;

    @Autowired
    public UserController(CommonService commonService, UserService userService) {this.commonService = commonService;
        this.userService = userService;
    }

    @GetMapping
    public ModelAndView getUserMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    @GetMapping(value = "/getList.do")
    @ResponseBody
    public List<User> getServiceInstanceList(){
        return userService.getUserList();
    }
}
