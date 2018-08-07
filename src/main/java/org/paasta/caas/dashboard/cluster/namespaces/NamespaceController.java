package org.paasta.caas.dashboard.cluster.namespaces;

//import org.springframework.http.HttpMethod;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

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

    private static final String BASE_URL = "/namespace";

    private final CommonService commonService;
    private final NamespaceService namespaceService;

    @Autowired
    public NamespaceController(CommonService commonService, NamespaceService namespaceService) {
        this.commonService = commonService;
        this.namespaceService = namespaceService;
    }

    //private final String V2_URL = "/v2";

    /**
     * 메인페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
    // TODO :: REMOVE
    @GetMapping(value = {"/main"})
    public ModelAndView getDashboardMain() {
        return new ModelAndView() {{
            setViewName("main/main");
            //addObject("ORGANIZATION_ID", "");
        }};
    }

    /**
     * description.
     *
     * //@param req   HttpServletRequest(자바클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    // TODO :: REMOVE
//    @GetMapping("/namespaces")
//    @ResponseBody
//    public Map<String, Object> getNamespaceList(@RequestParam Map<String, Object> map) throws Exception {
//        return namespaceService.getNamespaceList(map);
//    }


    @GetMapping(value = {"/namespace"})
    public ModelAndView getUserMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }


    @GetMapping(value = "/namespace/getList.do")
    @ResponseBody
    public Namespace getServiceInstanceList() {
        return namespaceService.getNamespaceList();
    }
}
