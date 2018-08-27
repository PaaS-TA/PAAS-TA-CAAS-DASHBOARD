package org.paasta.caas.dashboard.cluster.namespace;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;

//import java.util.Map;

/**
 * Namespace 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
@RequestMapping("/cluster")
public class NamespaceController {

    private static final String BASE_URL = "/namespaces";

    private final CommonService commonService;
    private final NamespaceService namespaceService;

    @Autowired
    public NamespaceController(CommonService commonService, NamespaceService namespaceService) {
        this.commonService = commonService;
        this.namespaceService = namespaceService;
    }

    @GetMapping(value = {"/namespaces"})
    public ModelAndView getUserMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }


    @GetMapping(value = "/namespaces/getList.do")
    @ResponseBody
    public Namespace getServiceInstanceList() {
        return namespaceService.getNamespaceList();
    }
}
