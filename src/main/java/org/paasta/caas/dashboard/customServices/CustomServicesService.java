package org.paasta.caas.dashboard.customServices;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Custom Services Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.09
 */
@Service
public class CustomServicesService {

    private static final String REQ_URL = "/" + Constants.NAMESPACE_NAME + "/services";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Custom services service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public CustomServicesService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets custom services list.
     *
     * @return the custom services list
     */
    CustomServicesList getCustomServicesList() {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL, HttpMethod.GET, null, CustomServicesList.class);
    }


    /**
     * Gets custom services.
     *
     * @param serviceName the service name
     * @return the custom services
     */
    CustomServices getCustomServices(String serviceName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL + "/" + serviceName, HttpMethod.GET, null, CustomServices.class);
    }

}
