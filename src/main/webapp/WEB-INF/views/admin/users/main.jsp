<%--
  Users main
  @author REX
  @version 1.0
  @since 2018.08.02
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                            <!--tfoot>
                                <tr>
                                    <td colspan="6">
                                        <button class="btns2 btns2_1 colors4 event_btns">더보기</button>
                                    </td>
                                </tr>
                            </tfoot-->
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<!-- modal -->
<%--<div class="modal fade in" id="layerpop1">
    <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
            <div class="modal-content">
                <!-- header -->
                <div class="modal-header">
                    <!-- 닫기(x) 버튼 -->
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <!-- header title -->
                    <h4 class="modal-title">Role 변경</h4>
                </div>
                <!-- body -->
                <div class="modal-body roleUpdate">
                   &lt;%&ndash; <p class="account_modal_p"><span>hong@test.com</span> 님을 <span>Administrator</span>로 Role을 변경하시겠습니까?
                    </p>&ndash;%&gt;
                </div>
                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btns2 colors4" data-dismiss="modal" id="roleUpdateBtn">변경</button>
                    <button type="button" class="btns2 colors5" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade in" id="layerpop2">
    <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
            <div class="modal-content">
                <!-- header -->
                <div class="modal-header">
                    <!-- 닫기(x) 버튼 -->
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <!-- header title -->
                    <h4 class="modal-title">Member 삭제</h4>
                </div>
                <!-- body -->
                <div class="modal-body">
                    <p class="account_modal_p"><span>user</span> 님을 삭제하시겠습니까?<br>
                        사용자를 삭제하면 복구할 수 없습니다.
                    </p>
                </div>
                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btns2 colors4" data-dismiss="modal" id="userDeleteBtn">삭제</button>
                    <button type="button" class="btns2 colors5" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>--%>

<script type="text/javascript">

    var BASE_URL = "/caas";
    var usersList;
    var roleSearchName;

    var userIdSelectRole;
    var userPerRole;

    var deleteUserId;

    // SESSION VARIABLE
    var rsUpdate = '<c:out value="${sessionScope.RS_USERMANAGEMENT_UPDATE}"/>';
    var rsDelete = '<c:out value="${sessionScope.RS_USERMANAGEMENT_DELETE}"/>';


    // SELECTED ROLE VALUE
    var changeRoleSearch = function () {
        roleSearchName = $(".user-filter option:checked").text();
        setUsersList(document.getElementById("table-search-01").value);
    };

    // GET LIST
    var getUsersList = function() {
        procCallAjax(BASE_URL + "/users/getList?serviceInstanceId=" + SERVICE_INSTANCE_ID + "&organizationGuid=" + ORGANIZATION_GUID, "GET", null, null, callbackGetUsersList);
    };


    // CALLBACK
    var callbackGetUsersList = function(data) {
        viewLoading('hide');
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        usersList = data;
        setUsersList("");
    };

    // SET LIST
    var setUsersList = function(searchKeyword) {
        var userId;

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        var items = new Array;

        for(var k = 0; k < usersList.length; k++){
            if(usersList[k].roleSetCode == "RS0001"){
                usersList[k].roleSetCode = "Administrator";
            }else if(usersList[k].roleSetCode == "RS0002"){
                usersList[k].roleSetCode = "Regular User";
            }else if(usersList[k].roleSetCode == "RS0003"){
                usersList[k].roleSetCode = "Init User";
            }


            var defaultSelectRole = $(".user-filter option:selected").val();

            if(defaultSelectRole == "Total" || roleSearchName == "Total"){
                items = usersList;
                break;
            }else if(roleSearchName == usersList[k].roleSetCode){
                items.push(usersList[k]);
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

        var roles = ['Administrator', 'Regular User', 'Init User'];

        for (var i = 0; i < listLength; i++) {
            var option = '';
            selectBox = '';
            userId = items[i].userId;

            if ((nvl(searchKeyword) === "") || userId.indexOf(searchKeyword) > -1) {

                // 1. caas_account_name : b8e85b00-04b4-4fa0-bd4f-5dac050cc3d9-hyunlee-admin
                caasAccountName = items[i].caasAccountName;

                // 2. 자를 단어 조합
                roleNameArr = userId.split('@');
                userName = roleNameArr[0].replace((/[_\W]+/g, "-")).toLowerCase();
                splitWord = (ORGANIZATION_GUID + "-" + userName).toLowerCase() + "-";

                // 3. role name 만 추출하자.
                roleArr = caasAccountName.split(splitWord);
                splitRole = roleArr[1];

                // 4. splitRole 이 admin 인 경우 select box 는 disabled
                if((splitRole == "admin")){
                    selectBox += "<select disabled name='role-filter' data-user-id='"+ items[i].userId +"'>"
                }else{
                    selectBox += "<select name='role-filter' data-user-id='"+ items[i].userId +"'>"
                }



                // role code 이름 변환
                if(items[i].roleSetCode == "RS0001"){
                    items[i].roleSetCode = "Administrator";
                }else if(items[i].roleSetCode == "RS0002"){
                    items[i].roleSetCode = "Regular User";
                }else if(items[i].roleSetCode == "RS0003"){
                    items[i].roleSetCode = "Init User";
                }

                var layerpop1 = '';
                var layerpop2 = '';

                if(splitRole == "admin"){
                    layerpop1 += "<span data-target='#layerpop1' data-toggle='modal' name='saveRole' style='display: none'><i class='fas fa-save'></i></span>";
                    layerpop2 += "<span data-target='#layerpop2' data-toggle='modal' name='deleteUser' style='display: none'><i class='fas fa-trash-alt'></i></span>";
                }else{
                    layerpop1 += "<span data-target='#layerpop1' data-toggle='modal' name='saveRole'><i class='fas fa-save'></i></span>";
                    layerpop2 += "<span data-target='#layerpop2' data-toggle='modal' name='deleteUser' ><i class='fas fa-trash-alt'></i></span>";
                }


                // 현재 세션이 admin 이 아닐 때
                if(rsUpdate !== "TRUE"){
                    layerpop1 = '';
                }
                if(rsDelete !== "TRUE"){
                    layerpop2 = '';
                }

                for (var r = 0; r < roles.length; r++) {
                    if (items[i].roleSetCode == roles[r]) {
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

    };

    // BIND (SERACH USER BUTTON)
    $("#userSearchBtn").on("click", function () {
        var keyword = $("#table-search-01").val();
        setUsersList(keyword);
    });


    // BIND (CHANGE ROLE SAVE BUTTON)
    $(document).on("click", "span[name=saveRole]", function(){
        var index = $('span[name=saveRole]').index(this);
        //alert(index);
        //alert($('select[name=role-filter]').eq(index).data("userId"));
        //alert($('select[name=role-filter]').eq(index).find(':selected').val());

        userIdSelectRole = $('select[name=role-filter]').eq(index).data("userId");
        userPerRole = $('select[name=role-filter]').eq(index).find(':selected').val();

        var code = "<p class='account_modal_p'><span>" + userIdSelectRole + "</span> 님을 <span>"+ userPerRole + "</span>로 Role 을 변경하시겠습니까?</p>";
        $(".roleUpdate").html(code);
    });


    // BIND (CLICK ROLE SAVE BUTTON)
    $(document).on("click", "#roleUpdateBtn", function () {
        //console.log("여기 들어오니잉???");
        updateRoleOfUser();
    });

    // SET UPDATE USER ROLE
    var updateRoleOfUser = function () {
        if(userPerRole == "Administrator"){
            userPerRole = "RS0001"
        }else if (userPerRole == "Regular User"){
            userPerRole = "RS0002"
        }else if(userPerRole == "Init User"){
            userPerRole = "RS0003"
        }

        var reqParam = {
            userId: userIdSelectRole,
            caasNamespace: NAME_SPACE,
            roleSetCode: userPerRole
        };

        postProcCallAjax(BASE_URL + "/users/updateUserRole?serviceInstanceId=" + SERVICE_INSTANCE_ID + "&organizationGuid=" + ORGANIZATION_GUID, reqParam, callbackUpdateRoleOfUser);
    };

    // CALLBACK USER ROLE
    var callbackUpdateRoleOfUser = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
//        alertMessage("권한이 수정되었습니다.", true);
//        setTimeout(reload, 2000);
        var code = "<p class='account_modal_p'>Role 이 변경되었습니다.</p>";
        $(".roleUpdateComplete").html(code);
        $("#layerpop-single-button1").modal("show");
    };


    // BIND (CLICK ROLE SAVE COMPLETE BUTTON)
    $(document).on("click", "#okBtnUpdate", function () {
        location.reload(true);
    });

    // BIND (DELETE USER MODAL)
    $(document).on("click", "span[name=deleteUser]", function () {
        console.log("user delete");
        var index = $('span[name=deleteUser]').index(this);

        deleteUserId = $("#resultArea").find(".userId").eq(index).text();

        //console.log("index 는 ", index);
        //console.log("id 는 ", deleteUserId);

        var code = "<p class='account_modal_p'><span>" + deleteUserId + "</span> 님을 삭제하시겠습니까?<br>사용자를 삭제하면 복구할 수 없습니다.</p>";
        $(".deleteUser").html(code);
    });


    // BIND (CLICK USER DELETE BUTTON)
    $(document).on("click", "#userDeleteBtn", function () {
        //console.log("여기 들어오니잉???");
        deleteUser(deleteUserId);
    });

    // SET DELETE USER
    var deleteUser = function (userId) {
        var reqParam = {
            userId: userId
        };
        postProcCallAjax(BASE_URL + "/users/deleteUser?serviceInstanceId=" + SERVICE_INSTANCE_ID + "&organizationGuid=" + ORGANIZATION_GUID, reqParam, callbackDeleteUser);
    };

    // CALLBACK DELETE USER
    var callbackDeleteUser = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
//        alertMessage("사용자가 삭제되었습니다.", true);
//        setTimeout(reload, 2000);
        var code = "<p class='account_modal_p'>사용자가 삭제되었습니다.</p>";
        $(".deleteUserComplete").html(code);
        $("#layerpop-single-button2").modal("show");
    };

    // BIND (CLICK USER DELETE COMPLETE BUTTON)
    $(document).on("click", "#okBtnDelete", function () {
        location.reload(true);
    });

    // page reload
    var reload = function () {
        location.reload(true);
    };

    // ON LOAD
    $(document.body).ready(function () {
        viewLoading('show');
        getUsersList();
    });

</script>
