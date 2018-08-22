package org.paasta.caas.dashboard.endpoint;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Endpoint Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class EndpointService {

    private static final String REQ_URL = "/" + Constants.NAMESPACE_NAME + "/endpoints";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Endpoint service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public EndpointService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    // TODO :: REMOVE
    /**
     * Gets endpoint list.
     *
     * @return the endpoint list
     */
//    EndpointList getEndpointList() {
//        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL, HttpMethod.GET, null, EndpointList.class);
//    }


    /**
     * Gets endpoint.
     *
     * @param serviceName the service name
     * @return the endpoint
     */
    Endpoint getEndpoint(String serviceName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL + "/" + serviceName, HttpMethod.GET, null, Endpoint.class);
    }

}
