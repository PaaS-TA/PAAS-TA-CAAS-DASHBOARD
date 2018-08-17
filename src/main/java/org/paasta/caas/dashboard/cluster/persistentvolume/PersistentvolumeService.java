package org.paasta.caas.dashboard.cluster.persistentvolume;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Persistentvolume Service 클래스
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class PersistentvolumeService {

    //private static final String REQ_URL = "/" + Constants.NAMESPACE_NAME + "/replicaset";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new replicaset service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public PersistentvolumeService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets persistentvolume list.
     *
     * @return the persistentvolume list
     */
    PersistentvolumeList getPersistentvolumeList() {
        // TODO :: reqUrl 따로 관리 여부 결정
        String reqUrl = "/cluster/persistentvolumes";
        return restTemplateService.send(Constants.TARGET_CAAS_API, reqUrl, HttpMethod.GET, null, PersistentvolumeList.class);
    }


    /**
     * Gets persistentvolume.
     *
     * @param pvName the persistentvolume name
     * @return the persistentvolume
     */
    Persistentvolume getPersistentvolume(String pvName) {
        // TODO :: reqUrl 따로 관리 여부 결정
        String reqUrl = "/cluster/persistentvolumes/{pvName}"
                .replaceAll("\\{" + "pvName" + "\\}", pvName);
        return restTemplateService.send(Constants.TARGET_CAAS_API, reqUrl, HttpMethod.GET, null, Persistentvolume.class);
    }

}
