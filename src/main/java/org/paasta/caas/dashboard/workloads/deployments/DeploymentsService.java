package org.paasta.caas.dashboard.workloads.deployments;

import org.paasta.caas.dashboard.common.Constants;
import org.paasta.caas.dashboard.common.RestTemplateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

/**
 * Deployments 관련 Caas API 를 호출 하는 서비스이다.
 *
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.14
 */
@Service
public class DeploymentsService {

    private final RestTemplateService restTemplateService;

    @Autowired
    public DeploymentsService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     * 지정한 네임스페이스에 있는 deployment의 목록을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace namespace
     * @return List of deployment (specific namespace)
     */
    public DeploymentsList getDeploymentsList (String namespace ) {

        String urlWithNamespace = Constants.URI_API_DEPLOYMENTS_LIST.replace( "{namespace:.+}", namespace );
        return restTemplateService.send( Constants.TARGET_CAAS_API, urlWithNamespace, HttpMethod.GET, null, DeploymentsList.class);
    }

    /**
     * 지정한 네임스페이스에 있는 특정한 deployment의 상세 내역을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace request namespace
     * @param deploymentName request deployment's name
     * @return Deployments's detail content (specific namespace and deployment)
     */
    public Deployments getDeployments (String namespace, String deploymentName ) {
        String urlWithDeploymentName = Constants.URI_API_DEPLOYMENTS_DETAIL.replace( "{namespace:.+}", namespace )
                                                                            .replace( "{deploymentName:.+}", deploymentName );
        return restTemplateService.send(Constants.TARGET_CAAS_API, urlWithDeploymentName, HttpMethod.GET, null, Deployments.class);
    }

    /**
     * get deployment by selector.
     *
     * @param namespace request namespace
     * @param selectors fitter selector
     * @return List of deployment (specific namespace)
     */
    public DeploymentsList getDeploymentsListLabelSelector(String namespace, String selectors) {
        String reqUrl = Constants.URI_API_DEPLOYMENTS_RESOURCES.replace("{namespace:.+}", namespace)
                                                                .replace("{selector:.+}", selectors);
        return restTemplateService.send(Constants.TARGET_CAAS_API, reqUrl, HttpMethod.GET, null, DeploymentsList.class);
    }
}
