package org.paasta.caas.dashboard.clusters.namespaces;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
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
public class NamespacesController {

    private static final String VIEW_URL = "/namespaces";

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
     * Namespaces detail 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the namespaces detail
     */
    @GetMapping(value = Constants.URI_CLUSTER_NAMESPACES + "/{namespace:.+}")
    public ModelAndView getNamespaceDetail(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/detail", new ModelAndView());
    }

    /**
     * Namespaces 상세 정보를 조회한다.
     *
     * @param namespace the namespaces
     * @return the Namespaces
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_NAME_SPACES_DETAIL)
    public Namespaces getNamespaces(@PathVariable String namespace) {
        return namespacesService.getNamespaces(namespace);
    }

    /**
     * Namespaces ResourceQuota 정보를 조회한다.
     *
     * @param namespace the namespaces
     * @return the ResourceQuotaList
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_NAME_SPACES_RESOURCE_QUOTAS)
    public ResourceQuotaList getResourceQuotaList(@PathVariable String namespace) {
        return namespacesService.getResourceQuotaList(namespace);
    }

    /**
     * Namespaces events 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the namespaces events
     */
    @GetMapping(value = Constants.URI_CLUSTER_NAMESPACES + "/{namespace:.+}/events")
    public ModelAndView getNamespaceEvents(HttpServletRequest httpServletRequest, @PathVariable String namespace) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/events", new ModelAndView());
    }
}
