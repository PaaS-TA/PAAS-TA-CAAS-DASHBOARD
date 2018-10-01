package org.paasta.caas.dashboard.intro.accessInfo;

import lombok.Data;

/**
 * Intro AccessInfo Model 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2018.09.10
 */
@Data
class AccessInfo {
    private String resultCode;

    private String caCertToken;
    private String userAccessToken;
}
