<%--
  Services main
  @author REX
  @version 1.0
  @since 2018.08.09
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <!-- Overview 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <!-- Deployments 시작 -->
            <li class="cluster_first_box"><!--cluster_second_box-->
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Deployments</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL" id="resultTableForDev">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultAreaForDev" style="display: none;"><td colspan='6'><p class='service_p'>실행 중인 Deployments가 없습니다.</p></td></tr>
                            <tr id="resultHeaderAreaForDev">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTableForDev', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTableForDev', this, '4')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody id="deploymentsListArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Deployments 끝 -->

            <!-- modal TODO :: 사용확인 후 삭제 -->
            <div class="modal fade dashboard" id="layerpop">
                <div class="vertical-alignment-helper">
                    <div class="modal-dialog vertical-align-center">
                    </div>
                </div>
            </div>
            <!-- modal 끝 TODO :: 사용확인 후 삭제 -->

            <!-- Pods 시작 -->
            <li class="cluster_second_box">
                <jsp:include page="../pods/list.jsp" flush="true"/>
            </li>
            <!-- Pods 끝 -->

            <!-- Replica Sets 시작 -->
            <li class="cluster_fourth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Replica Sets</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL" id="resultTableForReplicaSet">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultAreaForReplicaSet" style="display: none;"><td colspan='6'><p class='service_p'>실행 중인 Service가 없습니다.</p></td></tr>
                            <tr id="resultHeaderAreaForReplicaSet">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '4')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody id="resultAreaForReplicaSet">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Replica Sets 끝 -->
        </ul>
    </div>
    <!-- Overview 끝 -->

</div>

<%--<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>--%>
<script type="text/javascript">
    var gDevList; // For Deployment List
    var gReplicaSetList; // For ReplicaSet List

    // ***** For Deployment *****
    // GET LIST
    var getDevList = function() {
        viewLoading('show');
        //procCallAjax("/api/namespaces/" + NAME_SPACE + "/replicasets", "GET", null, null, callbackGetDevList);
        procCallAjax("/workloads/deployments/" + NAME_SPACE, "GET", null, null, callbackGetDevList);
    };


    // CALLBACK
    var callbackGetDevList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        gDevList = data;
        setDevList();
        viewLoading('hide');
    };


    // SET LIST
    var setDevList = function() {

        var listLength       = gDevList.items.length;
        var resultArea       = $('#deploymentsListArea');
        var resultHeaderArea = $('#resultHeaderAreaForDev');
        var noResultArea     = $('#noResultAreaForDev');
        var resultTable      = $('#resultTableForDev');

        $.each(gDevList.items, function (index, itemList) {
            // get data
            var metadata = itemList.metadata;
            var spec = itemList.spec;
            var status = itemList.status;

            var deployName = metadata.name;
            var namespace = metadata.namespace;
            var labels = stringifyJSON(metadata.labels).replace(/,/g, ', ');
            if (labels == null || labels == "null") {
                labels = null;
            }

            var creationTimestamp = metadata.creationTimestamp;

            // Set replicas and total Pods are same.
            var totalPods = spec.replicas;
            var runningPods = totalPods - status.unavailableReplicas;
            // var failPods = _status.unavailableReplicas;
            var images = new Array;
            var containers = spec.template.spec.containers;

            for(var i=0; i < containers.length; i++){
                images.push(containers[i].image);
            }

            resultArea.append('<tr>' +
                    '<td><span class="green2"><i class="fas fa-check-circle"></i></span> ' +
                    "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/workloads/deployments/" + deployName + "\");'>"+deployName+'</a>' +
                    '</td>' +
                    '<td>' + namespace + '</td>' +
                    '<td>' + createSpans(labels, "true") + '</td>' +
                    '<td>' + runningPods +" / " + totalPods + '</td>' +
                    '<td>' + creationTimestamp + '</td>' +
                    '<td>' + images.join("<br>") + '</td>' +
                    '</td>');
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
        }

    };

    // ***** For Pods *****
    // GET LIST
    var getPodsList = function() {
        viewLoading('show');
        var reqUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + NAME_SPACE + "/pods";
        getPodListUsingRequestURL(reqUrl);
        viewLoading('hide');
    };

    // ***** For ReplicaSet *****
    // GET LIST
    var getReplicaSetList = function() {
        viewLoading('show');
        procCallAjax("<%= Constants.API_URL %>/namespaces/" + NAME_SPACE + "/replicasets", "GET", null, null, callbackGetReplicaSetList);
    };


    // CALLBACK
    var callbackGetReplicaSetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        gReplicaSetList = data;
        setReplicaSetList();
        viewLoading('hide');
    };


    // SET LIST
    var setReplicaSetList = function() {

        var resultArea       = $('#resultAreaForReplicaSet');
        var resultHeaderArea = $('#resultHeaderAreaForReplicaSet');
        var noResultArea     = $('#noResultAreaForReplicaSet');
        var resultTable      = $('#resultTableForReplicaSet');

        var items = gReplicaSetList.items;
        var listLength = items.length;

        $.each(items, function (index, itemList) {

            var replicaSetName = itemList.metadata.name;
            var namespace = itemList.metadata.namespace;
            var labels = procSetSelector(itemList.metadata.labels);
            var creationTimestamp = itemList.metadata.creationTimestamp;
            var pods = itemList.status.availableReplicas +"/"+ itemList.spec.replicas;  // current / desired
            //var selector = procSetSelector(items[i].spec.selector);
            var images = new Array;

            var containers = itemList.spec.template.spec.containers;
            for(var i=0; i < containers.length; i++){
                images.push(containers[i].image);
            }

            resultArea.append(
                    "<tr>"
                    + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                    + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/workloads/replicaSets/" + replicaSetName + "\");'>" + replicaSetName + "</a>"
                    + "</td>"
                    + "<td>" + namespace + "</td>"
                    + "<td>" + createSpans(labels, "LB") + "</td>"
                    + "<td>" + pods + "</td>"
                    + "<td>" + creationTimestamp+"</td>"
                    + "<td>" + images.join("</br>") + "</td>"
                    + "</tr>");
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
        }

    };



    // TODO :: 업데이트(복수값일시 레이어 링크 제공) 및 공통화 필요
    var createSpans = function (data, type) {
        if( !data ) {
            return "-";
        }
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
        viewLoading('show');
        getDevList();
        getPodsList();
        getReplicaSetList();
        viewLoading('hide');
    });

</script>