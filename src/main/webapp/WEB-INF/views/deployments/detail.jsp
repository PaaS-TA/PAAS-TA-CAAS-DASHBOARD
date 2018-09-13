<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>

<div class="content">
    <h1 class="view-title"><span class="fa fa-file-alt" style="color:#2a6575;"></span> <c:out value="${deploymentsName}"/></h1>
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_second_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Details</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td id="name"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td id="namespaceID"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td id="labels"></td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="annotations">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="creationTime"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Selector</th>
                                <td id="selector"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Strategy</th>
                                <td id="strategy"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Min ready seconds</th>
                                <td id="minReadySeconds"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Revision history limit</th>
                                <td id="revisionHistoryLimit"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Rolling update strategy</th>
                                <td id="rollingUpdateStrategy"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td id="status"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Replica Set 시작 -->
            <li class="cluster_third_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Replica Set</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL" id="replicasetsResultTable">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noReplicasetsResultArea" style="display: none;"><td colspan='6'><p class='service_p'>조회 된 ReplicaSets가 없습니다.</p></td></tr>
                            <tr id="replicasetsResultHeaderArea" class="headerSortFalse">
                                <td>Name
                                    <button class="sort-arrow" onclick="procSetSortList('replicasetsResultTable', this, '0')"><i class="fas fa-caret-down"></i></button>
                                </td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td id="replicaPods">Pods</td>
                                <td id="replicaImages">Images</td>
                                <td id="replicaCreationTime">Created on
                                    <button class="sort-arrow" onclick="procSetSortList('replicasetsResultTable', this, '6')"><i class="fas fa-caret-down"></i></button>
                                </td>
                            </tr>
                            </thead>
                            <tbody id="replicaSetTable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Pods 시작 -->
            <li class="cluster_sixth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL" id="podsResultTable">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:15%;'>
                                <col style='width:15%;'>
                                <col style='width:8%;'>
                                <col style='width:8%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noPodsResultArea" style="display: none;"><td colspan='6'><p class='service_p'>조회 된 Pods가 없습니다.</p></td></tr>
                            <tr id="podsResultHeaderArea" class="headerSortFalse">
                                <td>Name
                                    <button class="sort-arrow" onclick="procSetSortList('podsResultTable', this, '0')"><i class="fas fa-caret-down"></i></button>
                                </td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on
                                    <button class="sort-arrow" onclick="procSetSortList('podsResultTable', this, '5')"><i class="fas fa-caret-down"></i></button>
                                </td>
                            </tr>
                            </thead>
                            <tbody id="podsListTable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Pods 끝 -->
        </ul>
    </div>
    <!-- Details  끝 -->
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
    // ON LOAD
    $(document.body).ready(function () {
/*        createChart("current", "cpu");
        createChart("current", "mem");
        createChart("current", "disk");*/
    });
</script>

<script type="text/javascript">
    var deployName = '<c:out value="${deploymentsName}"/>';
    $(document.body).ready(function () {
        viewLoading('show');
        getDetail();
    });

    var getDetail = function() {
        var reqUrl = "<%= Constants.URI_API_DEPLOYMENTS_DETAIL %>".replace("{namespace:.+}", NAME_SPACE)
                                                                    .replace("{deploymentName:.+}", deployName);

        procCallAjax(reqUrl, "GET", null, null, callbackGetDeployment);
    };

    var stringifyJSON = function (obj) {
        return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
    }

    var callbackGetDeployment = function (data) {
        viewLoading('hide');
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(
                "ResultStatus :: " + data.resultCode + " <br><br>"
                + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var htmlString = [];
        htmlString.push("DEPLOYMENTS LIST :: <br><br>");
        htmlString.push("ResultCode :: " + data.resultCode + " || "
            + "Message :: " + data.resultMessage + " <br><br>");

        // get data
        var metadata = data.metadata;
        var spec = data.spec;
        var status = data.status;

        /* Deployment detail is under...
         * - name
         * - namespace
         * - labels
         * - annotations
         * - creation time
         * - selector
         * - strategy (Pod deploy strategy)
         * - min ready seconds
         * - revision history limit
         * - Rolling update strategy detail (maxSurge, maxUnavailable)
         * - Replica status (updated, total, available, unavailable)
         */
        var deployName = metadata.name;
        var namespace = NAME_SPACE;
        var labels = stringifyJSON(metadata.labels).replace(/,/g, ', ');  //.replace(/=/g, ':')
        var annotations = metadata.annotations;
        var creationTimestamp = metadata.creationTimestamp;

        var selector = stringifyJSON(spec.selector).replace(/matchLabels=/g, '');;
        var strategy = spec.strategy.type;
        var minReadySeconds = spec.minReadySeconds;
        var revisionHistoryLimit = spec.revisionHistoryLimit;
        var rollingUpdateStrategy =
            "Max surge: " + spec.strategy.rollingUpdate.maxSurge + ", "
            + "Max unavailable: " + spec.strategy.rollingUpdate.maxUnavailable;

        var updatedReplicas = status.updatedReplicas;
        var totalReplicas = status.replicas;
        var availableReplicas = status.availableReplicas;
        var unavailableReplicas = status.unavailableReplicas;
        var replicaStatus = updatedReplicas + " updated, "
            + totalReplicas + " total, "
            + availableReplicas + " available, "
            + unavailableReplicas + " unavailable";

        document.getElementById("name").textContent = deployName;
        document.getElementById("namespaceID").innerHTML = "<td><a href='javascript:void(0);' data-toggle='tooltip' title='"+namespace+"' onclick='procMovePage(\"<%= Constants.URI_CONTROLLER_NAMESPACE %>/" + namespace + "\");'>" + namespace + "</td>";
        document.getElementById("labels").innerHTML = createSpans(labels, "false");
        document.getElementById("annotations").innerHTML = createAnnotations(annotations);
        document.getElementById("creationTime").textContent = creationTimestamp;
        document.getElementById("selector").innerHTML = createSpans(selector, "false");
        document.getElementById("strategy").textContent = strategy;
        document.getElementById("minReadySeconds").textContent = minReadySeconds;
        document.getElementById("revisionHistoryLimit").textContent = revisionHistoryLimit;
        document.getElementById("rollingUpdateStrategy").textContent = rollingUpdateStrategy;
        document.getElementById("status").textContent = replicaStatus;

        procCallAjax("/api/namespaces/" + NAME_SPACE + "/replicasets/resource/" + replaceLabels(selector), "GET", null, null, callbackGetReplicasetList);
        procCallAjax("/api/workloads/namespaces/" + NAME_SPACE + "/pods/resource/" + replaceLabels(selector), "GET", null, null, callbackGetPodsList);
    }


    var replaceLabels = function (data) {
        return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D');
    }

    var createSpans = function (data, type) {
        if( !data || data == "null") {
            return "-";
        }
        var datas = data.replace(/=/g, ':').split(',');
        var spanTemplate = "";

        if (type === "true") {
            $.each(datas, function (index, data) {
                spanTemplate += '<span class="bg_gray">' + data + '</span>';
                if (datas.length > 1) {
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


    // CALLBACK
    var callbackGetReplicasetList = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var resultArea = $('#replicaSetTable');
        var resultHeaderArea = $('#replicasetsResultHeaderArea');
        var noResultArea = $('#noReplicasetsResultArea');
        var resultTable = $('#replicasetsResultTable');

        var listLength = data.items.length;

        //-- Replica Set List
        //items
        //metadata.name
        //metadata.namespace
        //metadata.labels
        //status.replicas
        //metadata.creationTimestamp
        //spec.containers.image

        $.each(data.items, function (index, itemList) {

            var replicasetName = itemList.metadata.name;
            var namespace = NAME_SPACE;
            var labels = JSON.stringify(itemList.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
            var creationTimestamp = itemList.metadata.creationTimestamp;
            var replicas = itemList.status.replicas;   //  TOBE ::  current / desired
            var availableReplicas;
            if ( !itemList.status.availableReplicas ) {
                availableReplicas = 0;
            } else {
                availableReplicas = itemList.status.availableReplicas;
            }

            var images = new Array;

            var containers = itemList.spec.template.spec.containers;
            for (var i = 0; i < containers.length; i++) {
                images.push(containers[i].image);
            }

            resultArea.append('<tr>' +
                                    '<td>' +
                                        "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/workloads/replicaSets/" + replicasetName + "\");'>"+
                                            '<span class="green2"><i class="fas fa-check-circle"></i></span> ' + replicasetName +
                                        '</a>' +
                                    '</td>' +
                                    "<td><a href='javascript:void(0);' data-toggle='tooltip' title='"+namespace+"' onclick='procMovePage(\"<%= Constants.URI_CONTROLLER_NAMESPACE %>/" + namespace + "\");'>" + namespace + "</td>" +
                                    '<td>' + createSpans(labels, "true") + '</td>' +
                                    '<td>' + availableReplicas + " / " + replicas + '</td>' +
                                    "<td data-toggle='tooltip' title='" + images.join('</br>') + "'>" + images.join("</br>") + "</td>" +
                                    '<td>' + creationTimestamp + '</td>' +
                                '</tr>' );

        });

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultTable.tablesorter();
            resultTable.trigger("update");
            $('.headerSortFalse > td').unbind();
        }

    };


    var callbackGetPodsList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#podsListTable').html(
                "ResultStatus :: " + data.resultCode + " <br><br>"
                + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var resultArea = $('#podsListTable');
        var resultHeaderArea = $('#podsResultHeaderArea');
        var noResultArea = $('#noPodsResultArea');
        var resultTable = $('#podsResultTable');
        var listLength = data.items.length;
        var podNameList = [];

        $.each(data.items, function (index, itemList) {
            // get data
            var metadata = itemList.metadata;
            var spec = itemList.spec;
            var status = itemList.status;

            var podName = metadata.name;
            var namespace = NAME_SPACE;
            var nodeName = spec.nodeName;
            var nodeLink = "";
            if(spec.nodeName == null) {
                nodeLink += "-";
            }

            if(spec.nodeName != null) {
                nodeLink += "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/nodes/" + nodeName + "/summary\");'>"+
                                nodeName +
                            '</a>';
            }

            var podStatus = status.phase;
            var restartCount = procIfDataIsNull(status.containerStatuses,
                function (data) {
                    return data.reduce(function (a, b) {
                        return {restartCount: a.restartCount + b.restartCount};
                    }, {restartCount: 0}).restartCount;
                }, 0);

            var creationTimestamp = metadata.creationTimestamp;

            addPodsEvent(itemList, metadata.labels);

            var statusIconHtml;
            var statusMessageHtml = [];

            if(itemList.type == 'Warning'){ // [Warning]과 [Warning] 외 두 가지 상태로 분류
                statusIconHtml    = "<span class='red2'><i class='fas fa-exclamation-circle'></i> </span>";
                $.each(itemList.message , function (index, eventMessage) {
                    statusMessageHtml += "<p class='red2 custom-content-overflow' data-toggle='tooltip' title='" + eventMessage + "'>" + eventMessage + "</p>";
                });

            }else{
                statusIconHtml    = "<span class='green2'><i class='fas fa-check-circle'></i> </span>";
            }

            resultArea.append('<tr>' +
                                '<td>' +
                                    statusIconHtml +
                                    "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/workloads/pods/" + podName + "\");'>" + podName + "</a>" +
                                    statusMessageHtml +
                                '</td>' +
                                "<td><a href='javascript:void(0);' data-toggle='tooltip' title='"+namespace+"' onclick='procMovePage(\"<%= Constants.URI_CONTROLLER_NAMESPACE %>/" + namespace + "\");'>" + namespace + "</td>" +
                                '<td>' + nodeLink + '</td>' +
                                '<td>' + podStatus + '</td>' +
                                '<td>' + restartCount + '</td>' +
                                '<td>' + creationTimestamp + '</td>' +
                            '</tr>');

        });

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultTable.tablesorter();
            resultTable.trigger("update");
            $('.headerSortFalse > td').unbind();
        }

        procSetEventStatusForPods(podNameList);
    };


    //3개 일때는 동작하지 않는드아!
    var createAnnotations = function (annotations) {
        var tempStr = "";
        var index = 0;
        Object.keys(annotations).forEach(function (key) {
            if(index == 0) {
                tempStr += createSpans(key + ":"+ annotations[key]);
            } else {
                tempStr += '<span class="bg_blue"><a href="#" data-target="#layerpop3" data-toggle="modal">' + key + '</a></span>';
                $("#modal-body").innerHTML = '<p>' + annotations[key] + '</p> ';
            }
            index ++;
        });
        return tempStr;
    };

</script>
