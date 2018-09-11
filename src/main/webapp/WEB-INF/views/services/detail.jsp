<%--
  Services detail
  @author REX
  @version 1.0
  @since 2018.08.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <span class="resultServiceName"> - </span></h1>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <!-- Services Details 시작 -->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT10">
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
                                <td><span class="resultServiceName"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td><span id="resultNamespace"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td><span id="resultCreationTimestamp"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Label Selector</th>
                                <td><span class="bg_gray" id="resultLabelSelector"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Type</th>
                                <td><span id="resultType"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Session Affinity</th>
                                <td><span id="resultSessionAffinity"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Cluster IP</th>
                                <td><span id="resultClusterIp"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Internal endpoints</th>
                                <td id="InternalEndpointsArea"> - </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_third_box">
                <jsp:include page="../pods/list.jsp" flush="true"/>
                <%--TODO :: REMOVE--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Pods</p>--%>
                        <%--<ul class="colright_btn">--%>
                            <%--<li>--%>
                                <%--<input type="text" id="table-search-01" name="" class="table-search" placeholder="search" onkeypress="if(event.keyCode===13) {setPodsList(this.value);}" />--%>
                                <%--<button name="button" class="btn table-search-on" type="button">--%>
                                    <%--<i class="fas fa-search"></i>--%>
                                <%--</button>--%>
                            <%--</li>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                    <%--<div class="view_table_wrap">--%>
                        <%--<table class="table_event condition alignL service-lh" id="resultTable">--%>
                            <%--<colgroup>--%>
                                <%--<col style='width:auto;'>--%>
                                <%--<col style='width:15%;'>--%>
                                <%--<col style='width:15%;'>--%>
                                <%--<col style='width:8%;'>--%>
                                <%--<col style='width:8%;'>--%>
                                <%--<col style='width:20%;'>--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--<tr id="noResultAreaForPods"><td colspan='6'><p class='service_p'>조회 된 Pod가 없습니다.</p></td></tr>--%>
                            <%--<tr id="resultHeaderAreaForPods" class="headerSortFalse" style="display: none;">--%>
                                <%--<td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>--%>
                                <%--<td>Namespace</td>--%>
                                <%--<td>Node</td>--%>
                                <%--<td>Status</td>--%>
                                <%--<td>Restarts</td>--%>
                                <%--<td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody id="resultAreaForPods">--%>
                            <%--<tr>--%>
                                <%--<td colspan="6"> - </td>--%>
                            <%--</tr>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </li>
            <li class="cluster_fourth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Endpoints</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="noResultAreaForEndpoints"><td colspan='4'><p class='service_p'>조회 된 Endpoints가 없습니다.</p></td></tr>
                            <tr id="resultHeaderAreaForEndpoints" style="display: none;">
                                <td>Host</td>
                                <td>Ports (Name, Port, Protocol)</td>
                                <td>Node</td>
                                <td>Ready</td>
                            </tr>
                            </thead>
                            <tbody id="resultAreaForEndpoints">
                            <tr>
                                <td colspan="4"> - </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Services Details 끝 -->
</div>
<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />


<script type="text/javascript">

    // GET DETAIL
    var getDetail = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_SERVICES_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{serviceName:.+}", document.getElementById('requestServiceName').value);
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            viewLoading('hide');
            return false;
        }

        var selector,
            specPortsList,
            specPortsListLength;

        var serviceName = data.metadata.name;
        var namespace = data.metadata.namespace;
        var namespaceHtml = "<a href='javascript:void(0);'data-toggle='tooltip' title='" + namespace + "' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NAMESPACES %>/" + namespace + "\");'>" + namespace  + "</a>";
        var endpointsPreString = serviceName + "." + namespace + ":";
        var nodePort = data.spec.ports.nodePort;
        var endpoints = "";
        var selectorString;

        if (nodePort === undefined) {
            nodePort = "0";
        }

        specPortsList = data.spec.ports;
        specPortsListLength = specPortsList.length;

        for (var i = 0; i < specPortsListLength; i++) {
            endpoints += '<p>' + endpointsPreString + specPortsList[i].port + " " + specPortsList[i].protocol + '</p>'
                + '<p>' + endpointsPreString + nodePort + " " + specPortsList[i].protocol + '</p>';
        }

        selector = procSetSelector(data.spec.selector);
        selectorString = selector;

        if (selector === false) {
            selectorString = '-';
        }

        $('.resultServiceName').html(serviceName);
        $('#resultNamespace').html(namespaceHtml);
        $('#resultCreationTimestamp').html(data.metadata.creationTimestamp);
        $('#resultLabelSelector').html(selectorString);
        $('#resultType').html(data.spec.type);
        $('#resultSessionAffinity').html(data.spec.sessionAffinity);
        $('#resultClusterIp').html(data.spec.clusterIP);
        $('#InternalEndpointsArea').html(endpoints);

        viewLoading('hide');
        getDetailForPodsList(selector);
    };


    // GET DETAIL FOR PODS LIST
    var getDetailForPodsList = function(selector) {

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{serviceName:.+}", "_all")
            .replace("{selector:.+}", selector);

        getPodListUsingRequestURL(reqUrl);
        getDetailForEndpoints();
        /*TODO :: REMOVE*/
        <%--var podListReqUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + NAME_SPACE + "/pods/node/" + nodeName;--%>
        // getPodListUsingRequestURL(podListReqUrl);

        // TODO :: CHECK GETTING PODS LIST URL
        <%--viewLoading('show');--%>

        <%--var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE %>"--%>
            <%--.replace("{namespace:.+}", NAME_SPACE)--%>
            <%--.replace("{serviceName:.+}", "_all")--%>
            <%--.replace("{selector:.+}", selector);--%>

        <%--procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPodsList);--%>
    };


    // CALLBACK
    var callbackGetDetailForPodsList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            viewLoading('hide');
            return false;
        }

        gList = data;
        viewLoading('hide');

        setPodsList("");
    };


    // SET PODS LIST
    var setPodsList = function(searchKeyword) {
        viewLoading('show');

        var podName,
            itemsMetadata,
            itemsStatus;

        var items = gList.items;
        var listLength = items.length;
        var checkListCount = 0;
        var podNameList = [];
        var htmlString = [];

        var resultArea = $('#resultAreaForPods');
        var resultHeaderArea = $('#resultHeaderAreaForPods');
        var noResultArea = $('#noResultAreaForPods');
        var resultTable = $('#resultTable');

        for (var i = 0; i < listLength; i++) {
            podName = items[i].metadata.name;

            if ((nvl(searchKeyword) === "") || podName.indexOf(searchKeyword) > -1) {
                itemsMetadata = items[i].metadata;
                itemsStatus = items[i].status;

                htmlString.push(
                    "<tr>"
                    + "<td id='" + podName + "'></td>"
                    + "<td>" + itemsMetadata.namespace + "</td>"
                    + "<td>" + items[i].spec.nodeName + "</td>"
                    + "<td>" + itemsStatus.phase + "</td>"
                    + "<td>" + itemsStatus.containerStatuses[0].restartCount + "</td>"
                    + "<td>" + itemsMetadata.creationTimestamp + "</td>"
                    + "</tr>");

                checkListCount++;
            }

            podNameList.push(podName);
        }

        if (listLength < 1 || checkListCount < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
            resultTable.tablesorter();
            resultTable.trigger("update");
            $('.headerSortFalse > td').unbind();
        }

        viewLoading('hide');

        procSetEventStatusForPods(podNameList);
        getDetailForEndpoints();
    };


    // GET DETAIL FOR ENDPOINTS
    var getDetailForEndpoints = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_ENDPOINTS_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{serviceName:.+}", document.getElementById('requestServiceName').value);
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForEndpoints);
    };


    // CALLBACK
    var callbackGetDetailForEndpoints = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            viewLoading('hide');
            return false;
        }

        var addresses,
            ports,
            addressesListLength,
            portsListLength,
            nodeName;

        var items = data.subsets;
        var subsetsListLength = 0;
        var portsString = '';
        var separatorString = ", ";
        var checkCount = 0;
        var nodeNameList = [];
        var htmlString = [];

        var resultArea = $('#resultAreaForEndpoints');
        var resultHeaderArea = $('#resultHeaderAreaForEndpoints');
        var noResultArea = $('#noResultAreaForEndpoints');

        if (items === null) {
            checkCount++;
        } else {
            subsetsListLength = items.length;
        }

        for (var i = 0; i < subsetsListLength; i++) {
            addresses = items[i].addresses;
            ports = items[i].ports;

            if (addresses === null || ports === null ) {
                checkCount++;
            } else {
                addressesListLength = addresses.length;
                portsListLength = ports.length;

                for (var j = 0; j < addressesListLength; j++) {
                    nodeName = nvl2(addresses[j].nodeName, '-');

                    for (var k = 0; k < portsListLength; k++) {
                        var portName =  ports[k].name;
                        var portNameString =  "[-]";

                        if (portName !== null) {
                            portNameString = portName;
                        }

                        portsString += '<p>' + portNameString + separatorString + ports[k].port + separatorString + ports[k].protocol + '</p>';
                    }

                    htmlString.push(
                        "<tr>"
                            + "<td>" + addresses[j].ip + "</td>"
                            + "<td>" + portsString + "</td>"
                            + "<td>"
                            + "<a href='javascript:void(0);'data-toggle='tooltip' title='" + nodeName+ "' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NODES %>/" + nodeName + "/summary\");'>" + nodeName + "</a>"
                            + "</td>"
                            + "<td><span class='" + nodeName + "'>true</span></td>"
                            + "</tr>");

                    portsString = '';

                    if (nodeName !== '-') {
                        nodeNameList.push(nodeName)
                    }
                }
            }
        }

        if (subsetsListLength < 1 || checkCount > 0) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
            getDetailForNodes(nodeNameList);
        }

        viewLoading('hide');
    };


    // GET DETAIL FOR NODES
    var getDetailForNodes = function(nodeNameList) {
        var listLength = nodeNameList.length;
        var reqUrl;

        for (var i = 0; i < listLength; i++) {
            if (nodeNameList[i] !== '-') {
                viewLoading('show');

                reqUrl = "<%= Constants.API_URL %>/nodes/" + nodeNameList[i];
                procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForNodes);
            }
        }
    };


    // CALLBACK
    var callbackGetDetailForNodes = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            viewLoading('hide');
            return false;
        }

        var items = data.status.conditions;
        var conditionsListLength = items.length;

        for (var i = 0; i < conditionsListLength; i++) {
            if (items[i].type === "Ready") {
                $('.' + data.metadata.name).text(items[i].status);
            }
        }

        viewLoading('hide');
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
