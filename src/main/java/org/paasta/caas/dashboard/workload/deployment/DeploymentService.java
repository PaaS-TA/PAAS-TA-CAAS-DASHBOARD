package org.paasta.caas.dashboard.workload.deployment;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
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

    /**
     * 모든 네임스페이스에 있는 deployment의 목록을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @return List of deployment (All namespaces)
     */
    public Map<String, Object> getDeploymentListByAllNamespaces ( ) {
        // TODO
        final HashMap<String, Object> result = new HashMap<String, Object>();

        result.put( "type", "getDeploymentListByAllNamespaces" );
        result.put( "status", "OK" );

        return result;
    }

    /**
     * 지정한 네임스페이스에 있는 deployment의 목록을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace namespace
     * @return List of deployment (specific namespace)
     */
    public Map<String, Object> getDeploymentList ( String namespace ) {
        // TODO
        final HashMap<String, Object> result = new HashMap<String, Object>();

        result.put( "type", "getDeploymentList" );
        result.put( "status", "OK" );
        result.put( "namespaceName", namespace );

        return result;
    }

    /**
     * 지정한 네임스페이스에 있는 특정한 deployment의 상세 내역을 CaaS API에 호출하여 받은 결과값을 반환한다.
     *
     * @param namespace request namespace
     * @param deploymentName request deployment's name
     * @return Deployment's detail content (specific namespace and deployment)
     */
    public Map<String, Object> getDeployment ( String namespace, String deploymentName ) {
        // TODO
        final HashMap<String, Object> result = new HashMap<String, Object>();

        result.put( "type", "getDeployment" );
        result.put( "status", "OK" );
        result.put( "namespaceName", namespace );
        result.put( "deploymentName", deploymentName );

        return result;
    }
}
