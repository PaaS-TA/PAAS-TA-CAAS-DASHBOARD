package org.paasta.caas.dashboard.customService;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Custom Service Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.09
 */
@Service
public class CustomServiceService {

    private static final String REQ_URL = "/" + Constants.NAMESPACE_NAME + "/services";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Custom service service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public CustomServiceService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Gets custom service list.
     *
     * @return the custom service list
     */
    CustomServiceList getCustomServiceList() {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL, HttpMethod.GET, null, CustomServiceList.class);
    }

    /**
     * Gets custom service.
     *
     * @param serviceName the service name
     * @return the custom service
     */
    CustomService getCustomService(String serviceName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL + "/" + serviceName, HttpMethod.GET, null, CustomService.class);
    }

}
