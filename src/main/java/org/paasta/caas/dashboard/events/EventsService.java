package org.paasta.caas.dashboard.events;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Events Service 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class EventsService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Events service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public EventsService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Gets eventList.
     *
     * @param namespace the namespace Name
     * @param resourceName the resource Name
     * @return the eventList
     */
    EventsList getEventList(String namespace, String resourceName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, "/namespaces/"+namespace+"/events/resource/"+resourceName, HttpMethod.GET, null, EventsList.class);
    }

}
