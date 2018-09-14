<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  Replicaset main
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <c:out value="${replicaSetName}"/></h1>
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <!-- Details 시작 -->
            <li class="cluster_first_box"><!-- TODO :: 차트 추가시 cluster_second_box 로 변경-->
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
                                <td id="resultLabel"><span class="bg_gray"></span> <span class="bg_gray"></span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="resultAnnotation">
                                    <span class="bg_gray"></span>
                                    <span class="bg_blue"><a href="#" target="_blank"></a></span>
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
                                <td id="resultDeployment"><a href="#"></a></td><!-- heapster-v1.5.2 -->
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Pods 시작 -->
            <li class="cluster_third_box">
                <jsp:include page="../pods/list.jsp" flush="true"/>
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
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Service Type</td>
                                <td>Cluster IP</td>
                                <td>Endpoints</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '5')"><i class="fas fa-caret-down"></i></button></td>
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

    var namespace = NAME_SPACE;
    //namespace = 'default';

    var selector = "";
    var replicaSetName = '<c:out value="${replicaSetName}"/>';

    // GET DETAIL
    var getDetail = function() {
        var reqUrl = "<%= Constants.API_URL %>/namespaces/" + namespace + "/replicasets/" + replicaSetName;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var replicaSetName      = data.metadata.name;
        var namespace           = data.metadata.namespace;
        var labels              = JSON.stringify(data.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
        var annotations         = JSON.stringify(data.metadata.annotations).replace(/["{}]/g, '').replace(/:/g, '=');
        var creationTimestamp   = data.metadata.creationTimestamp;
        var selector            = procSetSelector(data.spec.selector.matchLabels);
        //var replicas            = data.status.replicas+" / "+data.status.replicas;   //  TOBE ::  current / desired
        var images              = new Array;
        //var deployment          = "";

        var containers = data.spec.template.spec.containers;
        for(var i=0; i < containers.length; i++){
            images.push(containers[i].image);
        }

        $('#resultResourceName').html(replicaSetName);
        $('#resultNamespace').html(namespace);
        $('#resultLabel').html(createSpans(labels));
        $('#resultAnnotation').html(createSpans(annotations));
        $('#resultCreationTimestamp').html(creationTimestamp);
        $('#resultSelector').html(createSpans(selector));
        $('#resultImage').html(images.join("<br>"));
        //$('#resultPods').html(replicas);
        $('#resultPods').html(data.status.availableReplicas+" running");
        //$('#resultDeployment').html(deployment);

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

        var reqUrl = "<%= Constants.API_URL %>/namespaces/" + namespace + "/deployments/resource/" + selector;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDeploymentsInfo);
    };

    // CALLBACK
    var callbackGetDeploymentsInfo = function(data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var deploymentsInfo;

        if(data.items.length > 0){

            var deploymentsName = data.items[0].metadata.name;

            console.log("deploymentsName:::"+deploymentsName);
                deploymentsInfo = "<a href='/caas/workloads/deployments/"+deploymentsName+"'>"+deploymentsName+"</a>";
        }else{
            deploymentsInfo = "-";
        }

        $('#resultDeployment').append(deploymentsInfo);

    };

    // GET DETAIL FOR PODS LIST
    var getDetailForPodsList = function(selector) {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR %>".replace("{namespace:.+}", namespace).replace("{selector:.+}", selector);
        //procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPodsList);
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

        var reqUrl = "<%= Constants.API_URL %>/namespaces/" + namespace + "/services/resource/" + selector;
        procCallAjax(reqUrl, "GET", null, null, callbackGetServices);
    };


    // CALLBACK
    var callbackGetServices = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

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

        // REF
        // service.namespace:port protocol
        // service.namespace:nodePort protocol -> service.namespace:0 protocol

        for (var i = 0; i < listLength; i++) {
            serviceName = items[i].metadata.name;

            selector = procSetSelector(items[i].spec.selector);
            endpointsPreString = serviceName + "." + items[i].metadata.namespace + ":";
            nodePort = items[i].spec.ports.nodePort;

            if (nodePort === undefined) {
                nodePort = "0";
            }

            specPortsList = items[i].spec.ports;
            specPortsListLength = specPortsList.length;

            for (var j = 0; j < specPortsListLength; j++) {
                endpoints += '<p>' + endpointsPreString + specPortsList[j].port + " " + specPortsList[j].protocol + '</p>'
                        + '<p>' + endpointsPreString + nodePort + " " + specPortsList[j].protocol + '</p>';
            }

            htmlString.push(
                    "<tr>"
                    + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                    + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/services/" + serviceName + "\");'>" + serviceName + "</a>"
                    + "</td>"
                    + "<td>" + items[i].spec.type + "</td>"
                    + "<td>" + items[i].spec.clusterIP + "</td>"
                    + "<td>" + endpoints + "</td>"
                    + "<td>" + "<span id='" + serviceName + "'></span></td>"
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
            resultTable.tablesorter();
            resultTable.trigger("update");
        }

        getDetailForPods(selectorList);

    };

    // GET DETAIL FOR PODS
    var getDetailForPods = function(selectorList) {
        var listLength = selectorList.length;
        var tempSelectorList;
        var reqUrl;

        for (var i = 0; i < listLength; i++) {
            tempSelectorList = selectorList[i].split(",");
            reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE %>"
                    .replace("{namespace:.+}", NAME_SPACE)
                    .replace("{serviceName:.+}", tempSelectorList[1])
                    .replace("{selector:.+}", tempSelectorList[0]);

            procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPods);
        }
    };


    // CALLBACK
    var callbackGetDetailForPods = function(data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            return false;
        }

        var items = data.items;
        var listLength = items.length;
        var runningSum = 0;
        var totalSum = 0;

        for (var i = 0; i < listLength; i++) {
            if (items[i].status.phase.toLowerCase() === "running") {
                runningSum++
            }
            totalSum++;
        }

        $('#' + data.serviceName).html(runningSum + " / " + totalSum);
    };

    var createSpans = function (data, type) {
        var datas = data.replace(/=/g, ':').split(',');
        var spanTemplate = "";

        if (type === "LB") { // Line Break
            $.each(datas, function (index, data) {
                if (index != 0) {
                    spanTemplate += '<br>';
                }
                spanTemplate += '<span class="bg_gray">' + data + '</span>';
            });
        } else {
            $.each(datas, function (index, data) {
                spanTemplate += '<span class="bg_gray">' + data + '</span> ';
            });
        }

        return spanTemplate;
    }

    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>