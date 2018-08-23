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
    private static final String REQ_URL = "/{namespace}/workload/pods";

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Pod service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public PodService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Gets pod list using label selector.
     *
     * @param namespace
     * @param selector
     * @return
     */
    PodList getPodListBySelector ( String namespace, String selector ) {
        String reqUrl = REQ_URL.replace( "{namespace}", namespace) + "/?selector=" + selector;
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqUrl, HttpMethod.GET, null, PodList.class );
    }

    // TODO :: REMOVE
    /**
     * Gets pod list for all namespaces.
     *
     * @return the pod list
     */
    PodList getPodList () {
        return getPodList( "_all" );
    }

    /**
     * Get pod list in namespace
     * @param namespace
     * @return
     */
    PodList getPodList ( String namespace ) {
        String reqURL = REQ_URL.replace( "{namespace}", namespace );
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqURL, HttpMethod.GET, null, PodList.class );
    }

    PodList getPodListAllNamespacesByNode( String nodeName ) {
        String reqURL = REQ_URL.replace( "{namespace}", "_all" ) + "/nodes/" + nodeName;
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqURL, HttpMethod.GET, null, PodList.class );
    }

    /**
     * Get pod in namespace.
     * @param namespace
     * @param podName
     * @return
     */
    Pod getPod ( String namespace, String podName ) {
        // TODO :: remove "detail" path or add "selector" path.
        String reqURL = REQ_URL.replace( "{namespace}", namespace ) + "/" + podName;
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqURL, HttpMethod.GET, null, Pod.class );
    }
}
