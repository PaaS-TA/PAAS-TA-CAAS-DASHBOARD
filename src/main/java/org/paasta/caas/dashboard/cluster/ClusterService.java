package org.paasta.caas.dashboard.cluster;

import org.paasta.caas.dashboard.config.EnvConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

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
public class ClusterService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ClusterService.class);

    @Autowired
    RestTemplate restTemplate;

    @Autowired
    private EnvConfig envConfig;

    /**
     * 네임스페이스 리스트 조회
     *
     * @return int int
     */
    public Map<String, Object> getNamespaceList(Map<String, Object> map) {
        Map result = new HashMap();

        HttpHeaders headers = new HttpHeaders();
        //headers.add("Authorization", "Bearer "+kubeAccountToken);
        //headers.add("Content-Type", "application/json");

        Map<String, Object> param = new HashMap<>();
        param.put("reqParam_sample_1", "1");
        param.put("reqParam_sample_2", "2");

        HttpEntity<Map> resetEntity = new HttpEntity(param, headers);
        ResponseEntity<Map> responseEntity = restTemplate.exchange(envConfig.getCaasApiUrl() + "/cluster/namespaces", HttpMethod.GET, resetEntity, Map.class);

        LOGGER.debug(responseEntity.getBody().toString());

        result.put("result", "success");
        result.put("data", responseEntity.getBody());
        result.put("statusCode", responseEntity.getStatusCodeValue());

        return result;
    }



}
