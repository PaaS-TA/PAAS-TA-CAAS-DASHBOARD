package org.paasta.caas.dashboard.cf;

import org.paasta.caas.dashboard.common.CommonService;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by indra on 2018-08-08.
 */
@Service
public class CfService {

    private final CommonService commonService;
    private final RestTemplateService restTemplateService;

    @Value("${cf.api.url}")
    private String apiUrl;


    @Autowired
    public CfService(CommonService commonService, RestTemplateService restTemplateService) {
        this.commonService = commonService;
        this.restTemplateService = restTemplateService;
    }

    public Map<String, Object> getCfOrgsByUaaIdAndToken(String uaaid, String token) {
        Map resultMap = new HashMap();

        try {
            resultMap = restTemplateService.cfSend(token, apiUrl+"/v2/users/"+uaaid+"/organizations", HttpMethod.GET, null, Map.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultMap;
    }
}
