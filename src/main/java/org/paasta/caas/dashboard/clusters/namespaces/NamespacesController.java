package org.paasta.caas.dashboard.clusters.namespaces;

import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Namespaces Controller 클래스.
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

    /**
     * Instantiates a Namespaces controller.
     *
     * @param commonService     the common service
     * @param namespacesService the namespaces service
     */
    @Autowired
    public NamespacesController(CommonService commonService, NamespacesService namespacesService) {
        this.commonService = commonService;
        this.namespacesService = namespacesService;
    }

    /**
     * Gets Namespaces main.
     *
     * @param httpServletRequest the http servlet request
     * @return the namespaces main
     */
    @GetMapping(value = {"/namespaces"})
    public ModelAndView getNamespaceMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/main", new ModelAndView());
    }

    /**
     * Gets Namespaces detail.
     *
     * @param httpServletRequest the http servlet request
     * @return the namespaces detail
     */
    @GetMapping(value = {"/namespaces/{namespace}"})
    public ModelAndView getNamespaceDetail(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/detail", new ModelAndView());
    }

    /**
     * Gets Namespaces.
     *
     * @param namespace the namespaces
     * @return the Namespaces
     */
    @GetMapping(value = "/namespaces/{namespace}/getDetail")
    public Namespaces getNamespaces(@PathVariable String namespace) {
        return namespacesService.getNamespaces(namespace);
    }

    /**
     * Gets ResourceQuotaList.
     *
     * @param namespace the namespaces
     * @return the ResourceQuotaList
     */
    @GetMapping(value = "/namespaces/{namespace}/getResourceQuotaList")
    public ResourceQuotaList getResourceQuotaList(@PathVariable String namespace) {
        return namespacesService.getResourceQuotaList(namespace);
    }

    /**
     * Gets Namespace events.
     *
     * @param httpServletRequest the http servlet request
     * @return the namespaces events
     */
    @GetMapping(value = {"/namespaces/{namespace}/events"})
    public ModelAndView getNamespaceEvents(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/events", new ModelAndView());
    }
}
