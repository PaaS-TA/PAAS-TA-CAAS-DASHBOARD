<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="cluster_content02 row two_line two_view harf_view" style="display: block;">
    <ul class="maT30">
        <li>
            <div class="sortable_wrap">
                <div class="sortable_top">
                    <p>Deployments</p>
                </div>
                <div class="view_table_wrap">
                    <table class="table_event condition alignL">
                        <colgroup>
                            <col style="width:auto;">
                            <col style="width:20%;">
                            <col style="width:15%;">
                            <col style="width:5%;">
                            <col style="width:15%;">
                            <col style="width:25%;">
                        </colgroup>
                        <thead>
                        <tr>
                            <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                            <td>Namespace</td>
                            <td>Labels</td>
                            <td>Pods</td>
                            <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                            <td>Images</td>
                        </tr>
                        </thead>
                        <tbody id="deploymentsListTable">
                        </tbody>
                    </table>
                </div>
            </div>
        </li>
    </ul>
</div>
<!-- modal -->
<div class="modal fade dashboard" id="layerpop">
    <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
        </div>
    </div>
</div>

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

<script type="text/javascript">
    $(document.body).ready(function () {
        procCallAjax("/workloads/deployments/" + NAME_SPACE +"/getList.do", "GET", null, null, callbackGetList);
    });

    var stringifyJSON = function (obj) {
        return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
    }

    // CALLBACK
    var callbackGetList = function (data) {
        console.log("여기 오느뇨?");
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(
                "ResultStatus :: " + data.resultCode + " <br><br>"
                + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);
        var $resultArea = $('#deploymentsListTable');

        var htmlString = [];
        htmlString.push("DEPLOYMENTS LIST :: <br><br>");
        htmlString.push("ResultCode :: " + data.resultCode + " || "
            + "Message :: " + data.resultMessage + " <br><br>");

        //
        $.each(data.items, function (index, itemList) {
            // get data
            var _metadata = itemList.metadata;
            var _spec = itemList.spec;
            var _status = itemList.status;

            var deployName = _metadata.name;
            var namespace = _metadata.namespace;
            var labels = stringifyJSON(_metadata.labels).replace(/,/g, ', ');
            if (labels == null || labels == "null") {
                labels = "None"
            }

            var creationTimestamp = _metadata.creationTimestamp;

            // Set replicas and total Pods are same.
            var totalPods = _spec.replicas;
            var runningPods = totalPods - _status.unavailableReplicas;
            // var failPods = _status.unavailableReplicas;
            var images = _spec.images;
            console.log("야야야 ", _status);
            $resultArea.append('<tr>' +
                                    '<td>' +
                                        "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/workloads/deployments/" + deployName + "\");'>"+
                                           '<span class="green2"><i class="fas fa-check-circle"></i></span>' + deployName +
                                        '</a>' +
                                    '</td>' +
                                    '<td>' + namespace + '</td>' +
                                    '<td>' + createSpans(labels, "true") + '</td>' +
                                    '<td>' + runningPods +" / " + totalPods + '</td>' +
                                    '<td>' + creationTimestamp + '</td>' +
                                    '<td>' + images + '</td>' +
                                '</td>');
        });

    };

    var replaceLabels = function (data) {
        return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D');
    }

    var processIfDataIsNull = function (data, procCallback, defaultValue) {
        if (data == null)
            return defaultValue;
        else {
            if (procCallback == null)
                return defaultValue;
            else
                return procCallback(data);
        }
    }

    var createSpans = function (data, type) {
        var datas = data.replace(/=/g, ':').split(',');
        var spanTemplate = "";
        console.log("타입이 뭐임?", type)

        if (type === "true") {
            $.each(datas, function (index, data) {
                spanTemplate += '<span class="bg_gray">' + data + '</span>';
                console.log('인덱스? ', index);
                if (datas.length > 1) {
                    console.log('여기 몇번옴??', index);
                    spanTemplate += '<br>';
                }
            });
        } else {
            $.each(datas, function (index, data) {
                spanTemplate += '<span class="bg_gray">' + data + '</span> ';
            });
        }

        return spanTemplate;
    }

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

    // ON LOAD
    $(document.body).ready(function () {
        // getAllDeployments();
    });
</script>
