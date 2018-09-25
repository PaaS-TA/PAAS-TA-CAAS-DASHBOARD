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
    public static final String RESULT_STATUS_FAIL    = "FAIL";

    public static final String TARGET_CAAS_API      = "caasApi";
    public static final String TARGET_COMMON_API    = "commonApi";

    public static final String API_URL = "/api";
    public static final String CAAS_BASE_URL = "/caas";

    // FOR SSO
    public static final String CAAS_INIT_URI = "/caas/intro/overview";

    // TODO :: REMOVE UNUSED VARIABLES
    public static final String API_WORKLOAD = "/workloads";

    // VIEW URL - Clusters
    public static final String URI_CLUSTER_NODES        = "/caas/clusters/nodes";
    public static final String URI_CLUSTER_NAMESPACES   = "/caas/clusters/namespaces";

    // VIEW URL - workloads
    public static final String URI_WORKLOAD_OVERVIEW        = "/caas/workloads/overview";
    public static final String URI_WORKLOAD_DEPLOYMENTS     = "/caas/workloads/deployments";
    public static final String URI_WORKLOAD_PODS            = "/caas/workloads/pods";
    public static final String URI_WORKLOAD_REPLICA_SETS    = "/caas/workloads/replicaSets";

    // VIEW URL - services
    public static final String URI_SERVICES = "/caas/services";

    // VIEW URL - intro
    public static final String URI_INTRO_OVERVIEW = "/caas/intro/overview";
    public static final String URI_INTRO_ACCESS_INFO = "/caas/intro/accessInfo";

    // VIEW URL - users
    public static final String URI_USERS = "/caas/users";

    // TODO :: REMOVE DUPLICATED VARIABLES
    // URI_CONTROLLER_NAMESPACE >> URI_CLUSTER_NAMESPACES
    // CONTROLLER MAPPING URI
    public static final String URI_CONTROLLER_NAMESPACE      = "/caas/clusters/namespaces";

    // API URI :: NAME SPACES
    public static final String URI_API_NAME_SPACES_DETAIL           = "/namespaces/{namespace:.+}";
    public static final String URI_API_NAME_SPACES_RESOURCE_QUOTAS  = "/namespaces/{namespace:.+}/resourceQuotas";

    // API URI :: DEPLOYMENTS
    public static final String URI_API_DEPLOYMENTS_LIST         = "/namespaces/{namespace:.+}/deployments";
    public static final String URI_API_DEPLOYMENTS_DETAIL       = "/namespaces/{namespace:.+}/deployments/{deploymentsName:.+}";
    public static final String URI_API_DEPLOYMENTS_YAML        = "/namespaces/{namespace:.+}/deployments/{deploymentsName:.+}/yaml";
    public static final String URI_API_DEPLOYMENTS_RESOURCES    = "/namespaces/{namespace:.+}/deployments/resource/{selector:.+}";

    // API URI :: REPLICA SETS
    public static final String URI_API_REPLICA_SETS_LIST      = "/namespaces/{namespace:.+}/replicaSets";
    public static final String URI_API_REPLICA_SETS_DETAIL    = "/namespaces/{namespace:.+}/replicaSets/{replicaSetName:.+}";
    public static final String URI_API_REPLICA_SETS_YAML      = "/namespaces/{namespace:.+}/replicaSets/{replicaSetName:.+}/yaml";
    public static final String URI_API_REPLICA_SETS_RESOURCES = "/namespaces/{namespace:.+}/replicaSets/resource/{selector:.+}";

    // API URI :: SERVICES
    public static final String URI_API_SERVICES_LIST         = "/namespaces/{namespace:.+}/services";
    public static final String URI_API_SERVICES_DETAIL       = "/namespaces/{namespace:.+}/services/{serviceName:.+}";
    public static final String URI_API_SERVICES_YAML         = "/namespaces/{namespace:.+}/services/{serviceName:.+}/yaml";
    public static final String URI_API_SERVICES_RESOURCES    = "/namespaces/{namespace:.+}/services/resource/{selector:.+}";

    // API URI :: ENDPOINTS
    public static final String URI_API_ENDPOINTS_DETAIL = "/namespaces/{namespace:.+}/endpoints/{serviceName:.+}";

    // API URI :: EVENTS
    public static final String URI_API_EVENTS_LIST         = "/namespaces/{namespace:.+}/events/resource/{resourceName:.+}";

    // API URI :: PODS
    public static final String URI_API_PODS_LIST                          = "/namespaces/{namespace:.+}/pods";
    public static final String URI_API_PODS_DETAIL                        = "/namespaces/{namespace:.+}/pods/{podName:.+}";
    public static final String URI_API_PODS_YAML                          = "/namespaces/{namespace:.+}/pods/{podName:.+}/yaml";
    public static final String URI_API_PODS_LIST_BY_SELECTOR              = "/namespaces/{namespace:.+}/pods/resource/{selector:.+}";
    public static final String URI_API_PODS_LIST_BY_NODE                  = "/namespaces/{namespace:.+}/pods/node/{nodeName:.+}";
    public static final String URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE = "/namespaces/{namespace:.+}/pods/service/{serviceName:.+}/{selector:.+}";

    // API URI :: NODES
    public static final String URI_API_NODES_LIST = "/nodes/{nodeName:.+}";

    // API URI :: ROLES
    public static final String URI_API_ROLES_DETAIL = "/namespaces/{namespace:.+}/roles/{roleName:.+}";

    // API URI :: ROLE BINDINGS
    public static final String URI_API_ROLE_BINDINGS_DETAIL = "/namespaces/{namespace:.+}/roleBindings/{roleBindingName:.+}";

    // API URI :: USERS(SERVICE ACCOUNT)
    public static final String URI_API_SERVICE_ACCOUNT_DETAIL = "/namespaces/{namespace:.+}/serviceAccounts/{caasAccountName:.+}";

    // API URI :: SECRETS
    public static final String URI_API_SECRETS_DETAIL = "/namespaces/{namespace:.+}/secrets/{accessTokenName:.+}";

    // COMMON API URI :: USERS
    public static final String URI_COMMON_API_USERS_LIST = "/users/serviceInstanceId/{serviceInstanceId:.+}/organizationGuid/{organizationGuid:.+}";
    public static final String URI_COMMON_API_USERS_DETAIL = "/users/serviceInstanceId/{serviceInstanceId:.+}/organizationGuid/{organizationGuid:.+}/userId/{userId:.+}";

    private Constants() {
        throw new IllegalStateException();
    }

}
