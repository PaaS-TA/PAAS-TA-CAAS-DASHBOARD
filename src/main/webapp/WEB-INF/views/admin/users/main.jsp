<%--
  Users main
  @author REX
  @version 1.0
  @since 2018.08.02
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<div class="content">
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
        <ul>
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top user">
                        <p>Users</p>
                    </div>
                    <div class="view_table_wrap">
                        <div class="table-search-wrap">
                            <input type="text" id="table-search-01" name="" class="table-search user" placeholder="User ID" onkeypress="if(event.keyCode===13) {setUsersList(this.value);}" />
                            <button name="button" class="btn" id="userSearchBtn" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                            <select class="user-filter" onchange="changeRoleSearch()">
                                <option selected>Total</option>
                                <option value="Administrator">Administrator</option>
                                <option value="Regular User">Regular User</option>
                                <option value="Init User">Init User</option>
                            </select>
                        </div>
                        <table class="table_event condition alignL user">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:20%;'>
                                <col style='width:20%;'>
                                <col style='width:30%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultArea" style="display: none;"><td colspan='4'><p class='user_p'>사용자가 존재하지 않습니다.</p></td></tr>
                            <tr id="resultHeaderArea">
                                <td>User ID</td>
                                <td>생성일</td>
                                <td>수정일</td>
                                <td>Role</td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript">
    var G_USERS_LIST;
    var G_ROLE_SEARCH_NAME;

    var G_USER_ID_SELECT_ROLE;
    var G_USER_PER_ROLE;

    var G_DELETE_USER_ID;

    var G_ADMIN_CODE = '<c:out value="${roleSetCodeList.administratorCode}" />';
    var G_REGULAR_USER_CODE = '<c:out value="${roleSetCodeList.regularUserCode}" />';
    var G_INIT_USER_CODE = '<c:out value="${roleSetCodeList.initUserCode}" />';

    var G_ADMIN_NAME = '<c:out value="${roleSetNameList.administratorName}" />';
    var G_REGULAR_USER_NAME = '<c:out value="${roleSetNameList.regularUserName}" />';
    var G_INIT_USER_NAME = '<c:out value="${roleSetNameList.initUserName}" />';

    // SESSION VARIABLE
    var G_RS_UPDATE = '<c:out value="${sessionScope.RS_USER_MANAGEMENT_UPDATE}"/>';
    var G_RS_DELETE = '<c:out value="${sessionScope.RS_USER_MANAGEMENT_DELETE}"/>';


    // SELECTED ROLE VALUE
    var changeRoleSearch = function () {
        G_ROLE_SEARCH_NAME = $(".user-filter option:checked").text();
        setUsersList(document.getElementById("table-search-01").value);
    };

    // GET LIST
    var getUsersList = function() {
        procViewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_COMMON_API_USERS_LIST %>"
            .replace("{serviceInstanceId:.+}", SERVICE_INSTANCE_ID)
            .replace("{organizationGuid:.+}", ORGANIZATION_GUID);

        procCallAjax(reqUrl, "GET", null, null, callbackGetUsersList);
    };


    // CALLBACK
    var callbackGetUsersList = function(data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        G_USERS_LIST = data.items;

        procViewLoading('hide');
        setUsersList("");
    };

    // SET LIST
    var setUsersList = function(searchKeyword) {
        procViewLoading('show');
        var userId;

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        var items = [];

        for(var k = 0; k < G_USERS_LIST.length; k++){
            var rc = G_USERS_LIST[k].roleSetCode;

            if(rc === G_ADMIN_CODE){
                rc = G_ADMIN_NAME;
            }else if(rc === G_REGULAR_USER_CODE){
                rc = G_REGULAR_USER_NAME;
            }else{
                rc = G_INIT_USER_NAME;
            }


            var defaultSelectRole = $(".user-filter option:selected").val();

            if(defaultSelectRole === "Total" || G_ROLE_SEARCH_NAME === "Total"){
                items = G_USERS_LIST;
                break;
            }else if(G_ROLE_SEARCH_NAME === rc){
                items.push(G_USERS_LIST[k]);
            }
        }

        var listLength = items.length;

        var checkListCount = 0;
        var htmlString = [];

        // 첫번째로 들어온 사람 select box는 caas_account_name 뒤에 -admin/-user 로 판별
        var caasAccountName;
        var roleNameArr = [];
        var userName;
        var roleArr = [];
        var splitRole;
        var splitWord;
        var selectBox = '';

        var roles = [G_ADMIN_NAME, G_REGULAR_USER_NAME, G_INIT_USER_NAME];

        for (var i = 0; i < listLength; i++) {
            var option = '';
            selectBox = '';
            userId = items[i].userId;

            if ((nvl(searchKeyword) === "") || userId.indexOf(searchKeyword) > -1) {

                // 1. caas_account_name : b8e85b00-04b4-4fa0-bd4f-5dac050cc3d9-hyunlee-admin
                caasAccountName = items[i].caasAccountName;

                // 2. 자를 단어 조합
                roleNameArr = userId.split('@');
                userName = roleNameArr[0].replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '').toLowerCase();
                splitWord = (ORGANIZATION_GUID + "-" + userName).toLowerCase() + "-";

                // 3. role name 만 추출하자.
                roleArr = caasAccountName.split(splitWord);
                splitRole = roleArr[1];

                // 4. splitRole 이 admin 인 경우 select box 는 disabled
                // 1) 로그인된 본인이 admin 이거나, 로그인된 본인이 업데이트 권한 없는 user 인 경우
                // 2) 로그인된 본인이 user 이고, 업데이트 권한 있는 경우
                if((splitRole === "admin") || ((splitRole === "user") && (G_RS_UPDATE !== "TRUE"))){
                    selectBox += "<select disabled name='role-filter' data-user-id='"+ items[i].userId +"'>"
                }else if((splitRole === "user") && (G_RS_UPDATE === "TRUE")){
                    selectBox += "<select name='role-filter' data-user-id='"+ items[i].userId +"'>"
                }else{
                    selectBox += "<select name='role-filter' data-user-id='"+ items[i].userId +"'>"
                }


                var rc2 = items[i].roleSetCode;

                // role code 이름 변환
                if(rc2 === G_ADMIN_CODE){
                    rc2 = G_ADMIN_NAME;
                }else if(rc2 === G_REGULAR_USER_CODE){
                    rc2 = G_REGULAR_USER_NAME;
                }else{
                    rc2 = G_INIT_USER_NAME;
                }

                var layerpop1 = '';
                var layerpop2 = '';

                if(splitRole === "admin"){
                    layerpop1 += "<span class='usersSaveRole' style='display: none'><i class='fas fa-save'></i></span>";
                    layerpop2 += "<span class='usersDeleteUser' style='display: none'><i class='fas fa-trash-alt'></i></span>";
                }else{
                    layerpop1 += "<span class='usersSaveRole'><i class='fas fa-save'></i></span>";
                    layerpop2 += "<span class='usersDeleteUser' ><i class='fas fa-trash-alt'></i></span>";
                }


                // 현재 세션이 admin 이 아닐 때
                if(G_RS_UPDATE !== "TRUE"){
                    layerpop1 = '';
                }
                if(G_RS_DELETE !== "TRUE"){
                    layerpop2 = '';
                }

                for (var r = 0; r < roles.length; r++) {
                    if (rc2 === roles[r]) {
                        option += '<option value="' + roles[r] + '" selected>' + roles[r] + '</option>';
                    } else {
                        option += '<option value="' + roles[r] + '">' + roles[r] + '</option>';
                    }
                }

                htmlString.push(
                    "<tr>"
                    + "<td class='userId'>" + items[i].userId + "</td>"
                    + "<td>" + items[i].created + "</td>"
                    + "<td>" + items[i].lastModified + "</td>"
                    + "<td>" + selectBox + option + "</select>"
                    + layerpop1
                    + layerpop2
                    + "</td>"
                    + "</tr>");

                checkListCount++;
            }
        }

        if (listLength < 1 || checkListCount < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
        }

        procViewLoading('hide');
    };

    // BIND (SERACH USER BUTTON)
    $("#userSearchBtn").on("click", function () {
        var keyword = $("#table-search-01").val();
        setUsersList(keyword);
    });


    // BIND (CHANGE ROLE SAVE BUTTON)
    $(document).on("click", "span[class=usersSaveRole]", function(){
        var index = $('.usersSaveRole').index(this);
        var selectedRoleFilter = $('select[name=role-filter]');

        G_USER_ID_SELECT_ROLE = selectedRoleFilter.eq(index).data("userId");
        G_USER_PER_ROLE = selectedRoleFilter.eq(index).find(':selected').val();

        var code = "<p class='account_modal_p'><span>" + G_USER_ID_SELECT_ROLE + "</span> 님을 <span>"+ G_USER_PER_ROLE + "</span>로 Role 을 변경하시겠습니까?</p>";

        procSetLayerPopup('알림', code, '확인', '취소', 'x', 'updateRoleOfUser();', null, null);
    });


    // SET UPDATE USER ROLE
    var updateRoleOfUser = function () {
        $("#commonLayerPopup").modal("hide");

        if(G_USER_PER_ROLE === G_ADMIN_NAME){
            G_USER_PER_ROLE = G_ADMIN_CODE;
        }else if (G_USER_PER_ROLE === G_REGULAR_USER_NAME){
            G_USER_PER_ROLE = G_REGULAR_USER_CODE;
        }else{
            G_USER_PER_ROLE = G_INIT_USER_CODE;
        }

        var reqParam = {
            userId: G_USER_ID_SELECT_ROLE,
            caasNamespace: NAME_SPACE,
            roleSetCode: G_USER_PER_ROLE
        };

        var reqData = JSON.stringify(reqParam);

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_COMMON_API_USERS_DETAIL %>"
            .replace("{serviceInstanceId:.+}", SERVICE_INSTANCE_ID)
            .replace("{organizationGuid:.+}", ORGANIZATION_GUID)
            .replace("{userId:.+}", G_USER_ID_SELECT_ROLE);

        procCallAjax(reqUrl, "PUT", reqData, null, callbackUpdateRoleOfUser);
    };

    // CALLBACK USER ROLE
    var callbackUpdateRoleOfUser = function (data) {
        var resultString = 'Role 이 변경되었습니다.';

        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            resultString = 'Role 변경에 실패했습니다.';
        }
        procViewLoading('hide');
        procSetLayerPopup('알림', resultString, '확인', null, 'x', 'location.reload(true);', 'location.reload(true);', 'location.reload(true);');
    };


    // BIND (DELETE USER MODAL)
    $(document).on("click", "span[class=usersDeleteUser]", function(){
        var index = $('.usersDeleteUser').index(this);

        G_DELETE_USER_ID = $("#resultArea").find(".userId").eq(index).text();

        var code = "<p class='account_modal_p'><span>" + G_DELETE_USER_ID + "</span> 님을 삭제하시겠습니까?<br>사용자를 삭제하면 복구할 수 없습니다.</p>";

        procSetLayerPopup('알림', code, '확인', '취소', 'x', 'deleteUser("' + G_DELETE_USER_ID + '");', null, null);
    });


    // SET DELETE USER
    var deleteUser = function (userId) {
        $("#commonLayerPopup").modal("hide");

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_COMMON_API_USERS_DETAIL %>"
            .replace("{serviceInstanceId:.+}", SERVICE_INSTANCE_ID)
            .replace("{organizationGuid:.+}", ORGANIZATION_GUID)
            .replace("{userId:.+}", userId);

        procCallAjax(reqUrl, "DELETE", null, null, callbackDeleteUser);
    };

    // CALLBACK DELETE USER
    var callbackDeleteUser = function (data) {
        var resultString = '사용자가 삭제되었습니다.';

        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            resultString = '사용자 삭제에 실패했습니다.'
        }
        procViewLoading('hide');
        procSetLayerPopup('알림', resultString, '확인', null, 'x', 'location.reload(true);', 'location.reload(true);', 'location.reload(true);');
    };


    // ON LOAD
    $(document.body).ready(function () {
        getUsersList();
    });

</script>
