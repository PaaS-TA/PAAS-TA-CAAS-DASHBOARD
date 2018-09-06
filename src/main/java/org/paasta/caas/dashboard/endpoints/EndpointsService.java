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

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Endpoints service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public EndpointsService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Endpoints 상세 정보를 조회한다.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @return the endpoints
     */
    Endpoints getEndpoints(String namespace, String serviceName) {
        String TARGET_CAAS_API = Constants.TARGET_CAAS_API;
        return restTemplateService.send(TARGET_CAAS_API, Constants.URI_API_ENDPOINTS_DETAIL
                        .replace("{namespace:.+}", namespace)
                        .replace("{serviceName:.+}", serviceName),
                HttpMethod.GET, null, Endpoints.class);
    }

}
