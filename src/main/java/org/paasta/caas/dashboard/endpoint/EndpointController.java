package org.paasta.caas.dashboard.endpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Endpoint Controller 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.13
 */
@Controller
@RequestMapping(value = "/endpoints")
public class EndpointController {

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

    /**
     * Gets endpoint list.
     *
     * @return the endpoint list
     */
    @GetMapping(value = "/getList.do")
    @ResponseBody
    public EndpointList getEndpointList() {
        return endpointService.getEndpointList();
    }


    /**
     * Gets endpoint.
     *
     * @param endpoint the endpoint
     * @return the endpoint
     */
//    @GetMapping(value = "/get.do")
//    @ResponseBody
//    public Endpoint getEndpoint(Endpoint endpoint) {
//        return endpointService.getEndpoint(endpoint.getServiceName());
//    }

}
