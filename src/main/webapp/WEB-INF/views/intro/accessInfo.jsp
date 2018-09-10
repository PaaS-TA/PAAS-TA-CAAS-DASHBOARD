<%--
  Intro accessInfo
  @author REX
  @version 1.0
  @since 2018.09.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="content">
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
                <div class="custom-access-title" style="float: left;">
                    <p>2. Cluster 등록</p>
                </div>
                <div class="custom-access-title-right" style="float: right;">
                    <button class="btns colors4" onclick="window.open('https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl')">Download certificate file</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config set-cluster {CLUSTER_NAME} --insecure-skip-tls-verify=true --server={CLUSTER_URI:PORT} --certificate-authority={CLUSTER CERTIFICATE FILE PATH}</p>
                    <p class="maT10">예시)</p>
                    <p>\$ kubectl config set-cluster kubernetes --insecure-skip-tls-verify=true --server=https://115.68.47.174:6443 --certificate-authority=[DOWNLOADED FILE PATH]</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title" style="float: left;">
                    <p>3. Credential 등록</p>
                </div>
                <div class="custom-access-title-right" style="float: right;">
                    <button class="btns colors4" onclick="window.open('https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl')">Copy Token</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <%--<div class="custom-access-title">--%>
                <%--<p>2. Credential 등록--%>
                    <%--<button class="btn-copy" data-clipboard-action="cut" data-clipboard-target="#out_a">--%>
                        <%--<i class="fas fa-clipboard"></i>--%>
                    <%--</button>--%>
                <%--</p>--%>
            <%--</div>--%>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config set-credentials {USER_NAME} --token={TOKEN}</p>
                    <p class="maT10">예시)</p>
                    <p >## 토큰을 응용 프로그램과 공유 할 때 주의 하십시오. 공용 코드 저장소에 사용자 토큰을 게시하지 마십시오.</p>
                    <p>\$ kubectl config set-credentials ffbf70af-e3d4-4e11-99ad-b6ace1455b64-98 --token=[PASTE COPIED TOKEN]</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>4. Context 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config set-context {CONTEXT_NAME} --user={USER_NAME} --namespace={NAMESPACE_NAME} --cluster={CLUSTER_NAME}</p>
                    <p class="maT10">예시)</p>
                    <p>\$ kubectl config set-context ffbf70af-e3d4-4e11-99ad-b6ace1455b64-98-context --user=ffbf70af-e3d4-4e11-99ad-b6ace1455b64-98 --namespace=paas-e0fca1ca-9b8c-421f-bfaf-a8f8959f9029-caas --cluster=kubernetes</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>5. Context 사용 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config use-context {CONTEXT_NAME}</p>
                    <p class="maT10">예시)</p>
                    <p>\$ kubectl config use-context ffbf70af-e3d4-4e11-99ad-b6ace1455b64-98-context</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>6. Config 구성 확인</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config view</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap custom-paB40">
            <div class="custom-access-title">
                <p>7. Resource 확인</p>
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
    });
</script>