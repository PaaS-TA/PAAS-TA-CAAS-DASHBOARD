<%--
  Access Info main
  @author REX
  @version 1.0
  @since 2018.08.23
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="content">
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
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
                        <label for="access-user-email">Email *</label>
                        <input id="access-user-email" type="email" value="hong.test.com" placeholder="Email">
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="access-user-token">Token</label>
                        <input id="access-user-token" type="password" placeholder="Token">
                        <button class="btn-copy" data-clipboard-action="cut" data-clipboard-target="#out_a">
                            <i class="fas fa-clipboard"></i>
                        </button>
                        <p>
                            Kubectl에서 생성한 토큰으로 액세스 사용할 수 있습니다.<br/>
                            토큰을 응용 프로그램과 공유 할 때 주의 하십시오. 공용 코드 저장소에 사용자 토큰을 게시하지 마십시오.
                        </p>
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