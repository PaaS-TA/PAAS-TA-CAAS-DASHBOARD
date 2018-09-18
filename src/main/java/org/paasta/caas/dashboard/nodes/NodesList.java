package org.paasta.caas.dashboard.nodes;

import lombok.Data;

import java.util.List;

/**
 * Nodes List Model 클래스
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class NodesList {
    private String resultCode;
    private String resultMessage;

    private List<Nodes> items;
}
