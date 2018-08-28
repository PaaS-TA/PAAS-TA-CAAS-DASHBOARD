package org.paasta.caas.dashboard.clusters.namespace;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


/**
 * Namespace 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@RestController
@RequestMapping("/caas/clusters")
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
    public ModelAndView getNamespaceMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    @GetMapping(value = {"/namespaces/{namespace}"})
    public ModelAndView getNamespaceDetail(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    @GetMapping(value = "/namespaces/{namespace}/getDetail.do")
    public Namespace getNamespaces(@PathVariable String namespace) {
        return namespaceService.getNamespaces(namespace);
    }

    @GetMapping(value = "/namespaces/{namespace}/getResourceQuotaList.do")
    public ResourceQuota getResourceQuotaList(@PathVariable String namespace) {
        return null;
    }
}
