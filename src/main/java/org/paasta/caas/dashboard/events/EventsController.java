package org.paasta.caas.dashboard.events;

import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Events Controller 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.13
 */
@Controller
public class EventsController {
    private final EventsService eventsService;

    /**
     * Instantiates a new Events controller.
     *
     * @param eventsService the event service
     */
    @Autowired
    public EventsController(EventsService eventsService) {
        this.eventsService = eventsService;
    }

    /**
     * Events 목록을 조회한다.
     *
     * @param namespace    the namespace
     * @param resourceUid the resourceUid
     * @return the events list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_EVENTS_LIST)
    @ResponseBody
    EventsList getEventsList(@PathVariable("namespace") String namespace, @PathVariable("resourceUid") String resourceUid, @RequestParam(value="type", required=false) String type, @RequestParam(value="status", required=false) String status) {
        EventsList resultList = eventsService.getEventsList(namespace, resourceUid, type);

        // FOR DASHBOARD
        resultList.setResourceName(resourceUid);
        if(status != null) {
            resultList.setStatus(status);
        }
        return resultList;
    }

    /**
     * Events 목록을 조회한다.(for namespace)
     *
     * @param namespace the namespace
     * @return the events list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_NAMESPACE_EVENTS_LIST)
    @ResponseBody
    EventsList getNamespaceEventsList(@PathVariable("namespace") String namespace) {
        return eventsService.getNamespaceEventsList(namespace);
    }
}
