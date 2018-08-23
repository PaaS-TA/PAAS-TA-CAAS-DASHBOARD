package org.paasta.caas.dashboard.event;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.event.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Event Service 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.13
 */
@Service
public class EventService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Event service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public EventService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Gets eventList.
     *
     * @param namespace the namespace Name
     * @param resourceName the resource Name
     * @return the eventList
     */
    EventList getEventList(String namespace, String resourceName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, "/namespaces/"+namespace+"/events/resource/"+resourceName, HttpMethod.GET, null, EventList.class);
    }

}
