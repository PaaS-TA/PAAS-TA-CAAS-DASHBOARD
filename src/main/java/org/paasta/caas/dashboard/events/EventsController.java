package org.paasta.caas.dashboard.events;

import org.paasta.caas.dashboard.common.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
     * Gets Events list.
     *
     * @param namespace    the namespace
     * @param resourceName the resourceName
     * @return the event list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_EVENTS_LIST)
    @ResponseBody
    EventsList getEventList(@PathVariable("namespace") String namespace, @PathVariable("resourceName") String resourceName) {
        EventsList resultList = eventsService.getEventList(namespace, resourceName);

        // FOR DASHBOARD
        resultList.setResourceName(resourceName);
        return resultList;
    }

    /**
     * Gets namespace Events list.
     *
     * @param namespace    the namespace
     * @return the event list
     */
    @GetMapping(value = Constants.API_URL + Constants.URI_API_NAMESPACE_EVENTS_LIST)
    @ResponseBody
    EventsList getNamespaceEventList(@PathVariable("namespace") String namespace) {
        EventsList resultList = eventsService.getNamespaceEventList(namespace);

        return resultList;
    }
}
