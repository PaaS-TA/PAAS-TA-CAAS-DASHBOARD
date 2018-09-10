package org.paasta.caas.dashboard.common;

/**
 * Constants 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
public class Constants {

    public static final String RESULT_STATUS_SUCCESS = "SUCCESS";
    public static final String RESULT_STATUS_FAIL = "FAIL";

    public static final String TARGET_COMMON_API = "commonApi";
    public static final String TARGET_CAAS_API = "caasApi";

    public static final String API_URL = "/api";
    public static final String CAAS_BASE_URL = "/caas";

    // TODO :: REMOVE AFTER TESTING
    public static final String NAMESPACE_NAME = "kube-system";

    public static final String API_WORKLOAD = "/workloads";

    // VIEW URL - Clusters
    public static final String URI_CLUSTER_NODES = "/caas/clusters/nodes";

    // VIEW URL - workloads
    public static final String URI_WORKLOAD_OVERVIEW = "/caas/workloads/overview";
    public static final String URI_WORKLOAD_DEPLOYMENTS = "/caas/workloads/deployments";
    public static final String URI_WORKLOAD_PODS = "/caas/workloads/pods";
    public static final String URI_WORKLOAD_REPLICASETS = "/caas/workloads/replicaSets";

    // VIEW URL - services
    public static final String URI_SERVICES = "/caas/services";

    // VIEW URL - intro
    public static final String URI_INTRO_OVERVIEW = "/caas/intro/overview";
    public static final String URI_INTRO_ACCESS_INFO = "/caas/intro/accessInfo";

    // API URI :: SERVICES
    public static final String URI_API_SERVICES_LIST = "/namespaces/{namespace:.+}/services";
    public static final String URI_API_SERVICES_DETAIL = "/namespaces/{namespace:.+}/services/{serviceName:.+}";
    public static final String URI_API_SERVICES_YAML = "/namespaces/{namespace:.+}/services/{serviceName:.+}/yaml";
    public static final String URI_API_SERVICES_RESOURCES = "/namespaces/{namespace:.+}/services/resource/{selector:.+}";

    // API URI :: ENDPOINTS
    public static final String URI_API_ENDPOINTS_DETAIL = "/namespaces/{namespace:.+}/endpoints/{serviceName:.+}";

    // API URI :: EVENTS
    public static final String URI_API_EVENTS_LIST = "/namespaces/{namespace:.+}/events/resource/{resourceName:.+}";

    // TODO :: MODIFY URI >> "/namespaces/{namespace:.+}/pods/service/{serviceName:.+}/{selector:.+}"
    // API URI :: PODS
    public static final String URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE = "/workloads/namespaces/{namespace:.+}/pods/service/{serviceName:.+}/{selector:.+}";

    private Constants() {
        throw new IllegalStateException();
    }

}
