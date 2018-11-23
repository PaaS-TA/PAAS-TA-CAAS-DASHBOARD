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
     * Events 목록을 조회한다.
     *
     * @param namespace the namespace Name
     * @param resourceUid the resource Uid
     * @return the events list
     */
    EventsList getEventsList(String namespace, String resourceUid, String type) {
        if(type != null) {
            return restTemplateService.send(Constants.TARGET_CAAS_API, "/namespaces/"+namespace+"/events/resources/"+resourceUid+"?type="+type, HttpMethod.GET, null, EventsList.class);
        }
        return restTemplateService.send(Constants.TARGET_CAAS_API, "/namespaces/"+namespace+"/events/resources/"+resourceUid, HttpMethod.GET, null, EventsList.class);
    }

    /**
     * Events 목록을 조회한다.(for namespace)
     *
     * @param namespace the namespace Name
     * @return the events list
     */
    EventsList getNamespaceEventsList(String namespace) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, "/namespaces/"+namespace+"/events", HttpMethod.GET, null, EventsList.class);
    }
}
