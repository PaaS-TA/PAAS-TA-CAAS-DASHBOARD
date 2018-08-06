package org.paasta.caas.dashboard.cluster.namespaces;

//import org.springframework.http.HttpMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

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

    private final NamespaceService namespaceService;

    @Autowired
    public NamespaceController(NamespaceService namespaceService) {
        this.namespaceService = namespaceService;
    }

    //private final String V2_URL = "/v2";

    /**
     * 메인페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
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
    @GetMapping("/namespaces")
    @ResponseBody
    public Map<String, Object> getNamespaceList(@RequestParam Map<String, Object> map) throws Exception {
        return namespaceService.getNamespaceList(map);
    }


    /**
     * 해당 조직에 대한 공간들의 통계 목록들을 조회한다.
     * *
     * @return Map(자바클래스)
     */
//    @GetMapping(value = {V2_URL + "/statistics/organizations/{organizationId}/spaces"})
//    @ResponseBody
//    public Map<String, Object> getTotalSpaceList(@PathVariable String organizationId) {
//        // spaceId, spaceName, applicationCount Info
//        return commonService.procCommonApiRestTemplate(V2_URL + "/statistics/organizations/"+organizationId+"/spaces", HttpMethod.GET, null, null);
//    }

}
