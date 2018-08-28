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
    public static final String API_NAMESPACES = "/namespaces/";

    // TODO :: After applying SSO, it will change to "/caas".
    public static final String CAAS_BASE_URL = "";

    // TODO :: REMOVE AFTER TESTING
    public static final String NAMESPACE_NAME = "kube-system";

    // TODO :: REMOVE AFTER CHECKING, UNUSED
    public static final String STRING_DATE_TYPE = "yyyy-MM-dd HH:mm:ss";
    public static final String STRING_TIME_ZONE_ID = "Asia/Seoul";

    // TODO :: REMOVE AFTER CHECKING
    public static final String API_WORKLOAD = "/workload";


    private Constants() {
        throw new IllegalStateException();
    }
}
