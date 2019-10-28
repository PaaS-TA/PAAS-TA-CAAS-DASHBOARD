package org.paasta.caas.dashboard.persistentVolumeClaims;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * PersistentVolumeClaims Service 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2019-10-24
 */
@Service
public class PersistentVolumeClaimsService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new deployments service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public PersistentVolumeClaimsService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }


    /**
     * PersistentVolumeClaims 목록을 조회한다.
     *
     * @param namespace the namespace
     * @return the PersistentVolumeClaims List
     */
    PersistentVolumeClaimsList getPersistentVolumeClaimsList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_STORAGES_LIST
                        .replace("{namespace:.+}", namespace),
                HttpMethod.GET, null, PersistentVolumeClaimsList.class);
    }
//
//    /**
//     * PersistentVolumeClaims 상세 정보를 조회한다.
//     *
//     * @param namespace                     the namespace
//     * @param persistentVolumeClaimName  the PersistentVolumeClaims
//     * @return the PersistentVolumeClaims
//     */
//    public PersistentVolumeClaims getPersistentVolumeClaims(String namespace, String persistentVolumeClaimName) {
//        HashMap responseMap = (HashMap) restTemplateService.send(Constants.TARGET_CAAS_MASTER_API,
//                propertyService.getCaasMasterApiListPersistentVolumeClaimsGetUrl()
//                        .replace("{namespace}", namespace)
//                        .replace("{name}", persistentVolumeClaimName)
//                , HttpMethod.GET, null, Map.class);
//
//        return (PersistentVolumeClaims) commonService.setResultModel(commonService.setResultObject(responseMap, PersistentVolumeClaims.class), Constants.RESULT_STATUS_SUCCESS);
//    }
}
