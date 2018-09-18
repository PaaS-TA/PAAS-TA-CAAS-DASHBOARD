package org.paasta.caas.dashboard.nodes.support;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * Nodes status model 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.17
 */
@Data
public class NodesStatus {
    private Map<String, Object> capacity;
    private Map<String, Object> allocatable;

    private List<Map<String, Object>> conditions;
    private List<NodesAddress> addresses;
    private NodesSystemInfo nodeInfo;
}
