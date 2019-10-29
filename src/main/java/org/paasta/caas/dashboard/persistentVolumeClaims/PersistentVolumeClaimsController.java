package org.paasta.caas.dashboard.persistentVolumeClaims;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * PersistentVolumeClaims Controller 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2019-10-24
 */
@RestController
@RequestMapping
public class PersistentVolumeClaimsController {

    private static final String VIEW_URL = "/persistentVolumeClaims";
    private final CommonService commonService;
    private final PersistentVolumeClaimsService persistentVolumeClaimsService;

    /**
     * Instantiates a new persistentVolumeClaims controller.
     *
     * @param commonService                     the common service
     * @param persistentVolumeClaimsService  the persistentVolumeClaims Service
     */
    @Autowired
    public PersistentVolumeClaimsController(CommonService commonService, PersistentVolumeClaimsService persistentVolumeClaimsService) {
        this.commonService = commonService;
        this.persistentVolumeClaimsService = persistentVolumeClaimsService;
    }


    /**
     * Storages main 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the storages main
     */
    @GetMapping(value = Constants.URI_STORAGES)
    public ModelAndView getStoragesMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/main", new ModelAndView());
    }


    /**
     * Storages detail 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the storages detail
     */
    @GetMapping(value = Constants.URI_STORAGES + "/{persistentVolumeClaimName:.+}")
    public ModelAndView getStoragesDetail(HttpServletRequest httpServletRequest, @PathVariable(value = "persistentVolumeClaimName") String persistentVolumeClaimName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/detail", new ModelAndView());
    }


    /**
     * Persistent Volume Claim events 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the persistentVolumeClaim detail events
     */
    @GetMapping(value = Constants.URI_STORAGES + "/{persistentVolumeClaimName:.+}/events")
    public ModelAndView getPersistentVolumeClaimEvent(HttpServletRequest httpServletRequest, @PathVariable(value = "persistentVolumeClaimName") String persistentVolumeClaimName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/events", new ModelAndView());
    }


    /**
     * Persistent Volume Claim yaml 페이지로 이동한다.
     *
     * @param httpServletRequest the http servlet request
     * @return the persistentVolumeClaim detail yaml
     */
    @GetMapping(value = Constants.URI_STORAGES + "/{persistentVolumeClaimName:.+}/yaml")
    public ModelAndView getPersistentVolumeClaimYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "persistentVolumeClaimName") String persistentVolumeClaimName) {
        return commonService.setPathVariables(httpServletRequest, VIEW_URL + "/yaml", new ModelAndView());
    }


    /**
     * PersistentVolumeClaims 목록을 조회한다.
     *
     * @param namespace the namespace
     * @return the persistent volumes list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_STORAGES_LIST)
    @ResponseBody
    public PersistentVolumeClaimsList getPersistentVolumeClaimsList(@PathVariable(value = "namespace") String namespace) {
        return persistentVolumeClaimsService.getPersistentVolumeClaimsList(namespace);
    }

    /**
     * PersistentVolumeClaims 상세 정보를 조회한다.
     *
     * @param namespace                    the namespace
     * @param persistentVolumeClaimName the persistent volume claim name
     * @return the PersistentVolumeClaims
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_STORAGES_DETAIL)
    public PersistentVolumeClaims getPersistentVolumeClaims(@PathVariable(value = "namespace") String namespace, @PathVariable(value = "persistentVolumeClaimName") String persistentVolumeClaimName) {
        return persistentVolumeClaimsService.getPersistentVolumeClaims(namespace, persistentVolumeClaimName);
    }


    /**
     * PersistentVolumeClaims YAML을 조회한다.
     *
     * @param namespace                    the namespace
     * @param persistentVolumeClaimName the persistent volume claim name
     * @return the PersistentVolumeClaims
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_STORAGES_YAML)
    public PersistentVolumeClaims getPersistentVolumeClaimYaml(@PathVariable(value = "namespace") String namespace,
                           @PathVariable(value = "persistentVolumeClaimName") String persistentVolumeClaimName) {
        return persistentVolumeClaimsService.getPersistentVolumeClaimYaml(namespace, persistentVolumeClaimName);
    }
}
