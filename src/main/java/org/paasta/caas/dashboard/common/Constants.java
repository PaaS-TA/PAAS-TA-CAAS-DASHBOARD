package org.paasta.caas.dashboard.common;

/**
 * Constants 클래스
 *
 * @author REX
 * @version 1.0
 * @since 2018.08.02
 */
public class Constants {

    /**
     * The constant RESULT_STATUS_SUCCESS.
     */
    public static final String RESULT_STATUS_SUCCESS = "SUCCESS";
    /**
     * The constant RESULT_STATUS_FAIL.
     */
    public static final String RESULT_STATUS_FAIL = "FAIL";

    /**
     * The constant TARGET_COMMON_API.
     */
    public static final String TARGET_COMMON_API = "commonApi";
    /**
     * The constant TARGET_CAAS_API.
     */
    public static final String TARGET_CAAS_API = "caasApi";

    private Constants() {
        throw new IllegalStateException();
    }
}
