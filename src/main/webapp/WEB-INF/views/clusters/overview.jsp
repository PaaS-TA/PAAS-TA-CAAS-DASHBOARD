<%--TODO :: REMOVE--%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>

<%--<div class="content">--%>
    <%--<h1 class="view-title"><i class="fas fa-info-circle"></i> Introduction</h1>--%>
    <%--<!-- Intro 시작-->--%>
    <%--<div class="cluster_content01 row two_line two_view">--%>
        <%--<ul id="detailTab" class="maT10">--%>
            <%--<!-- Namespace 시작-->--%>
            <%--<li>--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Namespace</p>--%>
                    <%--</div>--%>
                    <%--<div class="account_table view">--%>
                        <%--<table>--%>
                            <%--<colgroup>--%>
                                <%--<col style='width:20%'>--%>
                                <%--<col style=".">--%>
                            <%--</colgroup>--%>
                            <%--<tbody id="noResultAreaForNameSpaceDetails" style="display: none;"></tbody>--%>
                            <%--<tbody id="resultAreaForNameSpaceDetails" style="display: none;">--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Name</th>--%>
                                <%--<td id="nameSpaceName"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Creation Time</th>--%>
                                <%--<td id="nameSpaceCreationTime"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Status</th>--%>
                                <%--<td id="nameSpaceStatus"></td>--%>
                            <%--</tr>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<!-- Namespace 끝-->--%>
            <%--<!-- Plan 시작-->--%>
            <%--<li class="maT30">--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Plan</p>--%>
                    <%--</div>--%>
                    <%--<div class="account_table view">--%>
                        <%--<table>--%>
                            <%--<colgroup>--%>
                                <%--<col style='width:20%'>--%>
                                <%--<col style=".">--%>
                            <%--</colgroup>--%>
                            <%--<tbody>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Name</th>--%>
                                <%--<td>CaaS service plan 4</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Disk size</th>--%>
                                <%--<td>100 GB</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Status</th>--%>
                                <%--<td>Running</td>--%>
                            <%--</tr>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<!-- Plan 끝-->--%>
        <%--</ul>--%>
    <%--</div>--%>
    <%--<!-- Intro 끝 -->--%>
<%--</div>--%>

<%--<script id="quota-template" type="text/x-handlebars-template">--%>
    <%--<li class="cluster_second_box maB50">--%>
        <%--<div class="sortable_wrap">--%>
            <%--<div class="sortable_top">--%>
                <%--<p>Resource Quotas</p>--%>
            <%--</div>--%>
            <%--<div class="view_table_wrap">--%>
                <%--<table class="table_event condition alignL">--%>
                    <%--<p class="p30">- <strong>Name</strong> : {{metadata.name}} / - <strong>Scopes</strong> :--%>
                        <%--{{#if spec.scopes}}--%>
                        <%--{{spec.scopes}}--%>
                        <%--{{else}}--%>
                        <%-----%>
                        <%--{{/if}}--%>
                    <%--</p>--%>
                    <%--<colgroup>--%>
                        <%--<col style='width:auto;'>--%>
                        <%--<col style='width:20%;'>--%>
                        <%--<col style='width:20%;'>--%>
                    <%--</colgroup>--%>
                    <%--<thead>--%>
                    <%--<tr>--%>
                        <%--<td>Resource Name</td>--%>
                        <%--<td>Hard</td>--%>
                        <%--<td>Used</td>--%>
                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody></tbody>--%>
                <%--</table>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</li>--%>
<%--</script>--%>

<%--<script type="text/javascript">--%>

    <%--var getDetail = function() {--%>
        <%--viewLoading('show');--%>

        <%--procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail.do", "GET", null, null, callbackGetDetail);--%>
    <%--};--%>


    <%--var callbackGetDetail = function(data) {--%>
        <%--var noResultAreaForNameSpaceDetails = $("#noResultAreaForNameSpaceDetails");--%>
        <%--var resultAreaForNameSpaceDetails = $("#resultAreaForNameSpaceDetails");--%>

        <%--if (data.resultCode === "500") {--%>
            <%--noResultAreaForNameSpaceDetails.show();--%>
            <%--viewLoading('hide');--%>
            <%--alertMessage('Get NameSpaces Fail~', false);--%>

            <%--return false;--%>
        <%--}--%>

        <%--// $("#title").html(data.metadata.name);--%>
        <%--$("#title").html(NAME_SPACE);--%>

        <%--// var namespaceName = data.metadata.name;--%>
        <%--var namespaceNameHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + NAME_SPACE + "</a>";--%>

        <%--// $("#nameSpaceName").html(data.metadata.name);--%>
        <%--$("#nameSpaceName").html(namespaceNameHtml);--%>
        <%--$("#nameSpaceCreationTime").html(data.metadata.creationTimestamp);--%>
        <%--$("#nameSpaceStatus").html(data.status.phase);--%>

        <%--resultAreaForNameSpaceDetails.show();--%>

        <%--viewLoading('hide');--%>
    <%--};--%>


    <%--var getResourceQuotaList = function(namespace) {--%>
        <%--viewLoading('show');--%>

        <%--procCallAjax("/caas/clusters/namespaces/"+namespace+"/getResourceQuotaList.do", "GET", null, null, callbackGetResourceQuotaList);--%>
    <%--};--%>


    <%--var callbackGetResourceQuotaList = function(data) {--%>
        <%--var source = $("#quota-template").html();--%>
        <%--var template = Handlebars.compile(source);--%>
        <%--var trHtml = "";--%>

        <%--if (data.resultCode === "500") {--%>
            <%--var html0 = template(null);--%>
            <%--html0 = html0.replace("<tbody>", "<tbody><tr><p class=service_p'>조회 된 ResourceQuota가 없습니다.</p></tr>");--%>

            <%--$("#detailTab").append(html0);--%>

            <%--viewLoading('hide');--%>
            <%--alertMessage('Get NameSpaces Fail~', false);--%>

            <%--return false;--%>
        <%--}--%>

        <%--for (var i = 0; i < data.items.length; i++) {--%>
            <%--var html = template(data.items[i]);--%>
            <%--var hards = data.items[i].status.hard;--%>
            <%--var useds = data.items[i].status.used;--%>

            <%--for ( var key in hards ) {--%>
                <%--trHtml +=--%>
                    <%--"<tr>"--%>
                    <%--+ "<td>" + key + "</td>"--%>
                    <%--+ "<td>" + hards[key] + "</td>"--%>
                    <%--+ "<td>" + useds[key] + "</td>"--%>
                    <%--+ "</tr>";--%>
            <%--}--%>
            <%--html = html.replace("<tbody>", "<tbody>"+trHtml);--%>

            <%--$("#detailTab").append(html);--%>
        <%--}--%>

        <%--viewLoading('hide');--%>
    <%--};--%>


    <%--$(document.body).ready(function () {--%>
        <%--getDetail();--%>
        <%--getResourceQuotaList(NAME_SPACE);--%>
    <%--});--%>

<%--</script>--%>






<%--&lt;%&ndash;TODO :: REMOVE&ndash;%&gt;--%>
<%--&lt;%&ndash;<%@ page import="org.paasta.caas.dashboard.common.Constants" %>&ndash;%&gt;--%>
<%--&lt;%&ndash;<%@page contentType="text/html" pageEncoding="UTF-8"%>&ndash;%&gt;--%>

<%--&lt;%&ndash;<div class="content">&ndash;%&gt;--%>
    <%--&lt;%&ndash;<jsp:include page="../common/contents-tab.jsp" flush="true"/>&ndash;%&gt;--%>

    <%--&lt;%&ndash;<!-- Overview 시작-->&ndash;%&gt;--%>
    <%--&lt;%&ndash;<div class="cluster_content01 row two_line two_view harf_view">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<ul class="maT30">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<li class="cluster_first_box">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div class="sortable_wrap">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div class="sortable_top">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<p>Namespaces</p>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div class="view_table_wrap">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<table class="table_event condition alignL">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<colgroup>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:auto;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:20%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:20%;'>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</colgroup>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<thead>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tr id="noResultHeaderAreaForNameSpace" style="display: none;"><td colspan='3'><p class='service_p'>조회 된 NameSpace가 없습니다.</p></td></tr>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tr id="resultHeaderAreaForNameSpace" style="display: none;">&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Name</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Status</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Created on</td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</thead>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tbody id="resultAreaForNameSpace">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tbody>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</table>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<li class="cluster_second_box">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div class="sortable_wrap">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div class="sortable_top">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<p>Nodes</p>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div class="view_table_wrap">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<table id="clusters_nodes_table" class="table_event condition alignL">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<colgroup>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:auto;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:5%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:10%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:10%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:12%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:12%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:20%;'>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</colgroup>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<thead>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tr id="noResultHeaderAreaForNodes" style="display: none;"><td colspan='3'><p class='service_p'>조회 된 Nodes가 없습니다.</p></td></tr>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tr id="resultHeaderAreaForNodes" style="display: none;">&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Name <button data-sort-key="node-name" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button></td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Ready</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>CPU requests</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>CPU limits</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Memory requests</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Memory limits</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Created on <button data-sort-key="created-on" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</thead>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tbody id="resultAreaForNodes">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tbody>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</table>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<li class="cluster_third_box maB50">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div class="sortable_wrap">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div class="sortable_top">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<p>Persistent Volumes</p>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div class="view_table_wrap">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<table id="clusters_persistent_table" class="table_event condition alignL">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<colgroup>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:auto;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:8%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:10%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:10%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:8%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:5%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:5%;'>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<col style='width:20%;'>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</colgroup>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<thead>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tr id="noResultHeaderAreaForPersistent" style="display: none;"><td colspan='8'><p class='service_p'>실행 중인 Service가 없습니다.</p></td></tr>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tr id="resultHeaderAreaForPersistent" style="display: none;">&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Name<button class="sort-arrow" onclick="procSetSortList('clusters_persistent_table', this, '0')"><i class="fas fa-caret-down"></i></button></td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Capacity</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Access Modes</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Reclaim policy</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Status</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Claim</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Reason</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Created on<button class="sort-arrow" onclick="procSetSortList('clusters_persistent_table', this, '7')"><i class="fas fa-caret-down"></i></button>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</thead>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<tbody id="resultAreaForPersistent">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tbody>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</table>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</ul>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<!-- Overview 끝 -->&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>

<%--&lt;%&ndash;<script type="text/javascript">&ndash;%&gt;--%>

    <%--&lt;%&ndash;var gList;&ndash;%&gt;--%>

    <%--&lt;%&ndash;var getNamespaces = function() {&ndash;%&gt;--%>
        <%--&lt;%&ndash;viewLoading('show');&ndash;%&gt;--%>

        <%--&lt;%&ndash;procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail.do", "GET", null, null, callbackGetNamespaces);&ndash;%&gt;--%>
    <%--&lt;%&ndash;};&ndash;%&gt;--%>

    <%--&lt;%&ndash;var callbackGetNamespaces = function(data) {&ndash;%&gt;--%>
        <%--&lt;%&ndash;var resultAreaForNameSpace = $("#resultAreaForNameSpace");&ndash;%&gt;--%>
        <%--&lt;%&ndash;var noResultHeaderAreaForNameSpace = $("#noResultHeaderAreaForNameSpace");&ndash;%&gt;--%>
        <%--&lt;%&ndash;var resultHeaderAreaForNameSpace = $("#resultHeaderAreaForNameSpace");&ndash;%&gt;--%>

        <%--&lt;%&ndash;// if (RESULT_STATUS_FAIL === data.resultCode) return false;&ndash;%&gt;--%>
        <%--&lt;%&ndash;if (data.resultCode == "500") {&ndash;%&gt;--%>
            <%--&lt;%&ndash;noResultHeaderAreaForNameSpace.show();&ndash;%&gt;--%>
            <%--&lt;%&ndash;viewLoading('hide');&ndash;%&gt;--%>
            <%--&lt;%&ndash;alertMessage('Get NameSpaces Fail~', false);&ndash;%&gt;--%>

            <%--&lt;%&ndash;return false;&ndash;%&gt;--%>
        <%--&lt;%&ndash;}&ndash;%&gt;--%>

        <%--&lt;%&ndash;var htmlString = [];&ndash;%&gt;--%>

        <%--&lt;%&ndash;htmlString.push(&ndash;%&gt;--%>
            <%--&lt;%&ndash;"<tr>"&ndash;%&gt;--%>
            <%--&lt;%&ndash;+ "<td><span class='green2'><i class='fas fa-check-circle'></i></span> <a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + data.metadata.name + "</a></td>"&ndash;%&gt;--%>
            <%--&lt;%&ndash;+ "<td>" + data.status.phase + "</td>"&ndash;%&gt;--%>
            <%--&lt;%&ndash;+ "<td>" + data.metadata.creationTimestamp + "</td>"&ndash;%&gt;--%>
            <%--&lt;%&ndash;+ "</tr>");&ndash;%&gt;--%>

        <%--&lt;%&ndash;resultAreaForNameSpace.html(htmlString);&ndash;%&gt;--%>
        <%--&lt;%&ndash;noResultHeaderAreaForNameSpace.hide();&ndash;%&gt;--%>
        <%--&lt;%&ndash;resultHeaderAreaForNameSpace.show();&ndash;%&gt;--%>

        <%--&lt;%&ndash;viewLoading('hide');&ndash;%&gt;--%>
    <%--&lt;%&ndash;};&ndash;%&gt;--%>

    <%--&lt;%&ndash;var getNodes = function() {&ndash;%&gt;--%>
        <%--&lt;%&ndash;viewLoading('show');&ndash;%&gt;--%>

        <%--&lt;%&ndash;var reqUrl = "<%= Constants.API_URL %>/nodes"&ndash;%&gt;--%>
        <%--&lt;%&ndash;procCallAjax(reqUrl, "GET", null, null, callbackGetListNodes);&ndash;%&gt;--%>
    <%--&lt;%&ndash;}&ndash;%&gt;--%>

    <%--&lt;%&ndash;var callbackGetListNodes = function(data) {&ndash;%&gt;--%>
        <%--&lt;%&ndash;var resultAreaForNodes = $("#resultAreaForNodes");&ndash;%&gt;--%>
        <%--&lt;%&ndash;var noResultHeaderAreaForNodes = $("#noResultHeaderAreaForNodes");&ndash;%&gt;--%>
        <%--&lt;%&ndash;var resultHeaderAreaForNodes = $("#resultHeaderAreaForNodes");&ndash;%&gt;--%>

        <%--&lt;%&ndash;if (data.resultCode == "500") {&ndash;%&gt;--%>
            <%--&lt;%&ndash;noResultHeaderAreaForNodes.show();&ndash;%&gt;--%>
            <%--&lt;%&ndash;viewLoading('hide');&ndash;%&gt;--%>
            <%--&lt;%&ndash;alertMessage('Get Nodes Fail~', false);&ndash;%&gt;--%>

            <%--&lt;%&ndash;return false;&ndash;%&gt;--%>
        <%--&lt;%&ndash;}&ndash;%&gt;--%>

        <%--&lt;%&ndash;var nodePodCountList = {};&ndash;%&gt;--%>
        <%--&lt;%&ndash;if (data.items.length > 0) {&ndash;%&gt;--%>
            <%--&lt;%&ndash;var podsReqBaseUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + NAME_SPACE + "/pods/node/";&ndash;%&gt;--%>
            <%--&lt;%&ndash;$.each(data.items, function (index, nodeItem) {&ndash;%&gt;--%>
                <%--&lt;%&ndash;var podsReqUrl = podsReqBaseUrl + nodeItem.metadata.name;&ndash;%&gt;--%>
                <%--&lt;%&ndash;procCallAjax(podsReqUrl, "GET", null, null, function(podList) {&ndash;%&gt;--%>
                    <%--&lt;%&ndash;nodePodCountList[nodeItem.metadata.name] =&ndash;%&gt;--%>
                        <%--&lt;%&ndash;(podList.items != null)? podList.items.length : 0;&ndash;%&gt;--%>
                <%--&lt;%&ndash;});&ndash;%&gt;--%>
            <%--&lt;%&ndash;});&ndash;%&gt;--%>

        <%--&lt;%&ndash;}&ndash;%&gt;--%>

        <%--&lt;%&ndash;// filtering nodes by pod&ndash;%&gt;--%>
        <%--&lt;%&ndash;while (Object.keys(nodePodCountList) < data.items.length) { /* infinite loop */ }&ndash;%&gt;--%>
        <%--&lt;%&ndash;var filterItems = data.items.filter(function (value, index) {&ndash;%&gt;--%>
            <%--&lt;%&ndash;return nodePodCountList[value.metadata.name] > 0;&ndash;%&gt;--%>
        <%--&lt;%&ndash;});&ndash;%&gt;--%>

        <%--&lt;%&ndash;var contents = [];&ndash;%&gt;--%>
        <%--&lt;%&ndash;$.each(filterItems, function (index, nodeItem) {&ndash;%&gt;--%>
            <%--&lt;%&ndash;var _metadata = nodeItem.metadata;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var _status = nodeItem.status;&ndash;%&gt;--%>

            <%--&lt;%&ndash;var name = _metadata.name;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var ready = _status.conditions.filter(function(condition) {&ndash;%&gt;--%>
                <%--&lt;%&ndash;return condition.type === "Ready";&ndash;%&gt;--%>
            <%--&lt;%&ndash;})[0].status;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var limitCPU = _status.capacity.cpu;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var requestCPU = limitCPU - _status.allocatable.cpu;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var limitMemory = procConvertByte(_status.capacity.memory);&ndash;%&gt;--%>
            <%--&lt;%&ndash;var requestMemory = limitMemory - procConvertByte(_status.allocatable.memory);&ndash;%&gt;--%>
            <%--&lt;%&ndash;var creationTimestamp = _metadata.creationTimestamp;&ndash;%&gt;--%>

            <%--&lt;%&ndash;// TODO&ndash;%&gt;--%>
            <%--&lt;%&ndash;var nameHtml = '<a href="./nodes/' + name + '/summary"> ' + name + '</a>';&ndash;%&gt;--%>
            <%--&lt;%&ndash;if (ready == "True")&ndash;%&gt;--%>
                <%--&lt;%&ndash;nameHtml = '<span class="green2"><i class="fas fa-check-circle"></i></span>' + nameHtml;&ndash;%&gt;--%>
            <%--&lt;%&ndash;else&ndash;%&gt;--%>
                <%--&lt;%&ndash;nameHtml = '<span class="red2"><i class="fas fa-exclamation-circle"></i></span>' + nameHtml;&ndash;%&gt;--%>

            <%--&lt;%&ndash;contents.push('<tr data-node-name="' + name + '" data-created-on="' + creationTimestamp + '">'&ndash;%&gt;--%>
                <%--&lt;%&ndash;+ '<td>' + nameHtml + '</td>'&ndash;%&gt;--%>
                <%--&lt;%&ndash;+ '<td>' + ready + '</td>'&ndash;%&gt;--%>
                <%--&lt;%&ndash;+ '<td>' + requestCPU + '</td>'&ndash;%&gt;--%>
                <%--&lt;%&ndash;+ '<td>' + limitCPU + '</td>'&ndash;%&gt;--%>
                <%--&lt;%&ndash;+ '<td>' + procFormatCapacity(requestMemory, "Mi") + '</td>'&ndash;%&gt;--%>
                <%--&lt;%&ndash;+ '<td>' + procFormatCapacity(limitMemory, "Mi") + '</td>'&ndash;%&gt;--%>
                <%--&lt;%&ndash;+ '<td>' + creationTimestamp + '</td></tr>'&ndash;%&gt;--%>
            <%--&lt;%&ndash;);&ndash;%&gt;--%>
        <%--&lt;%&ndash;});&ndash;%&gt;--%>

        <%--&lt;%&ndash;resultAreaForNodes.html(contents);&ndash;%&gt;--%>
        <%--&lt;%&ndash;noResultHeaderAreaForNodes.hide();&ndash;%&gt;--%>
        <%--&lt;%&ndash;resultHeaderAreaForNodes.show();&ndash;%&gt;--%>

        <%--&lt;%&ndash;sortTable("clusters_nodes_table", "node-name");&ndash;%&gt;--%>

        <%--&lt;%&ndash;viewLoading('hide');&ndash;%&gt;--%>
    <%--&lt;%&ndash;}&ndash;%&gt;--%>

    <%--&lt;%&ndash;var getPersistent = function(data) {&ndash;%&gt;--%>
        <%--&lt;%&ndash;viewLoading('show');&ndash;%&gt;--%>

        <%--&lt;%&ndash;procCallAjax("<%= Constants.API_URL %>/persistentvolumes", "GET", null, null, callbackGetPersistentList);&ndash;%&gt;--%>
    <%--&lt;%&ndash;}&ndash;%&gt;--%>

    <%--&lt;%&ndash;var callbackGetPersistentList = function(data) {&ndash;%&gt;--%>
        <%--&lt;%&ndash;if (RESULT_STATUS_FAIL === data.resultStatus) {&ndash;%&gt;--%>
            <%--&lt;%&ndash;viewLoading('hide');&ndash;%&gt;--%>
            <%--&lt;%&ndash;return false;&ndash;%&gt;--%>
        <%--&lt;%&ndash;}&ndash;%&gt;--%>

        <%--&lt;%&ndash;gList = data;&ndash;%&gt;--%>
        <%--&lt;%&ndash;setPersistentList("");&ndash;%&gt;--%>
    <%--&lt;%&ndash;};&ndash;%&gt;--%>

    <%--&lt;%&ndash;// SET LIST&ndash;%&gt;--%>
    <%--&lt;%&ndash;var setPersistentList = function(searchKeyword) {&ndash;%&gt;--%>

        <%--&lt;%&ndash;var resultArea = $('#resultAreaForPersistent');&ndash;%&gt;--%>
        <%--&lt;%&ndash;var resultHeaderArea = $('#resultHeaderAreaForPersistent');&ndash;%&gt;--%>
        <%--&lt;%&ndash;var noResultArea = $('#noResultHeaderAreaForPersistent');&ndash;%&gt;--%>
        <%--&lt;%&ndash;var resultTable = $('#clusters_persistent_table');&ndash;%&gt;--%>

        <%--&lt;%&ndash;var items = gList.items;&ndash;%&gt;--%>
        <%--&lt;%&ndash;var listLength = items.length;&ndash;%&gt;--%>
        <%--&lt;%&ndash;var checkListCount = 0;&ndash;%&gt;--%>
        <%--&lt;%&ndash;var htmlString = [];&ndash;%&gt;--%>

        <%--&lt;%&ndash;// REF&ndash;%&gt;--%>
        <%--&lt;%&ndash;// service.namespace:port protocol&ndash;%&gt;--%>
        <%--&lt;%&ndash;// service.namespace:nodePort protocol -> service.namespace:0 protocol&ndash;%&gt;--%>

        <%--&lt;%&ndash;$.each(items, function (index, itemList) {&ndash;%&gt;--%>

            <%--&lt;%&ndash;var pvName = itemList.metadata.name;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var capacity = JSON.stringify(itemList.spec.capacity);&ndash;%&gt;--%>
            <%--&lt;%&ndash;var accessModes = itemList.spec.accessModes;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var reclaimPolicy = itemList.spec.persistentVolumeReclaimPolicy;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var claim = "-";&ndash;%&gt;--%>
            <%--&lt;%&ndash;var status = itemList.status.phase;&ndash;%&gt;--%>
            <%--&lt;%&ndash;var reason = "-";&ndash;%&gt;--%>
            <%--&lt;%&ndash;var creationTimestamp = itemList.metadata.creationTimestamp;&ndash;%&gt;--%>

            <%--&lt;%&ndash;if ((nvl(searchKeyword) === "") || pvName.indexOf(searchKeyword) > -1) {&ndash;%&gt;--%>


                <%--&lt;%&ndash;htmlString.push(&ndash;%&gt;--%>
                    <%--&lt;%&ndash;"<tr>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/clusters/persistentVolumes/" + pvName + "\");'>" + pvName + "</a>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td>" + capacity + "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td>" + accessModes + "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td>" + reclaimPolicy + "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td>" + status + "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td>" + claim + "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td>" + reason + "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "<td>" + creationTimestamp + "</td>"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;+ "</tr>");&ndash;%&gt;--%>

                <%--&lt;%&ndash;checkListCount++;&ndash;%&gt;--%>
            <%--&lt;%&ndash;}&ndash;%&gt;--%>
        <%--&lt;%&ndash;});&ndash;%&gt;--%>

        <%--&lt;%&ndash;if (listLength < 1 || checkListCount < 1) {&ndash;%&gt;--%>
            <%--&lt;%&ndash;resultHeaderArea.hide();&ndash;%&gt;--%>
            <%--&lt;%&ndash;resultArea.hide();&ndash;%&gt;--%>
            <%--&lt;%&ndash;noResultArea.show();&ndash;%&gt;--%>
        <%--&lt;%&ndash;} else {&ndash;%&gt;--%>
            <%--&lt;%&ndash;noResultArea.hide();&ndash;%&gt;--%>
            <%--&lt;%&ndash;resultHeaderArea.show();&ndash;%&gt;--%>
            <%--&lt;%&ndash;resultArea.show();&ndash;%&gt;--%>
            <%--&lt;%&ndash;resultArea.html(htmlString);&ndash;%&gt;--%>
            <%--&lt;%&ndash;resultTable.tablesorter();&ndash;%&gt;--%>
            <%--&lt;%&ndash;resultTable.trigger("update");&ndash;%&gt;--%>
        <%--&lt;%&ndash;}&ndash;%&gt;--%>

        <%--&lt;%&ndash;viewLoading('hide');&ndash;%&gt;--%>

    <%--&lt;%&ndash;};&ndash;%&gt;--%>

    <%--&lt;%&ndash;$(document.body).ready(function () {&ndash;%&gt;--%>
        <%--&lt;%&ndash;getNamespaces();&ndash;%&gt;--%>

        <%--&lt;%&ndash;$("#resultHeaderAreaForNodes .sort-arrow").on("click", function(event) {&ndash;%&gt;--%>
            <%--&lt;%&ndash;var tableId = "clusters_nodes_table";&ndash;%&gt;--%>
            <%--&lt;%&ndash;var sortKey = $(event.currentTarget).data('sort-key');&ndash;%&gt;--%>
            <%--&lt;%&ndash;var isAscending = $(event.currentTarget).hasClass('sort')? true : false;&ndash;%&gt;--%>
            <%--&lt;%&ndash;sortTable(tableId, sortKey, isAscending);&ndash;%&gt;--%>
        <%--&lt;%&ndash;});&ndash;%&gt;--%>

        <%--&lt;%&ndash;getNodes();&ndash;%&gt;--%>

        <%--&lt;%&ndash;getPersistent();&ndash;%&gt;--%>
    <%--&lt;%&ndash;});&ndash;%&gt;--%>

<%--&lt;%&ndash;</script>&ndash;%&gt;--%>
