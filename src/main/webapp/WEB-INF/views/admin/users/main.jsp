<%--
  Users main
  @author REX
  @version 1.0
  @since 2018.08.02
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
                            <input type="text" id="table-search-01" name="" class="table-search user" placeholder="User ID" />
                            <button name="button" class="btn" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                            <select class="user-filter">
                                <option selected>Total</option>
                                <option>Administrator</option>
                                <option>Regular User</option>
                                <option>Init User</option>
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
                            <tr>
                                <td>User ID</td>
                                <td>생성일</td>
                                <td>수정일</td>
                                <td>Role</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>hong@test.com</td>
                                <td>2018-06-08</td>
                                <td>2018-08-08</td>
                                <td>
                                    <select>
                                        <option selected>Administrator</option>
                                        <option>Regular User</option>
                                        <option>Init User</option>
                                    </select>
                                    <span data-target="#layerpop1" data-toggle="modal"><i class="fas fa-save"></i></span>
                                    <span data-target="#layerpop2" data-toggle="modal"><i class="fas fa-trash-alt"></i></span>
                                </td>
                            </tr>
                            <tr>
                                <td>shim@test.com</td>
                                <td>2018-06-08</td>
                                <td>2018-08-08</td>
                                <td>
                                    <select>
                                        <option>Administrator</option>
                                        <option selected>Regular User</option>
                                        <option>Init User</option>
                                    </select>
                                    <span data-target="#layerpop1" data-toggle="modal"><i class="fas fa-save"></i></span>
                                    <span data-target="#layerpop2" data-toggle="modal"><i class="fas fa-trash-alt"></i></span>
                                </td>
                            </tr>
                            <tr>
                                <td>chang@test.com</td>
                                <td>2018-06-08</td>
                                <td>2018-08-08</td>
                                <td>
                                    <select>
                                        <option>Administrator</option>
                                        <option selected>Regular User</option>
                                        <option>Init User</option>
                                    </select>
                                    <span data-target="#layerpop1" data-toggle="modal"><i class="fas fa-save"></i></span>
                                    <span data-target="#layerpop2" data-toggle="modal"><i class="fas fa-trash-alt"></i></span>
                                </td>
                            </tr>
                            <tr>
                                <td>gogo@test.com</td>
                                <td>2018-06-08</td>
                                <td>2018-08-08</td>
                                <td>
                                    <select>
                                        <option>Administrator</option>
                                        <option>Regular User</option>
                                        <option selected>Init User</option>
                                    </select>
                                    <span data-target="#layerpop1" data-toggle="modal"><i class="fas fa-save"></i></span>
                                    <span data-target="#layerpop2" data-toggle="modal"><i class="fas fa-trash-alt"></i></span>
                                </td>
                            </tr>
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
<div class="footer">Copyright © 2018 PaaS-TA. All rights reserved</div>
</div>
</div>
<!-- modal -->
<div class="modal fade in" id="layerpop1">
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
                <div class="modal-body">
                    <p class="account_modal_p"><span>hong@test.com</span> 님을 <span>Administrator</span>로 Role을 변경하시겠습니까?
                    </p>
                </div>
                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btns2 colors4" data-dismiss="modal">변경</button>
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
                    <button type="button" class="btns2 colors4" data-dismiss="modal">삭제</button>
                    <button type="button" class="btns2 colors5" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>


<%--TODO :: REMOVE--%>
<div style="padding: 10px;">
    USERS 대시보드 :: USERS DASHBOARD
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 목록 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
</div>
<script type="text/javascript">

    // GET LIST
    var getList = function() {
        procCallAjax("/users/getList.do", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.length;
        var htmlString = [];
        htmlString.push("USERS LIST :: <br><br>");

        for (var i = 0; i < listLength; i++) {
            htmlString.push(
                "id :: " + data[i].id + " || "
                + "userId :: " + data[i].userId + " || "
                + "serviceInstanceId :: " + data[i].serviceInstanceId + " || "
                + "caasAccountAccessToken :: " + data[i].caasAccountAccessToken + " || "
                + "caasAccountName :: " + data[i].caasAccountName + " || "
                + "namespace :: " + data[i].namespace + " || "
                + "organizationGuid :: " + data[i].organizationGuid + " || "
                + "spaceGuid :: " + data[i].spaceGuid + " || "
                + "roleName :: " + data[i].roleName + " || "
                + "roleSetCode :: " + data[i].roleSetCode + " || "
                + "description :: " + data[i].description + " || "
                + "created :: " + data[i].created + " || "
                + "lastModified :: " + data[i].lastModified
                + "<br><br>");
        }

        $('#resultArea').html(htmlString);
    };


    // BIND
    $("#btnSearch").on("click", function() {
        getList();
    });


    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });


    // ON LOAD
    $(document.body).ready(function () {
        // getList();
    });

</script>
