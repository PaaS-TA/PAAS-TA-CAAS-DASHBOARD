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

    private static final String API_URL = Constants.API_URL;
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
     * @param namespace the namespace
     * @param resourceName the resourceName
     * @return the event list
     */
    @GetMapping(value = API_URL + "/namespaces/{namespace:.+}/events/resource/{resourceName:.+}")
    @ResponseBody
    EventsList getEventList(@PathVariable("namespace") String namespace
            , @PathVariable("resourceName") String resourceName) {
        EventsList resultList = eventsService.getEventList(namespace, resourceName);

        // FOR DASHBOARD
        resultList.setResourceName(resourceName);
        return resultList;
    }

    /**
     * Get Event List with filtering node's name.
     * @param namespace
     * @param nodeName
     * @return
     */
    @GetMapping(value = API_URL + "/namespaces/{namespace:.+}/events/node/{nodeName:.+}")
    @ResponseBody
    EventsList getEventListByNode(@PathVariable("namespace") String namespace, @PathVariable("nodeName") String nodeName) {
        return eventsService.getEventListByNode(namespace, nodeName);
    }
}
