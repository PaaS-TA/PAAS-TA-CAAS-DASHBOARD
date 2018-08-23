package org.paasta.caas.dashboard.event;

import lombok.Data;
import org.paasta.caas.dashboard.common.model.CommonMetaData;


/**
 * Event Model 클래스
 *
 * @author CISS
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class Event {

    private String resultCode;
    private CommonMetaData metadata;
    //private String action = null;

    private int count;
    //private DateTime eventTime = null;
    private String firstTimestamp;
    private String lastTimestamp;
    private String message;
    //private String reason;
    private EventSource source;
    private String type;

    @Data
    public class EventSource {
        private String component;
        private String host;
    }
}
