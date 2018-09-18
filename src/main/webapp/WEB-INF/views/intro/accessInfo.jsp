<%--
  Intro accessInfo
  @author REX
  @version 1.0
  @since 2018.09.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="content">
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
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
                <div>
                    <p style="color: red;">※ 아래 명령어는 Linux 용 변수 설정 예제임을 참고 바랍니다.</p>
                </div>
                <div class="custom-access-contents">
                    <p>\$ export CAAS_SERVICE_CLUSTER_NAME="<span id="caasClusterName"></span>"</p>
                    <p>\$ export CAAS_SERVICE_CLUSTER_SERVER="<span id="caasClusterServer"></span>"</p>
                    <p>\$ export CAAS_SERVICE_USER_NAME="<span id="caasUserName"></span>"</p>
                    <p>\$ export CAAS_SERVICE_CONTEXT_NAME="<span id="caasContextName"></span>"</p>
                    <p>\$ export CAAS_SERVICE_NAMESPACE_NAME="<span id="caasNamespace"></span>"</p>
                    <p>\$ export CAAS_SERVICE_CREDENTIALS_TOKEN="<span id="caasCredentialsToken"></span>"</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title" style="float: left;">
                    <p>3. Cluster 등록</p>
                </div>
                <div class="custom-access-title-right" style="float: right;">
                    <button type="button" class="btns colors4" onclick="return downloadCrtToken();">Download certificate file</button>
                    <%--<a id="download" href="javascript:void(0);"><button id="btnTest" class="btns colors4">Download certificate file</button></a>--%>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config set-cluster \${CAAS_SERVICE_CLUSTER_NAME} --embed-certs=true --server=\${CAAS_SERVICE_CLUSTER_SERVER} --certificate-authority=[DOWNLOADED FILE PATH]</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title" style="float: left;">
                    <p>4. Credential 등록</p>
                </div>
                <div class="custom-access-title-right" style="float: right;">
                    <button class="btns colors4" id="btn-copy" data-clipboard-action="cut" data-clipboard-target="#out_a">Copy Token</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p >## 토큰을 응용 프로그램과 공유 할 때 주의 하십시오. 공용 코드 저장소에 사용자 토큰을 게시하지 마십시오.</p>
                    <p>\$ kubectl config set-credentials \${CAAS_SERVICE_USER_NAME} --token=\${CAAS_SERVICE_CREDENTIALS_TOKEN}</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>5. Context 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config set-context \${CAAS_SERVICE_CONTEXT_NAME} --user=\${CAAS_SERVICE_USER_NAME} --namespace=\${CAAS_SERVICE_NAMESPACE_NAME} --cluster=\${CAAS_SERVICE_CLUSTER_NAME}</p>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>6. Context 사용 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <p>\$ kubectl config use-context \${CAAS_SERVICE_CONTEXT_NAME}</p>
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
    var caCertToken;
    var userAccessToken;

    // kubectl access guide variable
    var guideClusterName;
    var guideClusterServer;
    var guideUserName;
    var guideContextName;
    var guideNamespace;


    // certification token download
    var downloadCrtToken = function () {
        var fileNameToSaveAs = "cluster-certificate.crt";
        var textToWrite = caCertToken;

        var ie = navigator.userAgent.match(/MSIE\s([\d.]+)/),
            ie11 = navigator.userAgent.match(/Trident\/7.0/) && navigator.userAgent.match(/rv:11/),
            ieEDGE = navigator.userAgent.match(/Edge/g),
            ieVer=(ie ? ie[1] : (ie11 ? 11 : (ieEDGE ? 12 : -1)));

        if (ie && ieVer<10) {
            console.log("No blobs on IE ver<10");
            return;
        }

        var textFileAsBlob = new Blob([textToWrite], {
            type: 'text/plain'
        });

        if (ieVer>-1) {
            window.navigator.msSaveBlob(textFileAsBlob, fileNameToSaveAs);

        } else {
            var downloadLink = document.createElement("a");
            downloadLink.download = fileNameToSaveAs;
            downloadLink.href = window.URL.createObjectURL(textFileAsBlob);
            downloadLink.onclick = function(e) { document.body.removeChild(e.target); };
            downloadLink.style.display = "none";
            document.body.appendChild(downloadLink);
            downloadLink.click();
        }
    };


    // GET User
    var getUser = function() {
        procCallAjax(BASE_URL + "/users/getUser?serviceInstanceId=" + SERVICE_INSTANCE_ID + "&organizationGuid=" + ORGANIZATION_GUID + "&userId=" + USER_ID, "GET", null, null, callbackGetUser);
    };

    // CALLBACK
    var callbackGetUser = function(data) {
        viewLoading('hide');
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        //$("#access-user-token").val(data.caasAccountTokenName);

        guideClusterName = data.caasClusterName;
        guideClusterServer = data.caasUrl;
        guideUserName = data.serviceInstanceId + "-" + data.id;
        guideContextName = guideUserName + "-context";
        guideNamespace = data.caasNamespace;

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
        //$("#access-user-token").val(data.userAccessToken);
        caCertToken = data.caCertToken;
        userAccessToken = data.userAccessToken;
    };


    // ON LOAD
    $(document.body).ready(function () {
        viewLoading('show');
        $("#access-user-name").val(USER_ID);

        // copy function
        $("#btn-copy").on("click", function(){
            var inA = userAccessToken;
            $("#out_a").val(inA);
            $("#out_a").select();
            var successful = document.execCommand('copy');
            alert("복사되었습니다.");
        });

        getUser();

        // kubectl access guide input logic
        var clusterName = guideClusterName;
        var clusterServer = guideClusterServer;
        var userName = guideUserName;
        var contextName = guideContextName;
        var namespace = guideNamespace;
        var credentialsToken = userAccessToken;

        $('#caasClusterName').html(clusterName);
        $('#caasClusterServer').html(clusterServer);
        $('#caasUserName').html(userName);
        $('#caasContextName').html(contextName);
        $('#caasNamespace').html(namespace);
        $('#caasCredentialsToken').html(credentialsToken);
    });
</script>