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
     * @param namespace the namespace
     * @return the custom services list
     */
    CustomServicesList getCustomServicesList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_SERVICES_LIST
                        .replace("{namespace:.+}", namespace),
                HttpMethod.GET, null, CustomServicesList.class);
    }


    /**
     * Gets custom services.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @return the custom services
     */
    CustomServices getCustomServices(String namespace, String serviceName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_SERVICES_DETAIL
                        .replace("{namespace:.+}", namespace)
                        .replace("{serviceName:.+}", serviceName),
                HttpMethod.GET, null, CustomServices.class);
    }


    /**
     * Gets custom services list.
     *
     * @param namespace the namespace
     * @return the custom services list
     */
    CustomServicesList getCustomServicesListLabelSelector(String namespace, String selectors) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_SERVICES_RESOURCES
                        .replace("{namespace:.+}", namespace)
                        .replace("{selector:.+}", selectors),
                HttpMethod.GET, null, CustomServicesList.class);
    }

}
