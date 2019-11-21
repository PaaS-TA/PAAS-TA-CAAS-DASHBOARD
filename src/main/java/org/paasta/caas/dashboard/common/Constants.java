package org.paasta.caas.dashboard.common;

/**
 * Constants 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
public class Constants {

    // COMMON
    public static final String RESULT_STATUS_SUCCESS = "SUCCESS";
    public static final String RESULT_STATUS_FAIL = "FAIL";

    public static final String TOKEN_KEY = "caas_admin";

    public static final String TARGET_CAAS_API = "caasApi";
    public static final String TARGET_COMMON_API = "commonApi";

    public static final String API_URL = "/api";
    public static final String CAAS_BASE_URL = "/caas";
    public static final String CAAS_INIT_URI = "/caas/intro/overview";

    public static final String URI_CLUSTER_NODES = "/caas/clusters/nodes";
    public static final String URI_CLUSTER_NAMESPACES = "/caas/clusters/namespaces";


    // DASHBOARD URI
    public static final String URI_INTRO_OVERVIEW = "/caas/intro/overview";
    public static final String URI_INTRO_ACCESS_INFO = "/caas/intro/accessInfo";
    public static final String URI_INTRO_PRIVATE_REGISTRY_INFO = "/caas/intro/privateRegistryInfo";

    public static final String URI_WORKLOAD_OVERVIEW = "/caas/workloads/overview";
    public static final String URI_WORKLOAD_DEPLOYMENTS = "/caas/workloads/deployments";
    public static final String URI_WORKLOAD_PODS = "/caas/workloads/pods";
    public static final String URI_WORKLOAD_REPLICA_SETS = "/caas/workloads/replicaSets";

    public static final String URI_SERVICES = "/caas/services";

    public static final String URI_STORAGES = "/caas/storages";

    public static final String URI_USERS = "/caas/users";

    public static final String URI_ROLES = "/caas/roles";


    // API URI
    public static final String URI_API_NAME_SPACES_DETAIL = "/namespaces/{namespace:.+}";
    public static final String URI_API_NAME_SPACES_RESOURCE_QUOTAS = "/namespaces/{namespace:.+}/resourceQuotas";

    public static final String URI_API_NODES_LIST = "/nodes/{nodeName:.+}";

    public static final String URI_API_DEPLOYMENTS_LIST = "/namespaces/{namespace:.+}/deployments";
    public static final String URI_API_DEPLOYMENTS_DETAIL = "/namespaces/{namespace:.+}/deployments/{deploymentName:.+}";
    public static final String URI_API_DEPLOYMENTS_YAML = "/namespaces/{namespace:.+}/deployments/{deploymentName:.+}/yaml";

    public static final String URI_API_PODS_LIST = "/namespaces/{namespace:.+}/pods";
    public static final String URI_API_PODS_DETAIL = "/namespaces/{namespace:.+}/pods/{podName:.+}";
    public static final String URI_API_PODS_YAML = "/namespaces/{namespace:.+}/pods/{podName:.+}/yaml";
    public static final String URI_API_PODS_LIST_BY_SELECTOR = "/namespaces/{namespace:.+}/pods/resources/{selector:.+}";
    public static final String URI_API_PODS_LIST_BY_NODE = "/namespaces/{namespace:.+}/pods/nodes/{nodeName:.+}";
    public static final String URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE = "/namespaces/{namespace:.+}/pods/service/{serviceName:.+}/{selector:.+}";

    public static final String URI_API_REPLICA_SETS_LIST = "/namespaces/{namespace:.+}/replicaSets";
    public static final String URI_API_REPLICA_SETS_DETAIL = "/namespaces/{namespace:.+}/replicaSets/{replicaSetName:.+}";
    public static final String URI_API_REPLICA_SETS_YAML = "/namespaces/{namespace:.+}/replicaSets/{replicaSetName:.+}/yaml";
    public static final String URI_API_REPLICA_SETS_RESOURCES = "/namespaces/{namespace:.+}/replicaSets/resources/{selector:.+}";

    public static final String URI_API_SERVICES_LIST = "/namespaces/{namespace:.+}/services";
    public static final String URI_API_SERVICES_DETAIL = "/namespaces/{namespace:.+}/services/{serviceName:.+}";
    public static final String URI_API_SERVICES_YAML = "/namespaces/{namespace:.+}/services/{serviceName:.+}/yaml";

    public static final String URI_API_ENDPOINTS_DETAIL = "/namespaces/{namespace:.+}/endpoints/{serviceName:.+}";

    public static final String URI_API_EVENTS_LIST = "/namespaces/{namespace:.+}/events/resources/{resourceUid:.+}";
    public static final String URI_API_NAMESPACE_EVENTS_LIST    = "/namespaces/{namespace:.+}/events";

    public static final String URI_API_ROLES_DETAIL = "/namespaces/{namespace:.+}/roles/{roleName:.+}";

    public static final String URI_API_ROLE_BINDINGS_DETAIL = "/namespaces/{namespace:.+}/roleBindings/{roleBindingName:.+}";

    public static final String URI_API_SERVICE_ACCOUNT_DETAIL = "/namespaces/{namespace:.+}/serviceAccounts/{caasAccountName:.+}";

    public static final String URI_API_SECRETS_DETAIL = "/namespaces/{namespace:.+}/secrets/{accessTokenName:.+}";

    public static final String URI_API_STORAGES_LIST = "/namespaces/{namespace:.+}/persistentVolumeClaims";
    public static final String URI_API_STORAGES_DETAIL = "/namespaces/{namespace:.+}/persistentVolumeClaims/{persistentVolumeClaimName:.+}";
    public static final String URI_API_STORAGES_YAML = "/namespaces/{namespace:.+}/persistentVolumeClaims/{persistentVolumeClaimName:.+}/yaml";


    // COMMON API URI
    public static final String URI_COMMON_API_USERS_LIST = "/users/serviceInstanceId/{serviceInstanceId:.+}/organizationGuid/{organizationGuid:.+}";
    public static final String URI_COMMON_API_USERS_DETAIL = "/users/serviceInstanceId/{serviceInstanceId:.+}/organizationGuid/{organizationGuid:.+}/userId/{userId:.+}/";
    public static final String URI_COMMON_API_USERS_VALID_EXIST_NAMESPACE = "/users/userId/{userId}/namespace/{namespace}";

    public static final String URI_COMMON_API_ROLES_LIST = "/roles/{roleSetCode:.+}";

    private Constants() {
        throw new IllegalStateException();
    }

}
