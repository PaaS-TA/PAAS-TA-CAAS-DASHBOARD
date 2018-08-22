package org.paasta.caas.dashboard.workload.pod;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

// TODO :: REMOVE
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
public class PodService {

    private static final String REQ_URL = "/" + Constants.NAMESPACE_NAME + "/workload/pods";
    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Pod service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public PodService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    // TODO :: REMOVE
//    private static final Logger LOGGER = LoggerFactory.getLogger(PodService.class);
//
//    @Autowired
//    RestTemplate restTemplate;
//
//    @Autowired

//    private EnvConfig envConfig;

//    /**
//     * 네임스페이스 리스트 조회
//     *
//     * @return int int
//     */
//    public Map<String, Object> getPodList(String namespace, Map<String, Object> map) {
//        Map result = new HashMap();
//
//        HttpHeaders headers = new HttpHeaders();
//        //headers.add("Authorization", "Bearer "+kubeAccountToken);
//        //headers.add("Content-Type", "application/json");
//
//        String kubeAccountToken = "";
//        if (!ObjectUtils.isEmpty(map.get("token"))) {
//            kubeAccountToken = map.get("token").toString();
//            LOGGER.info("Get InputToken : "+ kubeAccountToken);
//        }
//
//        //URI Builder
//        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(envConfig.getCaasApiUrl()+"/workload/namespaces/"+namespace+"/pods")
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


    // TODO :: REMOVE
    /**
     * Gets pod list.
     *
     * @return the pod list
     */
//    PodList getPodList() {
//        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL, HttpMethod.GET, null, PodList.class);
//    }


    /**
     * Gets pod list.
     *
     * @param selector the selector
     * @return the pod list
     */
    PodList getPodList(String selector) {
        return restTemplateService.send(Constants.TARGET_CAAS_API, REQ_URL + "/" + selector, HttpMethod.GET, null, PodList.class);
    }

}
