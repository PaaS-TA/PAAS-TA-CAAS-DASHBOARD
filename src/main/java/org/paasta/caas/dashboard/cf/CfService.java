package org.paasta.caas.dashboard.cf;

import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Cf Service 클래스.
 *
 * @author indra
 * @version 1.0
 * @since 2018.08.28
 */
@Service
public class CfService {

    private final RestTemplateService restTemplateService;

    @Value("${cf.api.url}")
    private String apiUrl;

    /**
     * Instantiates a new Cf service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public CfService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     * Organization 정보를 조회한다.
     *
     * @param uaaid the uaaid
     * @param token the token
     * @return the Map
     */
    public Map getCfOrgsByUaaId(String uaaid, String token) {
        Map resultMap = new HashMap();

        try {
            resultMap = restTemplateService.cfSend(token, apiUrl + "/v2/users/" + uaaid + "/organizations", HttpMethod.GET, null, Map.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultMap;
    }

    /**
     * Space Guid를 조회한다.
     *
     * @param serviceInstanceId the serviceInstance Id
     * @param token             the token
     * @return the Map
     */
    public Map getCfServiceInstancesById(String serviceInstanceId, String token) {
        Map resultMap = new HashMap();

        try {
            resultMap = restTemplateService.cfSend(token, apiUrl + "/v2/service_instances/" + serviceInstanceId, HttpMethod.GET, null, Map.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultMap;
    }

    /**
     * Organization Guid를 조회한다.
     *
     * @param space_guid the space guid
     * @param token      the token
     * @return the Map
     */
    public Map getCfServiceById(String space_guid, String token) {
        Map resultMap = new HashMap();

        try {
            resultMap = restTemplateService.cfSend(token, apiUrl + "/v2/spaces/" + space_guid, HttpMethod.GET, null, Map.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultMap;
    }

    /**
     * Organization Name을 조회한다.
     *
     * @param organization_guid the organization guid
     * @param token             the token
     * @return the Map
     */
    public Map getCfOrgById(String organization_guid, String token) {
        Map resultMap = new HashMap();

        try {
            resultMap = restTemplateService.cfSend(token, apiUrl + "/v2/organizations/" + organization_guid + "/summary", HttpMethod.GET, null, Map.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultMap;
    }
}
