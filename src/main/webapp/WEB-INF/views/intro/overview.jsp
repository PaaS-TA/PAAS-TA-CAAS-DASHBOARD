<%--
  Intro overview main
  @author REX
  @version 1.0
  @since 2018.09.10
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="content">
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <div class="cluster_tabs clearfix"></div>
    <!-- Intro 시작-->
    <div class="cluster_content01 row two_line two_view">
        <ul id="detailTab">
            <!-- Namespace 시작-->
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Namespace</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style='width:20%'>
                                <col style=".">
                            </colgroup>
                            <tbody id="noResultAreaForNameSpaceDetails" style="display: none;"></tbody>
                            <tbody id="resultAreaForNameSpaceDetails" style="display: none;">
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td id="nameSpaceName"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="nameSpaceCreationTime"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td id="nameSpaceStatus"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Namespace 끝-->
            <!-- Plan 시작-->
            <li class="maT30">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Plan</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style='width:20%'>
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Type</th>
                                <td>CaaS service plan 1</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Description</th>
                                <td>
                                    <p>
                                        2 CPUs, 2GB Memory, 10GB Disk (free)
                                    </p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Plan 끝-->
        </ul>
    </div>
    <!-- Intro 끝 -->
</div>

<script id="quota-template" type="text/x-handlebars-template">
    <li class="cluster_second_box maB50">
        <div class="sortable_wrap">
            <div class="sortable_top">
                <p>Resource Quotas</p>
            </div>
            <div class="view_table_wrap">
                <table class="table_event condition alignL">
                    <p class="p30">- <strong>Name</strong> : {{metadata.name}} / - <strong>Scopes</strong> :
                        {{#if spec.scopes}}
                        {{spec.scopes}}
                        {{else}}
                        -
                        {{/if}}
                    </p>
                    <colgroup>
                        <col style='width:auto;'>
                        <col style='width:20%;'>
                        <col style='width:20%;'>
                    </colgroup>
                    <thead>
                    <tr>
                        <td>Resource Name</td>
                        <td>Hard</td>
                        <td>Used</td>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </li>
</script>

<script type="text/javascript">

    var getDetail = function() {
        viewLoading('show');

        procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail", "GET", null, null, callbackGetDetail);
    };


    var callbackGetDetail = function(data) {
        var noResultAreaForNameSpaceDetails = $("#noResultAreaForNameSpaceDetails");
        var resultAreaForNameSpaceDetails = $("#resultAreaForNameSpaceDetails");

        if (data.resultCode === "500") {
            noResultAreaForNameSpaceDetails.show();
            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        // $("#title").html(data.metadata.name);
        $("#title").html(NAME_SPACE);

        // var namespaceName = data.metadata.name;
        var namespaceNameHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + NAME_SPACE + "</a>";

        // $("#nameSpaceName").html(data.metadata.name);
        $("#nameSpaceName").html(namespaceNameHtml);
        $("#nameSpaceCreationTime").html(data.metadata.creationTimestamp);
        $("#nameSpaceStatus").html(data.status.phase);

        resultAreaForNameSpaceDetails.show();

        viewLoading('hide');
    };


    var getResourceQuotaList = function(namespace) {
        viewLoading('show');

        procCallAjax("/caas/clusters/namespaces/"+namespace+"/getResourceQuotaList", "GET", null, null, callbackGetResourceQuotaList);
    };


    var callbackGetResourceQuotaList = function(data) {
        var source = $("#quota-template").html();
        var template = Handlebars.compile(source);
        var trHtml = "";

        if (data.resultCode === "500") {
            var html0 = template(null);
            html0 = html0.replace("<tbody>", "<tbody><tr><p class=service_p'>조회 된 ResourceQuota가 없습니다.</p></tr>");

            $("#detailTab").append(html0);

            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        for (var i = 0; i < data.items.length; i++) {
            var html = template(data.items[i]);
            var hards = data.items[i].status.hard;
            var useds = data.items[i].status.used;

            for ( var key in hards ) {
                trHtml +=
                    "<tr>"
                    + "<td>" + key + "</td>"
                    + "<td>" + hards[key] + "</td>"
                    + "<td>" + useds[key] + "</td>"
                    + "</tr>";
            }
            html = html.replace("<tbody>", "<tbody>"+trHtml);

            $("#detailTab").append(html);
        }

        viewLoading('hide');
    };


    $(document.body).ready(function () {
        getDetail();
        getResourceQuotaList(NAME_SPACE);
    });

</script>






<%--TODO :: REMOVE--%>
<%--<%@ page import="org.paasta.caas.dashboard.common.Constants" %>--%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>

<%--<div class="content">--%>
    <%--<jsp:include page="../common/contents-tab.jsp" flush="true"/>--%>

    <%--<!-- Overview 시작-->--%>
    <%--<div class="cluster_content01 row two_line two_view harf_view">--%>
        <%--<ul class="maT30">--%>
            <%--<li class="cluster_first_box">--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Namespaces</p>--%>
                    <%--</div>--%>
                    <%--<div class="view_table_wrap">--%>
                        <%--<table class="table_event condition alignL">--%>
                            <%--<colgroup>--%>
                                <%--<col style='width:auto;'>--%>
                                <%--<col style='width:20%;'>--%>
                                <%--<col style='width:20%;'>--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--<tr id="noResultHeaderAreaForNameSpace" style="display: none;"><td colspan='3'><p class='service_p'>조회 된 NameSpace가 없습니다.</p></td></tr>--%>
                            <%--<tr id="resultHeaderAreaForNameSpace" style="display: none;">--%>
                                <%--<td>Name</td>--%>
                                <%--<td>Status</td>--%>
                                <%--<td>Created on</td>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody id="resultAreaForNameSpace">--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li class="cluster_second_box">--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Nodes</p>--%>
                    <%--</div>--%>
                    <%--<div class="view_table_wrap">--%>
                        <%--<table id="clusters_nodes_table" class="table_event condition alignL">--%>
                            <%--<colgroup>--%>
                                <%--<col style='width:auto;'>--%>
                                <%--<col style='width:5%;'>--%>
                                <%--<col style='width:10%;'>--%>
                                <%--<col style='width:10%;'>--%>
                                <%--<col style='width:12%;'>--%>
                                <%--<col style='width:12%;'>--%>
                                <%--<col style='width:20%;'>--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--<tr id="noResultHeaderAreaForNodes" style="display: none;"><td colspan='3'><p class='service_p'>조회 된 Nodes가 없습니다.</p></td></tr>--%>
                            <%--<tr id="resultHeaderAreaForNodes" style="display: none;">--%>
                                <%--<td>Name <button data-sort-key="node-name" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button></td>--%>
                                <%--<td>Ready</td>--%>
                                <%--<td>CPU requests</td>--%>
                                <%--<td>CPU limits</td>--%>
                                <%--<td>Memory requests</td>--%>
                                <%--<td>Memory limits</td>--%>
                                <%--<td>Created on <button data-sort-key="created-on" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody id="resultAreaForNodes">--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li class="cluster_third_box maB50">--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Persistent Volumes</p>--%>
                    <%--</div>--%>
                    <%--<div class="view_table_wrap">--%>
                        <%--<table id="clusters_persistent_table" class="table_event condition alignL">--%>
                            <%--<colgroup>--%>
                                <%--<col style='width:auto;'>--%>
                                <%--<col style='width:8%;'>--%>
                                <%--<col style='width:10%;'>--%>
                                <%--<col style='width:10%;'>--%>
                                <%--<col style='width:8%;'>--%>
                                <%--<col style='width:5%;'>--%>
                                <%--<col style='width:5%;'>--%>
                                <%--<col style='width:20%;'>--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--<tr id="noResultHeaderAreaForPersistent" style="display: none;"><td colspan='8'><p class='service_p'>실행 중인 Service가 없습니다.</p></td></tr>--%>
                            <%--<tr id="resultHeaderAreaForPersistent" style="display: none;">--%>
                                <%--<td>Name<button class="sort-arrow" onclick="procSetSortList('clusters_persistent_table', this, '0')"><i class="fas fa-caret-down"></i></button></td>--%>
                                <%--<td>Capacity</td>--%>
                                <%--<td>Access Modes</td>--%>
                                <%--<td>Reclaim policy</td>--%>
                                <%--<td>Status</td>--%>
                                <%--<td>Claim</td>--%>
                                <%--<td>Reason</td>--%>
                                <%--<td>Created on<button class="sort-arrow" onclick="procSetSortList('clusters_persistent_table', this, '7')"><i class="fas fa-caret-down"></i></button>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody id="resultAreaForPersistent">--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
        <%--</ul>--%>
    <%--</div>--%>
    <%--<!-- Overview 끝 -->--%>
<%--</div>--%>

<%--<script type="text/javascript">--%>

    <%--var gList;--%>

    <%--var getNamespaces = function() {--%>
        <%--viewLoading('show');--%>

        <%--procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail", "GET", null, null, callbackGetNamespaces);--%>
    <%--};--%>

    <%--var callbackGetNamespaces = function(data) {--%>
        <%--var resultAreaForNameSpace = $("#resultAreaForNameSpace");--%>
        <%--var noResultHeaderAreaForNameSpace = $("#noResultHeaderAreaForNameSpace");--%>
        <%--var resultHeaderAreaForNameSpace = $("#resultHeaderAreaForNameSpace");--%>

        <%--// if (RESULT_STATUS_FAIL === data.resultCode) return false;--%>
        <%--if (data.resultCode == "500") {--%>
            <%--noResultHeaderAreaForNameSpace.show();--%>
            <%--viewLoading('hide');--%>
            <%--alertMessage('Get NameSpaces Fail~', false);--%>

            <%--return false;--%>
        <%--}--%>

        <%--var htmlString = [];--%>

        <%--htmlString.push(--%>
            <%--"<tr>"--%>
            <%--+ "<td><span class='green2'><i class='fas fa-check-circle'></i></span> <a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + data.metadata.name + "</a></td>"--%>
            <%--+ "<td>" + data.status.phase + "</td>"--%>
            <%--+ "<td>" + data.metadata.creationTimestamp + "</td>"--%>
            <%--+ "</tr>");--%>

        <%--resultAreaForNameSpace.html(htmlString);--%>
        <%--noResultHeaderAreaForNameSpace.hide();--%>
        <%--resultHeaderAreaForNameSpace.show();--%>

        <%--viewLoading('hide');--%>
    <%--};--%>

    <%--var getNodes = function() {--%>
        <%--viewLoading('show');--%>

        <%--var reqUrl = "<%= Constants.API_URL %>/nodes"--%>
        <%--procCallAjax(reqUrl, "GET", null, null, callbackGetListNodes);--%>
    <%--}--%>

    <%--var callbackGetListNodes = function(data) {--%>
        <%--var resultAreaForNodes = $("#resultAreaForNodes");--%>
        <%--var noResultHeaderAreaForNodes = $("#noResultHeaderAreaForNodes");--%>
        <%--var resultHeaderAreaForNodes = $("#resultHeaderAreaForNodes");--%>

        <%--if (data.resultCode == "500") {--%>
            <%--noResultHeaderAreaForNodes.show();--%>
            <%--viewLoading('hide');--%>
            <%--alertMessage('Get Nodes Fail~', false);--%>

            <%--return false;--%>
        <%--}--%>

        <%--var nodePodCountList = {};--%>
        <%--if (data.items.length > 0) {--%>
            <%--var podsReqBaseUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + NAME_SPACE + "/pods/node/";--%>
            <%--$.each(data.items, function (index, nodeItem) {--%>
                <%--var podsReqUrl = podsReqBaseUrl + nodeItem.metadata.name;--%>
                <%--procCallAjax(podsReqUrl, "GET", null, null, function(podList) {--%>
                    <%--nodePodCountList[nodeItem.metadata.name] =--%>
                        <%--(podList.items != null)? podList.items.length : 0;--%>
                <%--});--%>
            <%--});--%>

        <%--}--%>

        <%--// filtering nodes by pod--%>
        <%--while (Object.keys(nodePodCountList) < data.items.length) { /* infinite loop */ }--%>
        <%--var filterItems = data.items.filter(function (value, index) {--%>
            <%--return nodePodCountList[value.metadata.name] > 0;--%>
        <%--});--%>

        <%--var contents = [];--%>
        <%--$.each(filterItems, function (index, nodeItem) {--%>
            <%--var _metadata = nodeItem.metadata;--%>
            <%--var _status = nodeItem.status;--%>

            <%--var name = _metadata.name;--%>
            <%--var ready = _status.conditions.filter(function(condition) {--%>
                <%--return condition.type === "Ready";--%>
            <%--})[0].status;--%>
            <%--var limitCPU = _status.capacity.cpu;--%>
            <%--var requestCPU = limitCPU - _status.allocatable.cpu;--%>
            <%--var limitMemory = procConvertByte(_status.capacity.memory);--%>
            <%--var requestMemory = limitMemory - procConvertByte(_status.allocatable.memory);--%>
            <%--var creationTimestamp = _metadata.creationTimestamp;--%>

            <%--// TODO--%>
            <%--var nameHtml = '<a href="./nodes/' + name + '/summary"> ' + name + '</a>';--%>
            <%--if (ready == "True")--%>
                <%--nameHtml = '<span class="green2"><i class="fas fa-check-circle"></i></span>' + nameHtml;--%>
            <%--else--%>
                <%--nameHtml = '<span class="red2"><i class="fas fa-exclamation-circle"></i></span>' + nameHtml;--%>

            <%--contents.push('<tr data-node-name="' + name + '" data-created-on="' + creationTimestamp + '">'--%>
                <%--+ '<td>' + nameHtml + '</td>'--%>
                <%--+ '<td>' + ready + '</td>'--%>
                <%--+ '<td>' + requestCPU + '</td>'--%>
                <%--+ '<td>' + limitCPU + '</td>'--%>
                <%--+ '<td>' + procFormatCapacity(requestMemory, "Mi") + '</td>'--%>
                <%--+ '<td>' + procFormatCapacity(limitMemory, "Mi") + '</td>'--%>
                <%--+ '<td>' + creationTimestamp + '</td></tr>'--%>
            <%--);--%>
        <%--});--%>

        <%--resultAreaForNodes.html(contents);--%>
        <%--noResultHeaderAreaForNodes.hide();--%>
        <%--resultHeaderAreaForNodes.show();--%>

        <%--sortTable("clusters_nodes_table", "node-name");--%>

        <%--viewLoading('hide');--%>
    <%--}--%>

    <%--var getPersistent = function(data) {--%>
        <%--viewLoading('show');--%>

        <%--procCallAjax("<%= Constants.API_URL %>/persistentvolumes", "GET", null, null, callbackGetPersistentList);--%>
    <%--}--%>

    <%--var callbackGetPersistentList = function(data) {--%>
        <%--if (RESULT_STATUS_FAIL === data.resultStatus) {--%>
            <%--viewLoading('hide');--%>
            <%--return false;--%>
        <%--}--%>

        <%--gList = data;--%>
        <%--setPersistentList("");--%>
    <%--};--%>

    <%--// SET LIST--%>
    <%--var setPersistentList = function(searchKeyword) {--%>

        <%--var resultArea = $('#resultAreaForPersistent');--%>
        <%--var resultHeaderArea = $('#resultHeaderAreaForPersistent');--%>
        <%--var noResultArea = $('#noResultHeaderAreaForPersistent');--%>
        <%--var resultTable = $('#clusters_persistent_table');--%>

        <%--var items = gList.items;--%>
        <%--var listLength = items.length;--%>
        <%--var checkListCount = 0;--%>
        <%--var htmlString = [];--%>

        <%--// REF--%>
        <%--// service.namespace:port protocol--%>
        <%--// service.namespace:nodePort protocol -> service.namespace:0 protocol--%>

        <%--$.each(items, function (index, itemList) {--%>

            <%--var pvName = itemList.metadata.name;--%>
            <%--var capacity = JSON.stringify(itemList.spec.capacity);--%>
            <%--var accessModes = itemList.spec.accessModes;--%>
            <%--var reclaimPolicy = itemList.spec.persistentVolumeReclaimPolicy;--%>
            <%--var claim = "-";--%>
            <%--var status = itemList.status.phase;--%>
            <%--var reason = "-";--%>
            <%--var creationTimestamp = itemList.metadata.creationTimestamp;--%>

            <%--if ((nvl(searchKeyword) === "") || pvName.indexOf(searchKeyword) > -1) {--%>


                <%--htmlString.push(--%>
                    <%--"<tr>"--%>
                    <%--+ "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "--%>
                    <%--+ "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/clusters/persistentVolumes/" + pvName + "\");'>" + pvName + "</a>"--%>
                    <%--+ "</td>"--%>
                    <%--+ "<td>" + capacity + "</td>"--%>
                    <%--+ "<td>" + accessModes + "</td>"--%>
                    <%--+ "<td>" + reclaimPolicy + "</td>"--%>
                    <%--+ "<td>" + status + "</td>"--%>
                    <%--+ "<td>" + claim + "</td>"--%>
                    <%--+ "<td>" + reason + "</td>"--%>
                    <%--+ "<td>" + creationTimestamp + "</td>"--%>
                    <%--+ "</tr>");--%>

                <%--checkListCount++;--%>
            <%--}--%>
        <%--});--%>

        <%--if (listLength < 1 || checkListCount < 1) {--%>
            <%--resultHeaderArea.hide();--%>
            <%--resultArea.hide();--%>
            <%--noResultArea.show();--%>
        <%--} else {--%>
            <%--noResultArea.hide();--%>
            <%--resultHeaderArea.show();--%>
            <%--resultArea.show();--%>
            <%--resultArea.html(htmlString);--%>
            <%--resultTable.tablesorter();--%>
            <%--resultTable.trigger("update");--%>
        <%--}--%>

        <%--viewLoading('hide');--%>

    <%--};--%>

    <%--$(document.body).ready(function () {--%>
        <%--getNamespaces();--%>

        <%--$("#resultHeaderAreaForNodes .sort-arrow").on("click", function(event) {--%>
            <%--var tableId = "clusters_nodes_table";--%>
            <%--var sortKey = $(event.currentTarget).data('sort-key');--%>
            <%--var isAscending = $(event.currentTarget).hasClass('sort')? true : false;--%>
            <%--sortTable(tableId, sortKey, isAscending);--%>
        <%--});--%>

        <%--getNodes();--%>

        <%--getPersistent();--%>
    <%--});--%>

<%--</script>--%>
