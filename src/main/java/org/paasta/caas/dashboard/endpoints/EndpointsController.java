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
     * Endpoints 상세 정보를 조회한다.
     *
     * @param namespace   the namespace
     * @param serviceName the service name
     * @return the endpoints
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_ENDPOINTS_DETAIL)
    @ResponseBody
    public Endpoints getEndpoints(@PathVariable(value = "namespace") String namespace, @PathVariable(value = "serviceName") String serviceName) {
        return endpointsService.getEndpoints(namespace, serviceName);
    }

}
