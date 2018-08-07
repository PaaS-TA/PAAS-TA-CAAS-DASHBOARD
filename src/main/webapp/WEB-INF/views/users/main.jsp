<%--
  Users main
  @author REX
  @version 1.0
  @since 2018.08.02
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>

    <%--COMMON LIBRARY :: BEGIN--%>
    <%@include file="../common/commonLibs.jsp" %>
    <%--COMMON LIBRARY :: END--%>

</head>
<body>
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
                + "roleCode :: " + data[i].roleCode + " || "
                + "roleDescription :: " + data[i].roleDescription + " || "
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
        //
    });

</script>


</body>
</html>
