package org.paasta.caas.dashboard.clusters.namespaces;

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
public class NamespacesController {

    private static final String BASE_URL = "/namespaces";

    private final CommonService commonService;
    private final NamespacesService namespacesService;

    @Autowired
    public NamespacesController(CommonService commonService, NamespacesService namespacesService) {
        this.commonService = commonService;
        this.namespacesService = namespacesService;
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
    public Namespaces getNamespaces(@PathVariable String namespace) {
        return namespacesService.getNamespaces(namespace);
    }

    @GetMapping(value = "/namespaces/{namespace}/getResourceQuotaList.do")
    public ResourceQuotaList getResourceQuotaList(@PathVariable String namespace) {
        return namespacesService.getResourceQuotaList(namespace);
    }

    @GetMapping(value = {"/namespaces/{namespace}/events"})
    public ModelAndView getNamespaceEvents(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/events", new ModelAndView());
    }
}
