package org.paasta.caas.dashboard.common.model;

import lombok.Data;

/**
 * AdminToken Model 클래스
 *
 * @author Hyerin
 * @version 1.0
 * @since 2018.08.22
 */
@Data
public class AdminToken {
    private String token_name;
    private String token_value;
}
