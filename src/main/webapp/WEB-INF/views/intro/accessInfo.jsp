<%--
  Intro accessInfo
  @author REX
  @version 1.0
  @since 2018.09.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<div class="content">
    <jsp:include page="../common/contentsTab.jsp"/>
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
                    <p>※ For Linux</p>
                </div>
                <div class="custom-access-contents">
                    <div id="caasEnvironmentsForLinux">
                        <p>export CAAS_SERVICE_CLUSTER_NAME="<span class="caasClusterName"></span>"</p>
                        <p>export CAAS_SERVICE_CLUSTER_SERVER="<span class="caasClusterServer"></span>"</p>
                        <p>export CAAS_SERVICE_USER_NAME="<span class="caasUserName"></span>"</p>
                        <p>export CAAS_SERVICE_CONTEXT_NAME="<span class="caasContextName"></span>"</p>
                        <p>export CAAS_SERVICE_NAMESPACE_NAME="<span class="caasNamespace"></span>"</p>
                        <p class="custom-access-contents-overflow">export CAAS_SERVICE_CREDENTIALS_TOKEN="<span class="caasCredentialsToken"></span>"</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasEnvironmentsForLinux"></i>
                    </div>
                </div>
                <div class="maT10">
                    <p>※ For Windows</p>
                </div>
                <div class="custom-access-contents">
                    <div id="caasEnvironmentsForWindows">
                        <p>set CAAS_SERVICE_CLUSTER_NAME="<span class="caasClusterName"></span>"</p>
                        <p>set CAAS_SERVICE_CLUSTER_SERVER="<span class="caasClusterServer"></span>"</p>
                        <p>set CAAS_SERVICE_USER_NAME="<span class="caasUserName"></span>"</p>
                        <p>set CAAS_SERVICE_CONTEXT_NAME="<span class="caasContextName"></span>"</p>
                        <p>set CAAS_SERVICE_NAMESPACE_NAME="<span class="caasNamespace"></span>"</p>
                        <p class="custom-access-contents-overflow">set CAAS_SERVICE_CREDENTIALS_TOKEN="<span class="caasCredentialsToken"></span>"</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasEnvironmentsForWindows"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title fa-pull-left">
                    <p>3. Cluster 등록</p>
                </div>
                <div class="custom-access-title-right fa-pull-right">
                    <button type="button" class="btns colors4" onclick="return downloadCrtToken();">Download certificate file</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="custom-access-contents-wrap">
                <div>
                    <p>※ For Linux</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasClusterForLinux">
                        <p>kubectl config set-cluster \${CAAS_SERVICE_CLUSTER_NAME} --embed-certs=true --server=\${CAAS_SERVICE_CLUSTER_SERVER} --certificate-authority=[DOWNLOADED FILE PATH]</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasClusterForLinux"></i>
                    </div>
                </div>
                <div class="maT10">
                    <p>※ For Windows</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasClusterForWindows">
                        <p>kubectl config set-cluster %CAAS_SERVICE_CLUSTER_NAME% --embed-certs=true --server=%CAAS_SERVICE_CLUSTER_SERVER% --certificate-authority=[DOWNLOADED FILE PATH]</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasClusterForWindows"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title-wrap">
                <div class="custom-access-title">
                    <p>4. Credential 등록</p>
                </div>
            </div>
            <div class="custom-access-title-caution">
                <p style="color: red;"><i class="fas fa-info-circle"></i> 토큰을 응용 프로그램과 공유 할 때 주의 하십시오. 공용 코드 저장소에 사용자 토큰을 게시하지 마십시오.</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="maT10">
                    <p>※ For Linux</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasCredentialForLinux">
                        <p>kubectl config set-credentials \${CAAS_SERVICE_USER_NAME} --token=\${CAAS_SERVICE_CREDENTIALS_TOKEN}</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasCredentialForLinux"></i>
                    </div>
                </div>
                <div class="maT10">
                    <p>※ For Windows</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasCredentialForWindows">
                        <p>kubectl config set-credentials %CAAS_SERVICE_USER_NAME% --token=%CAAS_SERVICE_CREDENTIALS_TOKEN%</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasCredentialForWindows"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>5. Context 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div>
                    <p>※ For Linux</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasContextForLinux">
                        <p>kubectl config set-context \${CAAS_SERVICE_CONTEXT_NAME} --user=\${CAAS_SERVICE_USER_NAME} --namespace=\${CAAS_SERVICE_NAMESPACE_NAME} --cluster=\${CAAS_SERVICE_CLUSTER_NAME}</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasContextForLinux"></i>
                    </div>
                </div>
                <div class="maT10">
                    <p>※ For Windows</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasContextForWindows">
                        <p>kubectl config set-context %CAAS_SERVICE_CONTEXT_NAME% --user=%CAAS_SERVICE_USER_NAME% --namespace=%CAAS_SERVICE_NAMESPACE_NAME% --cluster=%CAAS_SERVICE_CLUSTER_NAME%</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasContextForWindows"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>6. Context 사용 설정</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div>
                    <p>※ For Linux</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasContextUseForLinux">
                        <p>kubectl config use-context \${CAAS_SERVICE_CONTEXT_NAME}</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasContextUseForLinux"></i>
                    </div>
                </div>
                <div class="maT10">
                    <p>※ For Windows</p>
                </div>
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasContextUseForWindows">
                        <p>kubectl config use-context %CAAS_SERVICE_CONTEXT_NAME%</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasContextUseForWindows"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap">
            <div class="custom-access-title">
                <p>7. Config 구성 확인</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasConfigCheck">
                        <p>kubectl config view</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasConfigCheck"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="custom-access-wrap custom-paB40">
            <div class="custom-access-title">
                <p>8. Resource 확인</p>
            </div>
            <div class="custom-access-contents-wrap">
                <div class="custom-access-contents">
                    <div class="fa-pull-left" id="caasResourceCheck">
                        <p>kubectl get all</p>
                    </div>
                    <div class="fa-pull-right">
                        <i class="fas fa-copy custom-access-copy-button" about="caasResourceCheck"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--How to access :: END--%>
</div>

<script type="text/javascript">
    var G_ROLE_NAME;
    var G_CA_CERT_TOKEN;
    var G_USER_ACCESS_TOKEN;

    // kubectl access guide variable
    var G_GUIDE_CLUSTER_NAME;
    var G_GUIDE_CLUSTER_SERVER;
    var G_GUIDE_USER_NAME;
    var G_GUIDE_CONTEXT_NAME;
    var G_GUIDE_NAMESPACE;


    // certification token download
    var downloadCrtToken = function () {
        var fileNameToSaveAs = "cluster-certificate.crt";
        var textToWrite = G_CA_CERT_TOKEN;

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
        procViewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_COMMON_API_USERS_DETAIL %>"
            .replace("{serviceInstanceId:.+}", SERVICE_INSTANCE_ID)
            .replace("{organizationGuid:.+}", ORGANIZATION_GUID)
            .replace("{userId:.+}", USER_ID);

        procCallAjax(reqUrl, "GET", null, null, callbackGetUser);
    };

    // CALLBACK
    var callbackGetUser = function(data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        G_GUIDE_CLUSTER_NAME = data.caasClusterName;
        G_GUIDE_CLUSTER_SERVER = data.caasUrl;
        G_GUIDE_USER_NAME = data.serviceInstanceId + "-" + data.id;
        G_GUIDE_CONTEXT_NAME = G_GUIDE_USER_NAME + "-context";
        G_GUIDE_NAMESPACE = data.caasNamespace;

        if(data.roleSetCode === '<c:out value="${roleSetCodeList.administratorCode}" />'){
            G_ROLE_NAME = '<c:out value="${roleSetNameList.administratorName}" />';
        }else if(data.roleSetCode === '<c:out value="${roleSetCodeList.regularUserCode}" />'){
            G_ROLE_NAME = '<c:out value="${roleSetNameList.regularUserName}" />';
        }else if(data.roleSetCode === '<c:out value="${roleSetCodeList.initUserCode}" />'){
            G_ROLE_NAME = '<c:out value="${roleSetNameList.initUserName}" />';
        }

        $("#access-user-name").val(USER_ID);
        $("#access-user-role").val(G_ROLE_NAME);

        G_USER_ACCESS_TOKEN = data.caasAccountTokenName;
        procViewLoading('hide');
        getAccessToken();
    };


    // user 의 token 값 가져오기
    var getAccessToken = function () {
        procViewLoading('show');
        var reqUrl = "<%= Constants.CAAS_BASE_URL %><%= Constants.URI_API_SECRETS_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{accessTokenName:.+}", G_USER_ACCESS_TOKEN);

        procCallAjax(reqUrl, "GET", null, null, callbackGetAccessToken);
    };

    var callbackGetAccessToken = function (data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        G_CA_CERT_TOKEN = data.caCertToken;
        G_USER_ACCESS_TOKEN = data.userAccessToken;

        // kubectl access guide input logic
        $('.caasClusterName').html(G_GUIDE_CLUSTER_NAME);
        $('.caasClusterServer').html(G_GUIDE_CLUSTER_SERVER);
        $('.caasUserName').html(G_GUIDE_USER_NAME);
        $('.caasContextName').html(G_GUIDE_CONTEXT_NAME);
        $('.caasNamespace').html(G_GUIDE_NAMESPACE);
        $('.caasCredentialsToken').html(G_USER_ACCESS_TOKEN);

        procViewLoading('hide');
    };


    // BIND
    $(".custom-access-copy-button").on("click", function () {
        var item = document.getElementById($(this).attr('about'));
        var reqValue = item.innerText || item.textContent;
        var resultString = (procSetExecuteCommandCopy(reqValue)) ? '스크립트를 복사했습니다.' : '스크립트 복사에 실패했습니다.';
        procSetLayerPopup('알림', resultString, '확인', null, 'x', null, null, null);
    });


    // ON LOAD
    $(document.body).ready(function () {
        getUser();

    });
</script>