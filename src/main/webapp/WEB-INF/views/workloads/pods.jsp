<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  /caas/workloads/pods page
  User: hgcho
  Date: 2018-08-30
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">
    <%-- WORKLOADS HEADER INCLUDE --%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <!-- Pods 시작 -->
    <div class="cluster_content03 row two_line two_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL" id="pods_table_in_workloads">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:15%;'>
                                <col style='width:15%;'>
                                <col style='width:8%;'>
                                <col style='width:8%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button sort-key="pod-name" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on<button sort-key="created-on" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody><%-- tbody content : pod list --%></tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Pods 끝 -->
</div>
<script>
    /*
    <tr>
    <td>
    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
        </td>
        <td>
        kube-system
        </td>
        <td>created node name
    </td>
    <td>waiting
    </td>
    <td>0
    </td>
    <td>2018-07-04 20:15:30
    </td>
    </tr>
    */
    var namespace = "_all";

    var getPodList = function () {
        // get pods, conditions
        var podsReqUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + namespace + "/pods";

        // pod info : Name, Namespace, Node, Status, Restarts, Created on
        procCallAjax(podsReqUrl, "GET", null, null, callbackGetPods);
    };

    var callbackGetPods = function (data) {
        if (false == checkValidData(data)) {
            alert("Cannot load pods data");
            return;
        }

        var contents = [];
        $.each(data.items, function (index, podItem) {
            var pod = getPod(podItem);

            var nameClassSet;
            switch (pod.podStatus) {
                case "Pending":
                    nameClassSet = {span: "pending2", i: "fas fa-exclamation-triangle"}; break;
                case "Running":
                    nameClassSet = {span: "running2", i: "fas fa-check-circle"}; break;
                case "Succeeded":
                    nameClassSet = {span: "succeeded2", i: "fas fa-check-circle"}; break;
                case "Failed":
                    nameClassSet = {span: "failed2", i: "fas fa-exclamation-circle"}; break;
                case "Unknown":
                default:
                    nameClassSet = {span: "unknown2", i: "fas fa-exclamation-triangle"}; break;
            }

            var nameHtml =
                '<span class="' + nameClassSet.span + '"><i class="' + nameClassSet.i + '"></i></span>'
                + '<a href="/caas/workloads/pods/' + pod.name + '"> ' + pod.name + '</a>';

            var podRowHtml = '<tr pod-name="' + pod.name + '" created-on="' + pod.creationTimestamp + '">'
                + '<td name="name" value>' + nameHtml + '</td>'
                + '<td>' + pod.namespace + '</td>'
                + '<td>' + pod.nodeName + '</td>'
                + '<td>' + pod.podStatus + '</td>'
                + '<td>' + pod.restartCount + '</td>'
                + '<td>' + pod.creationTimestamp + '</td></tr>'
            contents.push(podRowHtml);
        });

        // append pod list tbody
        $('#pods_table_in_workloads > tbody').html(contents);

        // default sort : pod's name
        sortTable("pods_table_in_workloads", "pod-name", true);
    }

    var getPod = function (podItem) {
        // required : name, namespace, node, status, restart(count), created on
        var _metadata = podItem.metadata;
        var _spec = podItem.spec;
        var _status = podItem.status;

        // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
        return {
            name: _metadata.name,
            namespace: _metadata.namespace,
            nodeName: _spec.nodeName,
            podStatus: _status.phase,
            restartCount: processIfDataIsNull(
                _status.containerStatuses, function (data) {
                    return data.reduce(function (a, b) {
                        return {restartCount: a.restartCount + b.restartCount};
                    }, {restartCount: 0}).restartCount;
                }, 0),
            creationTimestamp: _metadata.creationTimestamp
        };
    }

    // ON LOAD
    $(document.body).ready(function () {
        $(".sort-arrow").on("click", function(event) {
            var tableId = "pods_table_in_workloads";
            var sortKey = $(event.currentTarget).attr('sort-key');
            var isAscending = $(event.currentTarget).hasClass('sort')? true : false;
            sortTable(tableId, sortKey, isAscending);
        });

        getPodList();
    });
</script>