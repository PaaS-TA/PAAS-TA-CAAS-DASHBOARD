package org.paasta.caas.dashboard.common;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * Property Service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.07
 */
@Service
@Data
public class PropertyService {

    @Value("${caas.url}")
    private String caasUrl;

    @Value("${caas.cluster-name}")
    private String caasClusterName;

    @Value("${caasApi.url}")
    private String caasApiUrl;

    @Value("${commonApi.url}")
    private String commonApiUrl;

    @Value("${roleSet.administratorCode}")
    private String administratorCode;

    @Value("${roleSet.regularUserCode}")
    private String regularUserCode;

    @Value("${roleSet.initUserCode}")
    private String initUserCode;

    @Value("${roleSet.administratorName}")
    private String administratorName;

    @Value("${roleSet.regularUserName}")
    private String regularUserName;

    @Value("${roleSet.initUserName}")
    private String initUserName;

    @Value("${private.registry.imageName}")
    private String privateRegistryImageName;

    @Value("${private.registry.url}")
    private String privateRegistryUrl;
}
