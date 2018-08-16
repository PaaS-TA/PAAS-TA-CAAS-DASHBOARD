<%--
  Roles main

  author: hrjin
  version: 1.0
  since: 2018-08-16
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div style="padding: 10px;">
    ROLE 대시보드 :: ROLE DASHBOARD
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
</div>
<script type="text/javascript">

    // GET LIST
    var getRoleList = function() {
        procCallAjax("/cluster/roles/getList.do", "GET", null, null, callbackGetRoleList);
    };

    var callbackGetRoleList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        //console.log("델리스파이스", JSON.stringify(data));

        var items = data.items;
        var roleName;
        var namespace;
        var metadata;
        var listLength = items.length;
        var htmlString = [];

        htmlString.push("Role List :: <br><br>");

        for(var i = 0; i < listLength; i++){
            metadata = items[i].metadata;
            roleName = metadata.name;
            namespace = metadata.namespace;

            htmlString.push(
                "<a href='javascript:void(0);' onclick='procMovePage(\"/cluster/roles/" + roleName + "\");'>[ DETAIL ]</a>" + " || "
                + "name :: " + roleName + " || "
                + "namespace :: " + namespace + " || "
                + "creationTimestamp :: " + items[i].metadata.creationTimestamp
                + "<br><br>");
        }

        $('#resultArea').html(htmlString);
    };

    // BIND
    $("#btnSearch").on("click", function() {
        getRoleList();
    });


    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });

    // ON LOAD
    $(document.body).ready(function () {
        getRoleList();
    });
</script>