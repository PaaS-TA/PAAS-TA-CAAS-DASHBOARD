package org.paasta.caas.dashboard.endpoint;

import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Endpoint Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.13
 */
@Controller
public class EndpointController {

    private static final String BASE_URL = "/endpoints";
    private final EndpointService endpointService;

    /**
     * Instantiates a new Endpoint controller.
     *
     * @param endpointService the endpoint service
     */
    @Autowired
    public EndpointController(EndpointService endpointService) {
        this.endpointService = endpointService;
    }


    // TODO :: REMOVE
    /**
     * Gets endpoint list.
     *
     * @return the endpoint list
     */
//    @GetMapping(value = Constants.API_URL + BASE_URL)
//    @ResponseBody
//    public EndpointList getEndpointList() {
//        return endpointService.getEndpointList();
//    }


    /**
     * Gets endpoint.
     *
     * @param serviceName the service name
     * @return the endpoint
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{serviceName:.+}")
    @ResponseBody
    public Endpoint getEndpoint(@PathVariable("serviceName") String serviceName) {
        return endpointService.getEndpoint(serviceName);
    }

}
