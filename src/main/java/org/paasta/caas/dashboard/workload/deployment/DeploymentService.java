package org.paasta.caas.dashboard.workload.deployment;

import org.apache.tomcat.util.bcel.Const;
import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Deployment 관련 Caas API 를 호출 하는 서비스이다.
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.14
 */
@Service
public class DeploymentService {
    private static final Logger LOGGER = LoggerFactory.getLogger( DeploymentService.class );

    private static final String REQ_BASE_URL = Constants.API_WORKLOAD;

    /* Deployment URL */
    public static final String TARGET_DEPLOYMENT_LIST =
        REQ_BASE_URL + "/deployments";
    public static final String TARGET_DEPLOYMENT_LIST_IN_NAMESPACE =
        REQ_BASE_URL + "/namespaces/{namespace}/deployments";
    public static final String TARGET_DEPLOYMENT_IN_NAMESPACE =
        REQ_BASE_URL + "/namespaces/{namespace}/deployments/{deploymentName}";

    private final RestTemplateService restTemplateService;

    @Autowired
    public DeploymentService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }


    /**
     * 모든 네임스페이스에 있는 deployment의 목록을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @return List of deployment (All namespaces)
     */
    public DeploymentList getDeploymentListByAllNamespaces ( ) {
        return restTemplateService.send(
            Constants.TARGET_CAAS_API, TARGET_DEPLOYMENT_LIST, HttpMethod.GET, null, DeploymentList.class);
    }

    /**
     * 지정한 네임스페이스에 있는 deployment의 목록을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace namespace
     * @return List of deployment (specific namespace)
     */
    public DeploymentList getDeploymentList ( String namespace ) {
        String urlWithNamespace = TARGET_DEPLOYMENT_LIST_IN_NAMESPACE.replace( "{namespace}", namespace );
        return restTemplateService.send(
            Constants.TARGET_CAAS_API, urlWithNamespace, HttpMethod.GET, null, DeploymentList.class);
    }

    /**
     * 지정한 네임스페이스에 있는 특정한 deployment의 상세 내역을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace request namespace
     * @param deploymentName request deployment's name
     * @return Deployment's detail content (specific namespace and deployment)
     */
    public Deployment getDeployment ( String namespace, String deploymentName ) {
        String urlWithDeploymentName =
            TARGET_DEPLOYMENT_IN_NAMESPACE.replace( "{namespace}", namespace )
            .replace( "{deploymentName}", deploymentName );

        return restTemplateService.send(
            Constants.TARGET_CAAS_API, urlWithDeploymentName, HttpMethod.GET, null, Deployment.class);
    }
}
