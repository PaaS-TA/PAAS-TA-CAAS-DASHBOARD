package org.paasta.caas.dashboard.workloads.pods;

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
public class PodsService {
    private static final String REQ_URL = "workloads/namespaces/{namespace}/pods";

    private final RestTemplateService restTemplateService;

    /**
     * Instantiates a new Pods service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public PodsService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}

    /**
     * Gets pod list using label selector.
     *
     * @param namespace
     * @param selector
     * @return
     */
    PodsList getPodListBySelector (String namespace, String selector ) {
        String reqUrl = REQ_URL.replace( "{namespace}", namespace) + "/resource/" + selector;
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqUrl, HttpMethod.GET, null, PodsList.class );
    }

    // TODO :: REMOVE
    /**
     * Gets pod list for all namespaces.
     *
     * @return the pod list
     */
    PodsList getPodList () {
        return getPodList( "_all" );
    }

    /**
     * Get pod list in namespace
     * @param namespace
     * @return
     */
    PodsList getPodList (String namespace ) {
        String reqURL = REQ_URL.replace( "{namespace}", namespace );
        System.out.println("집에 가고 싶다 " + reqURL);
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqURL, HttpMethod.GET, null, PodsList.class );
    }

    PodsList getPodListNamespaceByNode(String namespace, String nodeName ) {
        String reqURL = REQ_URL.replace( "{namespace}", namespace ) + "/node/" + nodeName;
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqURL, HttpMethod.GET, null, PodsList.class );
    }

    /**
     * Get pod in namespace.
     * @param namespace
     * @param podName
     * @return
     */
    Pods getPod (String namespace, String podName ) {
        // TODO :: remove "detail" path or add "selector" path.
        String reqURL = REQ_URL.replace( "{namespace}", namespace ) + "/" + podName;
        return restTemplateService.send( Constants.TARGET_CAAS_API, reqURL, HttpMethod.GET, null, Pods.class );
    }
}
