<%--
  Intro accessInfo
  @author REX
  @version 1.0
  @since 2018.09.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="content">
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
        <div class="sortable_wrap custom-sortable_wrap">
            <div class="sortable_top">
                <p>User Info</p>
            </div>
        </div>
        <div class="account_table access">
            <table>
                <colgroup>
                    <col style="width:100%;">
                </colgroup>
                <tbody>
                <tr>
                    <td>
                        <label for="access-user-name">User name *</label>
                        <input id="access-user-name" type="text" placeholder="User name" disabled>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="access-user-role">Role</label>
                        <input id="access-user-role" type="text" disabled>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="cluster_tabs clearfix"></div>
    <%--How to access :: BEGIN--%>
    <div class="cluster_content01 row two_line two_view paB40">
        <div class="sortable_wrap custom-sortable_wrap">
            <div class="sortable_top">
                <p>How to access</p>
            </div>
        </div>
        <div class="custom-access-wrap pd0">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title">
                    <p>1.
                        <a href='javascript:void(0);' onclick="window.open('https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl')">Kubectl 다운로드 및 설치</a>
                    </p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title">
                    <p>2. 환경 변수 설정</p>
                </div>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ export CAAS-SERVICE-CLUSTER-NAME="<span id="caasClusterName"></span>"</p>
                    <p>\$ export CAAS-SERVICE-CLUSTER-SERVER="<span id="caasClusterServer"></span>"</p>
                    <p>\$ export CAAS-SERVICE-USER-NAME="<span id="caasUserName"></span>"</p>
                    <p>\$ export CAAS-SERVICE-CONTEXT-NAME="<span id="caasContextName"></span>"</p>
                    <p>\$ export CAAS-SERVICE-NAMESPACE-NAME="<span id="caasNamespace"></span>"</p>
                    <p>\$ export CAAS-SERVICE-CREDENTIALS-TOKEN="<span id="caasCredentialsToken"></span>"</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title" style="float: left;">
                    <p>3. Cluster 등록</p>
                </div>
                <div class="custom-access-title-right" style="float: right;">
                    <button class="btns colors4" onclick="window.open('https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl')">Download certificate file</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config set-cluster \${CAAS-SERVICE-CLUSTER-NAME} --insecure-skip-tls-verify=true --server=\${CAAS-SERVICE-CLUSTER-SERVER} --certificate-authority=[DOWNLOADED FILE PATH]</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title" style="float: left;">
                    <p>4. Credential 등록</p>
                </div>
                <div class="custom-access-title-right" style="float: right;">
                    <button class="btns colors4" onclick="window.open('https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl')">Copy Token</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p >## 토큰을 응용 프로그램과 공유 할 때 주의 하십시오. 공용 코드 저장소에 사용자 토큰을 게시하지 마십시오.</p>
                    <p>\$ kubectl config set-credentials \${CAAS-SERVICE-USER-NAME} --token=\${CAAS-SERVICE-CREDENTIALS-TOKEN}</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>5. Context 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config set-context \${CAAS-SERVICE-CONTEXT-NAME} --user=\${CAAS-SERVICE-USER-NAME} --namespace=\${CAAS-SERVICE-NAMESPACE-NAME} --cluster=\${CAAS-SERVICE-CLUSTER-NAME}</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>6. Context 사용 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config use-context \${CAAS-SERVICE-CONTEXT-NAME}</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>7. Config 구성 확인</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config view</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap custom-paB40">
            <div class="custom-access-title">
                <p>8. Resource 확인</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl get all</p>
                </div>
            </div>
        </div>
    </div>
    <%--How to access :: END--%>
</div>

<script type="text/javascript">

    var BASE_URL = "/caas";
    var roleName;
    var userAccessToken;

    // GET User
    var getUser = function() {
        procCallAjax(BASE_URL + "/users/getUser?serviceInstanceId=" + SERVICE_INSTANCE_ID + "&organizationGuid=" + ORGANIZATION_GUID + "&userId=" + USER_ID, "GET", null, null, callbackGetUser);
    };

    // CALLBACK
    var callbackGetUser = function(data) {
        viewLoading('hide');
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        console.log("value", JSON.stringify(data));
        $("#access-user-token").val(data.caasAccountTokenName);

        if(data.roleSetCode == "RS0001"){
            roleName = "Administrator";
        }else if(data.roleSetCode == "RS0002"){
            roleName = "Regular User";
        }else if(data.roleSetCode == "RS0003"){
            roleName = "Init User";
        }

        $("#access-user-role").val(roleName);

        userAccessToken = data.caasAccountTokenName;
        getAccessToken();
    };


    // user 의 token 값 가져오기
    var getAccessToken = function () {
        procCallAjax(BASE_URL + "/accessInfo/namespace/" + NAME_SPACE + "/accessTokenName/" + userAccessToken, "GET", null, null, callbackGetAccessToken);
    };

    var callbackGetAccessToken = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        $("#access-user-token").val(data.userAccessToken);
    };


    // ON LOAD
    $(document.body).ready(function () {
        viewLoading('show');
        $("#access-user-name").val(USER_ID);

        // copy function
        $(".btn-copy").on("click", function(){
            var inA = $("#access-user-token").val();
            inA.replace("\"/g", "");
            $("#out_a").val(inA);
            $("#out_a").select();
            var successful = document.execCommand('copy');
            alert("복사되었습니다.");
        });

        getUser();

        // TODO :: MODIFY
        var clusterName = "kubernetes";
        var clusterServer = "https://115.68.47.174:6443";
        var userName = "ffbf70af-e3d4-4e11-99ad-b6ace1455b64-98";
        var contextName = "ffbf70af-e3d4-4e11-99ad-b6ace1455b64-98-context";
        var namespace = "paas-e0fca1ca-9b8c-421f-bfaf-a8f8959f9029-caas";
        var credentialsToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJwYWFzLTYyNzExMTg1LTQ5OGUtNGE2Yi1iYjk1LTViMTRkZmFlOGFhMi1jYWFzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IjhhN2Y3MTBjLWFlOGUtNDM4NS05NDdjLWQ0NmRlZDViYjhhYy1oeXVubGVlLXVzZXItdG9rZW4tbTZkdnYiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiOGE3ZjcxMGMtYWU4ZS00Mzg1LTk0N2MtZDQ2ZGVkNWJiOGFjLWh5dW5sZWUtdXNlciIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjViOGIyMGY0LWFiMjAtMTFlOC04OTE3LTAwNTA1NjkwMGI5ZiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpwYWFzLTYyNzExMTg1LTQ5OGUtNGE2Yi1iYjk1LTViMTRkZmFlOGFhMi1jYWFzOjhhN2Y3MTBjLWFlOGUtNDM4NS05NDdjLWQ0NmRlZDViYjhhYy1oeXVubGVlLXVzZXIifQ.EQbvwM7sSBPQya0Jciq_xEYg-SIrvi2ehBwbdaK9rH0Z1So0zL3rM9ig7ZuOVMqc_XkLUypphUL5NU0hDQt3OnXX-6tAJEwYtO02xeNynrxSUTSE1hFJJcZtVGFcF_FVCJI6-DTVhRxf1OcdekCYI8YBLVVsXGm59sBJ9OU5GSlsFVMTLm1hUmho1yP--0KpcE7MiRQOyShRriiPhkI_WC6yrGpmTrg1VkUVBLK848XjbVr8aG01meYuODzx47-EX-zL2W6spV7JPuSbVMUdz86-ercjpx59PP16-gOdPQkPbmeREB4nw5333GajDFxt8IA4NTx3nLCQVOBjeL5bYQ";

        $('#caasClusterName').html(clusterName);
        $('#caasClusterServer').html(clusterServer);
        $('#caasUserName').html(userName);
        $('#caasContextName').html(contextName);
        $('#caasNamespace').html(namespace);
        $('#caasCredentialsToken').html(credentialsToken);
    });
</script>