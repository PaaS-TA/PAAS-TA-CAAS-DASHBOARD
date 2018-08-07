package org.paasta.caas.dashboard.cluster.namespaces;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.paasta.caas.dashboard.config.EnvConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

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

    private static final Logger LOGGER = LoggerFactory.getLogger(NamespaceService.class);
    private static final String REQ_URL = "/cluster/namespaces";

    // TODO :: REMOVE
    @Autowired
    RestTemplate restTemplate;

    // TODO :: REMOVE
    @Autowired
    private EnvConfig envConfig;

    private final RestTemplateService restTemplateService;

    @Autowired
    public NamespaceService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * 네임스페이스 리스트 조회
     *
     * @return int int
     */
    // TODO :: REMOVE
//    public Map<String, Object> getNamespaceList(Map<String, Object> map) {
//        Map result = new HashMap();
//
//        HttpHeaders headers = new HttpHeaders();
//        //headers.add("Authorization", "Bearer "+kubeAccountToken);
//        //headers.add("Content-Type", "application/json");
//
//        Map<String, Object> param = new HashMap<>();
//        String kubeAccountToken = "";
//        if (!ObjectUtils.isEmpty(map.get("token"))) {
//            kubeAccountToken = map.get("token").toString();
//            LOGGER.info("Get InputToken : "+ kubeAccountToken);
//        }
//        //URI Builder
//        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(envConfig.getCaasApiUrl()+"/cluster/namespaces")
//                .queryParam("token", kubeAccountToken);
//
//        HttpEntity<Map> resetEntity = new HttpEntity(headers);
//        ResponseEntity<Map> responseEntity = restTemplate.exchange(builder.toUriString(), HttpMethod.GET, resetEntity, Map.class);
//
//        LOGGER.debug(responseEntity.getBody().toString());
//
//        result.put("result", "success");
//        result.put("data", responseEntity.getBody());
//        result.put("statusCode", responseEntity.getStatusCodeValue());
//
//        return result;
//    }

    Namespace getNamespaceList() {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL, HttpMethod.GET, null, Namespace.class);
    }

}
