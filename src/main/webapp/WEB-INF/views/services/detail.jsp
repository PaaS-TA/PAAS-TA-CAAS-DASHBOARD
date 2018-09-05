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
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on custom_cursor_default">Details</li>
            <li name="tab02" class="cluster_tabs_right" onclick='movePage("events");'>Events</li>
            <li name="tab03" class="cluster_tabs_right" onclick='movePage("yaml");'>YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Services Details 시작 -->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT10">
        <%--<ul class="maT30">--%>
            <!-- 그래프 시작 -->
            <%--<li class="cluster_first_box">--%>
                <%--<div class="graph-legend-wrap clearfix">--%>
                    <%--<ul class="graph-legend">--%>
                        <%--<li rel="current" class="on">현재</li>--%>
                        <%--<li rel="1h">1시간</li>--%>
                        <%--<li rel="6h">6시간</li>--%>
                        <%--<li rel="1d">1일</li>--%>
                        <%--<li rel="7d">7일</li>--%>
                        <%--<li rel="30d">30일</li>--%>
                    <%--</ul>--%>
                <%--</div>--%>

                <%--TODO :: CHECK--%>
                <%--<div class="custom-col-md-3">
                    <div class="col-in col-in-bg" id="cpu">
                        <dl>
                            <dt class="tit">CPU
                                <span class="pull-right rights">0.38</span>
                            </dt>
                            <dd><span>0.38</span><i>%</i><small> / 100%</small>
                                <div class="pull-right">
                                    <div class="icon_wrap">
                                        <img alt="" src="<c:url value="/resources/images/custom-caas/cpu_ico.png"/>">
                                    </div>
                                    <div class="BG_wrap" style="top: -0.38%;">
                                        <img alt="" src="<c:url value="/resources/images/custom-caas/ico_bg.png"/>">
                                        <input id="cpuPer" value="20" title="">
                                    </div>
                                </div>
                            </dd>
                            <dt>
                                <ul class="instance_ul">
                                </ul>
                            </dt>
                        </dl>
                    </div>
                </div>
                <div class="custom-col-md-3">
                    <div class="col-in col-in-bg" id="memory">
                        <dl>
                            <dt class="tit">MEMORY
                                <span class="pull-right rights">60</span>
                            </dt>
                            <dd>
                                <span class="memS" id="memS1">512</span>
                                <span class="memS" id="memS2" style="display:none;"><input class="instance_in" id="mem_in" style="font-size: 40px;" type="text" title=""></span>
                                <i>M</i><small> / 최대 10G</small>
                                <div class="pull-right">
                                    <div class="icon_wrap">
                                        <img alt="" src="<c:url value="/resources/images/custom-caas/memory_ico.png"/>">
                                    </div>
                                    <div class="BG_wrap" style="top: -60%;">
                                        <img alt="" src="<c:url value="/resources/images/custom-caas/ico_bg.png"/>">
                                        <input id="memoryPer" value="40" title="">
                                    </div>
                                </div>
                            </dd>
                            <dt>
                                <ul class="instance_ul">
                                </ul>
                            </dt>
                        </dl>
                    </div>
                </div>
                <div class="custom-col-md-3">
                    <div class="col-in col-in-bg" id="disk">
                        <dl>
                            <dt class="tit">DISK
                                <span class="pull-right rights">15</span>
                            </dt>
                            <dd>
                                <span class="diskS" id="diskS1">1</span>
                                <span class="diskS" id="diskS2" style="display:none;"><input class="instance_in" id="disk_in" style="font-size: 40px;" type="text" title=""></span>
                                <i>G</i><small> / 최대 10G</small>
                                <div class="pull-right">
                                    <div class="icon_wrap">
                                        <img alt="" src="<c:url value="/resources/images/custom-caas/disk_ico.png"/>">
                                    </div>
                                    <div class="BG_wrap" style="top: -15%;">
                                        <img alt="" src="<c:url value="/resources/images/custom-caas/ico_bg.png"/>">
                                        <input id="diskPer" value="60" title="">
                                    </div>
                                </div>
                            </dd>
                            <dt>
                                <ul class="instance_ul">
                                </ul>
                            </dt>
                        </dl>
                    </div>
                </div>--%>

                <%--<div class="graph-nodes">--%>
                    <%--<div class="graph-tit-wrap">--%>
                        <%--<p class="graph-tit">--%>
                            <%--CPU<br/>--%>
                            <%--현재 사용량--%>
                        <%--</p>--%>
                        <%--<p class="graph-rate tit-color1">--%>
                            <%--<span>60</span>%--%>
                        <%--</p>--%>
                    <%--</div>--%>
                    <%--<div class="graph-cnt">--%>
                        <%--<div id="areachartcpu" style="min-width: 250px; height: 170px; margin: 0 auto"></div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="graph-nodes">--%>
                    <%--<div class="graph-tit-wrap">--%>
                        <%--<p class="graph-tit">--%>
                            <%--메모리<br/>--%>
                            <%--현재 사용량--%>
                        <%--</p>--%>
                        <%--<p class="graph-rate tit-color2">--%>
                            <%--<span>60</span>%--%>
                        <%--</p>--%>
                    <%--</div>--%>
                    <%--<div class="graph-cnt">--%>
                        <%--<div id="areachartmem" style="min-width: 250px; height: 170px; margin: 0 auto"></div>--%>
                    <%--</div>--%>
                <%--</div>--%>

                <%--<div class="graph-nodes">--%>
                    <%--<div class="graph-tit-wrap">--%>
                        <%--<p class="graph-tit">--%>
                            <%--디스크<br/>--%>
                            <%--현재 사용량--%>
                        <%--</p>--%>
                        <%--<p class="graph-rate tit-color3">--%>
                            <%--<span>60</span>%--%>
                        <%--</p>--%>
                    <%--</div>--%>
                    <%--<div class="graph-cnt">--%>
                        <%--<div id="areachartdisk" style="min-width: 250px; height: 170px; margin: 0 auto"></div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <!-- 그래프 끝 -->
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
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" onkeypress="if(event.keyCode===13) {setPodsList(this.value);}" />
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh" id="resultTable">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:15%;'>
                                <col style='width:15%;'>
                                <col style='width:8%;'>
                                <col style='width:8%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultAreaForPods"><td colspan='6'><p class='service_p'>조회 된 Pod가 없습니다.</p></td></tr>
                            <tr id="resultHeaderAreaForPods" style="display: none;">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody id="resultAreaForPods">
                            <tr>
                                <td colspan="6"> - </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
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
                            <tr>
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
<%--TODO--%>
<!-- modal -->


<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />


<%--TODO : REMOVE--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>--%>

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function () {
        // createChart("current", "cpu");
        // createChart("current", "mem");
        // createChart("current", "disk");
    });
</script>


<script type="text/javascript">

    // TODO :: REMOVE
    var tempNamespace = "<%= Constants.NAMESPACE_NAME %>";

    // GET DETAIL
    var getDetail = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %>/namespaces/" + tempNamespace + "/services/" + document.getElementById('requestServiceName').value;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var selector,
            specPortsList,
            specPortsListLength;

        var serviceName = data.metadata.name;
        var namespace = data.metadata.namespace;
        var endpointsPreString = serviceName + "." + namespace + ":";
        var nodePort = data.spec.ports.nodePort;
        var endpoints = "";

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

        $('.resultServiceName').html(serviceName);
        $('#resultNamespace').html(namespace);
        $('#resultCreationTimestamp').html(data.metadata.creationTimestamp);
        $('#resultLabelSelector').html(selector);
        $('#resultType').html(data.spec.type);
        $('#resultSessionAffinity').html(data.spec.sessionAffinity);
        $('#resultClusterIp').html(data.spec.clusterIP);
        $('#InternalEndpointsArea').html(endpoints);

        getDetailForPodsList(selector);
    };


    // GET DETAIL FOR PODS LIST
    var getDetailForPodsList = function(selector) {
        // TODO :: CHECK GETTING PODS LIST URL
        var reqUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + tempNamespace + "/pods/service/_all/" + selector;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPodsList);
    };


    // CALLBACK
    var callbackGetDetailForPodsList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            viewLoading('hide');
            return false;
        }

        gList = data;
        setPodsList("");
    };


    // SET PODS LIST
    var setPodsList = function(searchKeyword) {
        var podName,
            itemsMetadata,
            itemsStatus;

        var items = gList.items;
        var listLength = items.length;
        var checkListCount = 0;
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

                // TODO :: SET LINK TO PODS DETAIL PAGE
                htmlString.push(
                    "<tr>"
                    + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                    + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/workloads/pods/" + podName + "\");'>" + podName + "</a>"
                    + "</td>"
                    + "<td>" + itemsMetadata.namespace + "</td>"
                    + "<td>" + items[i].spec.nodeName + "</td>"
                    + "<td>" + itemsStatus.phase + "</td>"
                    + "<td>" + itemsStatus.containerStatuses[0].restartCount + "</td>"
                    + "<td>" + itemsMetadata.creationTimestamp + "</td>"
                    + "</tr>");

                checkListCount++;
            }
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
        }

        getDetailForEndpoints();
    };


    // GET DETAIL FOR ENDPOINTS
    var getDetailForEndpoints = function() {
        var reqUrl = "<%= Constants.API_URL %>/namespaces/" + tempNamespace + "/endpoints/" + document.getElementById('requestServiceName').value;
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
        var subsetsListLength = items.length;
        var portsString = '';
        var separatorString = ", ";
        var nodeNameList = [];
        var htmlString = [];

        for (var i = 0; i < subsetsListLength; i++) {
            addresses = items[i].addresses;
            ports = items[i].ports;
            addressesListLength = addresses.length;
            portsListLength = ports.length;

            for (var j = 0; j < addressesListLength; j++) {
                nodeName = addresses[j].nodeName;

                for (var k = 0; k < portsListLength; k++) {
                    var portName =  ports[k].name;
                    var portNameString =  "[unset]";

                    if (portName !== null) {
                        portNameString = portName;
                    }

                    portsString += '<p>' + portNameString + separatorString + ports[k].port + separatorString + ports[k].protocol + '</p>';
                }

                htmlString.push(
                    "<tr>"
                    + "<td>" + addresses[j].ip + "</td>"
                    + "<td>" + portsString + "</td>"
                    + "<td>" + nodeName + "</td>"
                    + "<td><span class='" + nodeName + "'></span></td>"
                    + "</tr>");

                portsString = '';
                nodeNameList.push(nodeName)
            }
        }

        $('#resultAreaForEndpoints').html(htmlString);
        getDetailForNodes(nodeNameList);
    };


    // GET DETAIL FOR NODES
    var getDetailForNodes = function(nodeNameList) {
        var listLength = nodeNameList.length;
        var reqUrl;

        for (var i = 0; i < listLength; i++) {
            reqUrl = "<%= Constants.API_URL %>/nodes/" + nodeNameList[i];
            procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForNodes);
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


    // MOVE PAGE
    var movePage = function(requestPage) {
        var reqUrl = '<%= Constants.CAAS_BASE_URL %>/services/' + document.getElementById('requestServiceName').value;

        if (requestPage.indexOf('detail') < 0) {
            reqUrl += '/' + requestPage;
        }

        procMovePage(reqUrl);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
