package org.paasta.caas.dashboard.clusters.namespace;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

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
