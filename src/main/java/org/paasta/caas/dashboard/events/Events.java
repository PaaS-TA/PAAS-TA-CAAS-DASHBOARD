package org.paasta.caas.dashboard.events;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;
import org.paasta.caas.dashboard.common.model.CommonObjectReference;


/**
 * Events Model 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class Events {

    private String resultCode;
    private CommonMetaData metadata;
    //private String action;
    private int count;
    //private String eventTime;
    private String firstTimestamp;
    private String lastTimestamp;
    private String message;
    //private String reason;
    private EventSource source;
    private String type;
    private CommonObjectReference involvedObject;

    @Data
    public class EventSource {
        private String component;
        private String host;
    }
}
