<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%--
  ReplicaSet detail
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <c:out value="${replicaSetName}"/></h1>
    <jsp:include page="../common/contentsTab.jsp"/>
    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <!-- Details 시작 -->
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Details</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style="">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td id="resultResourceName"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td id="resultNamespace"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td id="resultLabel" class="labels_wrap">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="resultAnnotation" class="labels_wrap">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="resultCreationTimestamp"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Selector</th>
                                <td id="resultSelector"><span class="bg_gray"></span></td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Image</th>
                                <td id="resultImage"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Pods</th>
                                <td id="resultPods"></td><!-- 3 running -->
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Managing deployment</th>
                                <td id="resultDeployment"><a href="#"></a></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Pods 시작 -->
            <li class="cluster_third_box">
                <jsp:include page="../pods/list.jsp"/>
            </li>
            <!-- Pods 끝 -->
            <!-- Services 시작 -->
            <li class="cluster_fourth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Services</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh" id="resultTableForServices">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:15%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultAreaForServices" style="display: none;"><td colspan='6'><p class='service_p'>실행 중인 Service가 없습니다.</p></td></tr>
                            <tr id="resultHeaderAreaForService">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTableForServices', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Labels</td>
                                <td>Cluster IP</td>
                                <td>Internal endpoints</td>
                                <td>External endpoints</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTableForServices', this, '5')"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody id="resultAreaForService">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Services 끝 -->
        </ul>
    </div>
</div>
<script type="text/javascript">

    // GET DETAIL
    var getDetail = function() {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_REPLICA_SETS_DETAIL%>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{replicaSetName:.+}", '<c:out value="${replicaSetName}"/>');
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };

    // CALLBACK
    var callbackGetDetail = function(data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            return false;
        }

        var replicaSetName      = data.metadata.name;
        var namespace           = data.metadata.namespace;
        var labels              = procSetSelector(data.metadata.labels);
        var annotations         = procSetSelector(data.metadata.annotations);
        var creationTimestamp   = data.metadata.creationTimestamp;
        var selector            = procSetSelector(data.spec.selector.matchLabels);
        var images              = [];

        var containers = data.spec.template.spec.containers;
        for(var i=0; i < containers.length; i++){
            images.push(containers[i].image);
        }

        $('#resultResourceName').html(replicaSetName);
        $('#resultNamespace').html(namespace);
        $('#resultLabel').html(procCreateSpans(labels));
        $('#resultAnnotation').html(procCreateSpans(annotations));
        $('#resultCreationTimestamp').html(creationTimestamp);
        $('#resultSelector').html(procCreateSpans(selector));
        $('#resultImage').html(images.join("<br>"));
        $('#resultPods').html(data.status.availableReplicas+" running");

        getDeploymentsInfo(data.metadata.labels);
        getDetailForPodsList(selector);
        getServices(data.metadata.labels);
    };

    // GET DEPLOYMENTS INFO
    var getDeploymentsInfo = function(selector) {

        if(selector["pod-template-hash"] !== undefined){
            delete selector["pod-template-hash"];
        }

        selector = procSetSelector(selector);

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_DEPLOYMENTS_RESOURCES %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{selector:.+}", selector);
        procCallAjax(reqUrl, "GET", null, null, callbackGetDeploymentsInfo);
    };

    // CALLBACK
    var callbackGetDeploymentsInfo = function(data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            return false;
        }

        var deploymentsInfo;

        if(data.items.length > 0){
            var deploymentsName = data.items[0].metadata.name;

            deploymentsInfo = "<a href='<%= Constants.URI_WORKLOAD_DEPLOYMENTS %>/"+deploymentsName+"'>"+deploymentsName+"</a>";
        }else{
            deploymentsInfo = "-";
        }

        $('#resultDeployment').append(deploymentsInfo);

    };

    // GET DETAIL FOR PODS LIST
    var getDetailForPodsList = function(selector) {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{selector:.+}", selector);
        getPodListUsingRequestURL(reqUrl);
    };

    // GET SERVICE LIST
    var getServices = function(selector) {
        /* Replicaset 생성시 추가되는 "pod-template-hash" 레이블은 service 레이블에 생성되지 않는다.
            - service, deployment 레이블 조회시 => 필터링 조건에서 "pod-template-hash" 레이블은 제외한다.
            - pods 레이블 조회시 =>  필터링 조건에서 "pod-template-hash" 레이블 포함함.
         */
        if(selector["pod-template-hash"] !== undefined){
            delete selector["pod-template-hash"];
        }

        selector = procSetSelector(selector);

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_SERVICES_RESOURCES %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{selector:.+}", selector);
        procCallAjax(reqUrl, "GET", null, null, callbackGetServices);
    };


    // CALLBACK
    var callbackGetServices = function(data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            return false;
        }

        var serviceName,
            selector,
            endpointsPreString,
            nodePort,
            specPortsList,
            specPortsListLength;

        var resultArea       = $('#resultAreaForService');
        var resultHeaderArea = $('#resultHeaderAreaForService');
        var noResultArea     = $('#noResultAreaForServices');
        var resultTable      = $('#resultTableForServices');

        var items = data.items;
        var listLength = items.length;
        var endpoints = "";
        var selectorList = [];
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            serviceName = items[i].metadata.name;
            selector = procSetSelector(items[i].spec.selector);
            endpointsPreString = serviceName + "." + items[i].metadata.namespace + ":";
            nodePort = items[i].spec.ports.nodePort;

            var labels = procSetSelector(items[i].metadata.labels);

            if (nodePort === undefined) {
                nodePort = "0";
            }

            specPortsList = items[i].spec.ports;
            specPortsListLength = specPortsList.length;

            for (var j = 0; j < specPortsListLength; j++) {
                endpoints += '<p>' + endpointsPreString + specPortsList[j].port + " " + specPortsList[j].protocol + '</p>'
                        + '<p>' + endpointsPreString + nodePort + " " + specPortsList[j].protocol + '</p>';
            }

            //External Endpoints
            var externalEndpoints = [];
            externalEndpoints = items[i].spec.externalIPs;

            if( (externalEndpoints != null) && (externalEndpoints.length > 0) ){
                externalEndpoints = externalEndpoints.join('</BR>')
            }else{
                externalEndpoints = "-";
            }

            htmlString.push(
                    "<tr>"
                    + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                    + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/services/"
                    + serviceName + "\");'>" + serviceName + "</a>"
                    + "</td>"
                    + "<td>" + procCreateSpans(labels, "LB") + "</td>"
                    + "<td>" + items[i].spec.clusterIP + "</td>"
                    + "<td>" + endpoints + "</td>"
                    + "<td>" + externalEndpoints + "</td>"
                    + "<td>" + items[i].metadata.creationTimestamp + "</td>"
                    + "</tr>");

            selectorList.push(selector + "," + serviceName);
            endpoints = "";

        }

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);

            resultTable.tablesorter({
                sortList: [[5, 1]] // 0 = ASC, 1 = DESC
            });

            resultTable.trigger("update");
        }

        procSetToolTipForTableTd('resultAreaForService');
        viewLoading('hide');

    };

    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>