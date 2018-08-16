package org.paasta.caas.dashboard.cluster.namespace;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.config.EnvConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.HashMap;
import java.util.Map;

//import org.apache.http.client.HttpClient;
//import javax.servlet.http.HttpServletResponse;


/**
 * CLUSTER Service
 *
 * @author 최윤석
 * @version 1.0
 * @since 2018.8.01 최초작성
 */
@Service
public class NamespaceService {

    //private static final Logger LOGGER = LoggerFactory.getLogger(NamespaceService.class);
    private static final String REQ_URL = "/cluster/namespaces";

    private final RestTemplateService restTemplateService;

    @Autowired
    public NamespaceService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * 네임스페이스 리스트 조회
     *
     * @return int int
     */
    Namespace getNamespaceList() {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL, HttpMethod.GET, null, Namespace.class);
    }

}
