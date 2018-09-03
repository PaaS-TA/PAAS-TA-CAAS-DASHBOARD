package org.paasta.caas.dashboard.endpoints;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Endpoints Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class EndpointsService {

    private static final String REQ_URL = "/endpoints";
    private final String TARGET_CAAS_API = Constants.TARGET_CAAS_API;
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Endpoints service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public EndpointsService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets endpoints.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @return the endpoints
     */
    Endpoints getEndpoints(String namespace, String serviceName) {
        return restTemplateService.send(TARGET_CAAS_API, Constants.API_NAMESPACES + namespace + REQ_URL + "/" + serviceName,
                HttpMethod.GET, null, Endpoints.class);
    }

}
