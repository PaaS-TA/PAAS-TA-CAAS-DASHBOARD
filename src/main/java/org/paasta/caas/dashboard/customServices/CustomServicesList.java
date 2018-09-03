package org.paasta.caas.dashboard.customServices;

import lombok.Data;

import java.util.List;

/**
 * Custom Services List Model 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.8.09
 */
@Data
class CustomServicesList {

    private String resultCode;
    private String resultMessage;

    private List<CustomServices> items;

}
