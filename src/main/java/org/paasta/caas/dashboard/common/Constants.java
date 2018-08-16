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

    // TODO :: REMOVE
    public static final String NAMESPACE_NAME = "kube-system";

    public static final String API_WORKLOAD = "/workload";



    private Constants() {
        throw new IllegalStateException();
    }
}
