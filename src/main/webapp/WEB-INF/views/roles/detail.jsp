<%--
  Role detail

  author: hrjin
  version: 1.0
  since: 2018-08-16
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div style="padding: 10px;">
    ROLE 상세조회 :: ROLE DETAIL
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
</div>
<input type="hidden" id="requestRoleName" name="requestRoleName" value="<c:out value='${roleName}' default='' />" />

<script type="text/javascript">
    var getRoleDetail = function () {
      procCallAjax("/cluster/roles/get.do","GET", {roleName : document.getElementById('requestRoleName').value}, null, callbackGetRoleDetail);
    };

    var callbackGetRoleDetail = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        //console.log("버즈", JSON.stringify(data.metadata));

        var metadata = data.metadata;
        var annotations = metadata.annotations;
        var htmlString = [];

        console.log(" ggg ", annotations);
        annotations = JSON.stringify(annotations).replace(/\\/g, '');
        console.log("버스커버스커", annotations);

        htmlString.push("ROLE DETAIL :: <br><br>");

        htmlString.push(
            "name :: " + metadata.name + "<br>"
            + "namespace :: " + metadata.namespace + "<br>"
            + "annotations :: " + annotations + "<br>"
            + "creationTimestamp :: " + metadata.creationTimestamp
            + "<br><br>");

        $('#resultArea').html(htmlString);
    };


    // BIND
    $("#btnSearch").on("click", function() {
        getRoleDetail();
    });


    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });

    $(document.body).ready(function () {
       getRoleDetail();
    });
</script>
