package org.paasta.caas.dashboard.clusters.persistentVolumes;
import org.paasta.caas.dashboard.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.ResponseBody;

//import java.util.Map;

/**
 * ReplicaSet 관련 Caas API 를 호출 하는 컨트롤러이다.
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.06 최초작성
 */
@RestController
@RequestMapping("/clusters")
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
     * Gets persistentvolume main.
     *
     * @param httpServletRequest the http servlet request
     * @return the persistentvolume main
     */
    @GetMapping(value = "/persistentVolumes")
    public ModelAndView getpersistentvolumesListMain(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, "/persistentvolumes/persistentvolumes", new ModelAndView());
    }

    // TODO :: MODIFY
    /**
     * ReplicaSet 객체의 리스트를 조회한다.
     *
     * @return ReplicaSetList
     * @see PersistentVolumesService#getPersistentvolumeList
     */
    @GetMapping(value = "/api/persistentvolumes") // TEMP
    @ResponseBody
    public PersistentVolumesList getPersistentvolumeList(){
        return persistentVolumesService.getPersistentvolumeList();
    }

    /**
     * ReplicaSet 객체를 조회한다.
     *
     * @param pvName 조회 대상 PersistentVolume
     * @return ReplicaSetList
     * @see PersistentVolumesService#getPersistentvolume
     */
    @GetMapping(value = "/persistentvolumes/{pvName}")
    @ResponseBody
    public PersistentVolumes getReplicaSet(@PathVariable("pvName") String pvName ){
        return persistentVolumesService.getPersistentvolume(pvName);
    }

    // TOBE
}