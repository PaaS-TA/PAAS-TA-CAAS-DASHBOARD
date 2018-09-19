package org.paasta.caas.dashboard.intro.accessInfo;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Intro AccessInfo service 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.09.10
 */
@Service
public class AccessInfoService {

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Access info service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public AccessInfoService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Secret 을 조회한다.
     *
     * @param namespace       the namespace
     * @param accessTokenName the access token name
     * @return the token
     */
    AccessInfo getToken(String namespace, String accessTokenName) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, Constants.URI_API_SECRETS_DETAIL
                .replace("{namespace:.+}", namespace)
                .replace("{accessTokenName:.+}", accessTokenName),
            HttpMethod.GET, null, AccessInfo.class);
    }

}
