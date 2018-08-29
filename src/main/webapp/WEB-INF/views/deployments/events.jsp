<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <c:out value="${deploymentsName}"/> </h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on">Details</li>
            <li name="tab02" class="cluster_tabs_right">Events</li>
            <li name="tab03" class="cluster_tabs_right yamlTab">YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Events 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style="width:auto;">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody id="eventsListTable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Events 끝 -->

</div>


<input type="hidden" id="requestDeploymentsName" name="requestDeploymentsName" value="<c:out value='${deploymentsName}' default='' />" />

<!-- SyntexHighlighter -->
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shCore.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushCpp.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushCSharp.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushPython.js"/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shCore.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shThemeDefault.css"/>">

<script type="text/javascript">
    SyntaxHighlighter.defaults['quick-code'] = false;
    SyntaxHighlighter.all();
</script>

<style>
    .syntaxhighlighter .gutter .line {
        border-right-color: #ddd !important;
    }
</style>
<!-- SyntexHighlighter -->

<script type="text/javascript">
    $(document.body).ready(function () {
        var URL = "/api/namespaces/" + NAME_SPACE + "/events/resource/" + document.getElementById('requestDeploymentsName').value;
        console.log("window.location.href ", window.location.href);
        procCallAjax(URL, "GET", null, null, callbackGetList);
    });

    var stringifyJSON = function (obj) {
        return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
    }

    // CALLBACK
    var callbackGetList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(
                "ResultStatus :: " + data.resultCode + " <br><br>"
                + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var htmlString = [];

        $.each(data.items, function (index, itemList) {

            var message = itemList.message;
            var source = itemList.source.component;
            var subObject = itemList.involvedObject.fieldPath;
            var count = itemList.count;
            var fristTimestamp = itemList.firstTimestamp;
            var lastTimestamp = itemList.lastTimestamp;

            // htmlString push
            htmlString.push("<tr>"
                                + "<td>" + message + "</td>"
                                + "<td>" + source + "</td>"
                                + "<td>" + nvl2(subObject, "-") + "</td>"
                                + "<td>" + count + "</td>"
                                + "<td>" + fristTimestamp + "</td>"
                                + "<td>" + lastTimestamp + "</td>"
                            + "</tr>");
        });

        //var $resultArea = $('#resultArea');
        $('#eventsListTable').html(htmlString);
    };
    // BIND
    $("#btnReset").on("click", function () {
        $('#resultArea').html("");
    });

    // ALREADY READY STATE
    $(document).ready(function () {
        $("#btnSearch").on("click", function (e) {
            getDeployments();
        });
    });
</script>
