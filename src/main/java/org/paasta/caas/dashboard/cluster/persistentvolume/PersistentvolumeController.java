package org.paasta.caas.dashboard.cluster.persistentvolume;
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
public class PersistentvolumeController {

    private final PersistentvolumeService persistentvolumeService;
    private final CommonService commonService;

    /**
     * Instantiates a Replicaset controller.
     *
     * @param commonService     the common service
     * @param persistentvolumeService the persistentvolume service
     */
    @Autowired
    public PersistentvolumeController(CommonService commonService, PersistentvolumeService persistentvolumeService) {
        this.commonService = commonService;
        this.persistentvolumeService = persistentvolumeService;
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
     * @see PersistentvolumeService#getPersistentvolumeList
     */
    @GetMapping(value = "/api/persistentvolumes") // TEMP
    @ResponseBody
    public PersistentvolumeList getPersistentvolumeList(){
        return persistentvolumeService.getPersistentvolumeList();
    }

    /**
     * ReplicaSet 객체를 조회한다.
     *
     * @param pvName 조회 대상 PersistentVolume
     * @return ReplicaSetList
     * @see PersistentvolumeService#getPersistentvolume
     */
    @GetMapping(value = "/persistentvolumes/{pvName}")
    @ResponseBody
    public Persistentvolume getReplicaSet(@PathVariable("pvName") String pvName ){
        return persistentvolumeService.getPersistentvolume(pvName);
    }

    // TOBE
}