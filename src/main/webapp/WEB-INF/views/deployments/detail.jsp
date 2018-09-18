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
            <li class="cluster_first_box">
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
                                <td id="labels" class="labels_wrap"></td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="annotations" class="labels_wrap">
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
            <li class="cluster_third_box">
                <jsp:include page="../pods/list.jsp" flush="true"/>
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

    var getDetail = function() {
        var reqUrl = "<%= Constants.URI_API_DEPLOYMENTS_DETAIL %>".replace("{namespace:.+}", NAME_SPACE)
                                                                    .replace("{deploymentName:.+}", document.getElementById('requestDeploymentsName').value);

        procCallAjax(reqUrl, "GET", null, null, callbackGetDeployment);
    };

    var getReplicaSetsList = function (selector) {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_REPLICASETS_RESOURCES %>".replace("{namespace:.+}", NAME_SPACE)
            .replace("{selector:.+}", selector);
        procCallAjax(reqUrl, "GET", null, null, callbackGetReplicasetList);
    }

    // GET DETAIL FOR PODS LIST
    var getDetailForPodsList = function(selector) {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR %>".replace("{namespace:.+}", NAME_SPACE).replace("{selector:.+}", selector);
        getPodListUsingRequestURL(reqUrl);
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
        document.getElementById("labels").innerHTML = procCreateSpans(labels);
        document.getElementById("annotations").innerHTML = createAnnotations(annotations);
        document.getElementById("creationTime").textContent = creationTimestamp;
        document.getElementById("selector").innerHTML = procCreateSpans(selector);
        document.getElementById("strategy").textContent = strategy;
        document.getElementById("minReadySeconds").textContent = minReadySeconds;
        document.getElementById("revisionHistoryLimit").textContent = revisionHistoryLimit;
        document.getElementById("rollingUpdateStrategy").textContent = rollingUpdateStrategy;
        document.getElementById("status").textContent = replicaStatus;

        getReplicaSetsList(replaceLabels(selector));
        getDetailForPodsList(replaceLabels(selector));

    }

    var replaceLabels = function (data) {
        return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D');
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

            var containers = itemList.spec.template.spec.containers;
            var imageTags = "";
            for (var i = 0; i < containers.length; i++) {
                imageTags += '<p class="custom-content-overflow" data-toggle="tooltip" title="' + containers[i].image + '">' + containers[i].image + '</p>';
            }

            resultArea.append('<tr>' +
                                    '<td>' +
                                        '<span class="green2"><i class="fas fa-check-circle"></i></span> ' +
                                        "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/workloads/replicaSets/" + replicasetName + "\");' data-toggle='tooltip' title='"+replicasetName+"' >"+
                                            replicasetName +
                                        '</a>' +
                                    '</td>' +
                                    "<td><a href='javascript:void(0);' data-toggle='tooltip' title='"+namespace+"' onclick='procMovePage(\"<%= Constants.URI_CONTROLLER_NAMESPACE %>/" + namespace + "\");'>" + namespace + "</td>" +
                                    '<td>' + procCreateSpans(labels, "LB") + '</td>' +
                                    '<td>' + availableReplicas + " / " + replicas + '</td>' +
                                    "<td>" + imageTags + "</td>" +
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

        procSetToolTipForTableTd('replicasetsResultTable');

    };

    //3개 일때는 동작하지 않는드아!
    var createAnnotations = function (annotations) {
        var tempStr = "";
        Object.keys(annotations).forEach(function (key) {
            if(typeof JSON.parse(annotations[key]) == 'object') {
                tempStr += '<span class="bg_blue"><a href="#" data-target="#layerpop3" data-toggle="modal">' + key + '</a></span>';
                $('.modal-title').html(key);
                $(".modal-body").html('<p>' + annotations[key] + '</p>');

            } else {
                tempStr += procCreateSpans(key + ":"+ annotations[key]);
            }
        });
        return tempStr;
    };

    $(document.body).ready(function () {
        /* 차트 주석
        createChart("current", "cpu");
        createChart("current", "mem");
        createChart("current", "disk");*/
        viewLoading('show');
        getDetail();
    });

</script>
