package org.paasta.caas.dashboard.clusters.persistentVolumes;
import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * PersistentVolumes 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
public class PersistentVolumesController {

    private final PersistentVolumesService persistentVolumesService;
    private final CommonService commonService;

    /**
     * Instantiates a ReplicaSets controller.
     *
     * @param commonService     the common service
     * @param persistentVolumesService the persistentvolume service
     */
    @Autowired
    public PersistentVolumesController(CommonService commonService, PersistentVolumesService persistentVolumesService) {
        this.commonService = commonService;
        this.persistentVolumesService = persistentVolumesService;
    }

    /**
     * Gets PersistentVolumes main.
     *
     * @param httpServletRequest the http servlet request
     * @return the custom service main
     */
    @GetMapping(value = "/caas/clusters/persistentVolumes")
    public ModelAndView getPersistentVolumesMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, "/persistentvolumes/main", new ModelAndView());
    }

    /**
     * Gets PersistentVolumes detail.
     *
     * @param httpServletRequest the http servlet request
     * @param pvName        the persistent Volumes name
     * @return the custom services detail
     */
    @GetMapping(value = "/caas/clusters/persistentVolumes/{pvName:.+}")
    public ModelAndView getPersistentVolumesDetail(HttpServletRequest httpServletRequest, @PathVariable(value = "pvName") String pvName) {
        return commonService.setPathVariables(httpServletRequest, "/persistentvolumes/detail", new ModelAndView());
    }

    /**
     * Gets PersistentVolumes detail yaml.
     *
     * @param httpServletRequest the http servlet request
     * @param pvName        the persistent Volumes
     * @return the custom services detail events
     */
    @GetMapping(value = "/caas/clusters/persistentVolumes/{pvName:.+}/yaml")
    public ModelAndView getPersistentVolumesYaml(HttpServletRequest httpServletRequest, @PathVariable(value = "pvName") String pvName) {
        return commonService.setPathVariables(httpServletRequest, "/persistentvolumes/yaml", new ModelAndView());
    }

    /**
     * Gets PersistentVolumes list.
     *
     * @return the replicaSet list
     */
    @GetMapping(value = "/api/persistentvolumes")
    @ResponseBody
    public PersistentVolumesList getPersistentVolumesList(){
        return persistentVolumesService.getPersistentvolumeList();
    }

    /**
     * Gets PersistentVolumes.
     *
     * @param pvName the replicaset name
     * @return the replicaSet
     */
    @GetMapping(value = "/api/persistentvolumes/{pvName}")
    @ResponseBody
    public PersistentVolumes getPersistentVolumes(@PathVariable("pvName") String pvName ){
        return persistentVolumesService.getPersistentvolume(pvName);
    }

}