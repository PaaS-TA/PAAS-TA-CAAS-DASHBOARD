package org.paasta.caas.dashboard.cluster;

//import org.springframework.http.HttpMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

//import java.util.Map;

/**
 * 운영자 포탈 관리자 대시보드 관련 API 를 호출 하는 컨트롤러이다.
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.09.08 최초작성
 */
@RestController
public class ClusterController {

    private final ClusterService clusterService;

    @Autowired
    public ClusterController(ClusterService clusterService) {
        this.clusterService = clusterService;
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
        return clusterService.getNamespaceList(map);
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
