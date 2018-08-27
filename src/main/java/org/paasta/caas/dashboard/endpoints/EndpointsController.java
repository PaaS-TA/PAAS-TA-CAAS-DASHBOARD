package org.paasta.caas.dashboard.endpoints;

import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Endpoints Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.13
 */
@Controller
public class EndpointsController {

    private static final String BASE_URL = "/endpoints";
    private final EndpointsService endpointsService;

    /**
     * Instantiates a new Endpoints controller.
     *
     * @param endpointsService the endpoints service
     */
    @Autowired
    public EndpointsController(EndpointsService endpointsService) {
        this.endpointsService = endpointsService;
    }


    /**
     * Gets endpoints.
     *
     * @param serviceName the service name
     * @return the endpoints
     */
    @GetMapping(value = Constants.API_URL + BASE_URL + "/{serviceName:.+}")
    @ResponseBody
    public Endpoints getEndpoints(@PathVariable("serviceName") String serviceName) {
        return endpointsService.getEndpoints(serviceName);
    }

}
