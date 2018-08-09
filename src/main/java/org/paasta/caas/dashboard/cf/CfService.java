package org.paasta.caas.dashboard.cf;

import org.paasta.caas.dashboard.common.RestTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by indra on 2018-08-08.
 */
@Service
public class CfService {

    private final RestTemplateService restTemplateService;


    @Autowired
    public CfService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

//    public Map<String, Object> getCfOrgsByUserId() {
//        Map resultMap = restTemplateService.cfSend();
//        return resultMap;
//    }
}
