/*TODO :: REMOVE*/
//package org.paasta.caas.dashboard.accessInfo;
//
//import org.paasta.caas.dashboard.common.Constants;
//import org.paasta.caas.dashboard.common.RestTemplateService;
//import org.paasta.caas.dashboard.workloads.deployments.Deployments;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpMethod;
//import org.springframework.stereotype.Service;
//
///**
// * @author hrjin
// * @version 1.0
// * @since 2018-09-04
// */
//@Service
//public class AccessInfoService {
//    private final RestTemplateService restTemplateService;
//    public static final String TARGET_ACCESS_INFO_IN_NAMESPACE = "/accessInfo/namespaces/{namespace}/secrets/{accessTokenName}";
//
//    @Autowired
//    public AccessInfoService(RestTemplateService restTemplateService) {
//        this.restTemplateService = restTemplateService;
//    }
//
//    public AccessInfo getToken(String namespace, String accessTokenName){
//        String urlWithAccessTokenName = TARGET_ACCESS_INFO_IN_NAMESPACE.replace("{namespace}", namespace).replace("{accessTokenName}", accessTokenName);
//
//        return restTemplateService.send(Constants.TARGET_CAAS_API, urlWithAccessTokenName, HttpMethod.GET, null, AccessInfo.class);
//    }
//}
