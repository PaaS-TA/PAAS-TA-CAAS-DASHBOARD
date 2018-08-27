package org.paasta.caas.dashboard.common.model;

/**
 * kuber와 관련 api를 호출 할 때 필요한 admin token을 저장하기 위한 model
 * token_name은 "caas_admin"으로 고정, property로 빼는 것이 좋은 것은 알지만
 * 릴리즈 수정을 줄이기 위함.
 * @author Hyerin
 * @since 2018.08.22
 * @version 20180822
 */
public class AdminToken {

    private String token_name;
    private String token_value;

    public String getToken_name() {
        return token_name;
    }

    public void setToken_name(String token_name) {
        this.token_name = token_name;
    }

    public String getToken_value() {
        return token_value;
    }

    public void setToken_value(String token_value) {
        this.token_value = token_value;
    }
}
