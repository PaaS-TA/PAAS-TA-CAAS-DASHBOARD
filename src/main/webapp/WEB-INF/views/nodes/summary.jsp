<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- Nodes Summary 시작 -->
<div class="content">
    <jsp:include page="common-nodes.jsp"/>

    <%-- NODES HEADER INCLUDE --%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <!-- 그래프 시작 -->
            <li class="cluster_first_box">
            <%-- TODO :: ADD GRAPH
                <div>추이 그래프 대신 포탈의 일반 그래프 넣기</div>
            --%>
            <!--
                <div class="graph-legend-wrap clearfix">
                    <ul class="graph-legend">
                        <li rel="current" class="on">현재</li>
                        <li rel="1h">1시간</li>
                        <li rel="6h">6시간</li>
                        <li rel="1d">1일</li>
                        <li rel="7d">7일</li>
                        <li rel="30d">30일</li>
                    </ul>
                </div>
                <div class="graph-nodes">
                    <div class="graph-tit-wrap">
                        <p class="graph-tit">
                            CPU<br/>
                            현재 사용량
                        </p>
                        <p class="graph-rate tit-color1">
                            <span>60</span>%
                        </p>
                    </div>
                    <div class="graph-cnt">
                        <div id="areachartcpu" style="min-width: 250px; height: 170px; margin: 0 auto"></div>
                    </div>
                </div>
                <div class="graph-nodes">
                    <div class="graph-tit-wrap">
                        <p class="graph-tit">
                            메모리<br/>
                            현재 사용량
                        </p>
                        <p class="graph-rate tit-color2">
                            <span>60</span>%
                        </p>
                    </div>
                    <div class="graph-cnt">
                        <div id="areachartmem" style="min-width: 250px; height: 170px; margin: 0 auto"></div>
                    </div>
                </div>
                <div class="graph-nodes">
                    <div class="graph-tit-wrap">
                        <p class="graph-tit">
                            디스크<br/>
                            현재 사용량
                        </p>
                        <p class="graph-rate tit-color3">
                            <span>60</span>%
                        </p>
                    </div>
                    <div class="graph-cnt">
                        <div id="areachartdisk" style="min-width: 250px; height: 170px; margin: 0 auto"></div>
                    </div>
                </div>
            -->
            </li>
            <!-- 그래프 끝 -->
            <li class="cluster_second_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="Pod name" onkeypress="if(event.keyCode===13) { setPodsList(this.value); } " />
                                <button name="button" class="btn table-search-on" id="tableSearchBtn" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="view_table_wrap">
                        <table id="pods_table_in_node" class="table_event condition alignL">
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
                                <td>Name <button data-sort-key="pod-name" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>
                                </td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on <button data-sort-key="created-on" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>
                                </td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr><td colspan="6" style="text-align: center;">LOADING PODS IN NODE</td></tr>
                            </tbody>
                            <tfoot class="caas-pagenation-wrap"></tfoot>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_third_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Conditions</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="conditions_in_node" class="table_event condition alignL">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Type</td>
                                <td>Status</td>
                                <td>Last heartbeat time</td>
                                <td>Last transition time</td>
                                <td>Reason</td>
                                <td>Message</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr><td colspan="6" style="text-align: center;">LOADING CONDITIONS</td></tr>
                            </tbody>
                            <!-- TODO :: REMOVE TFOOT ELEMENT IN NODE CONDITIONS -->
                            <!--tfoot>
                                <tr>
                                    <td colspan="6">
                                        <button class="btns2 btns2_1 colors4 event_btns">더보기</button>
                                    </td>
                                </tr>
                            </tfoot-->
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>

<script>
    var callbackGetNodeSummary = function (data) {
        // check data validation
        if (false == checkValidData(data)) {
            alert("Cannot load node info.");
            return;
        }

        var nodeName = data.metadata.name;
        var conditions = data.status.conditions;

        // get pods, conditions
        var namespace = NAME_SPACE;
        var podsReqUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + namespace + "/pods/node/" + nodeName;

        // pod info : Name, Namespace, Node, Status, Restarts, Created on
        procCallAjax(podsReqUrl, "GET", null, null, callbackGetPods);

        // set conditions
        var contents = [];
        $.each(conditions, function (index, condition) {
            contents.push('<tr>'
                + '<td>' + condition.type + '</td>'
                + '<td>' + condition.status + '</td>'
                + '<td>' + condition.lastHeartbeatTime + '</td>'
                + '<td>' + condition.lastTransitionTime + '</td>'
                + '<td>' + condition.reason + '</td>'
                + '<td>' + condition.message + '</td></tr>');
        });

        // append conditions tbody
        $('#conditions_in_node > tbody').html(contents);
    }

    var notFoundElement = '<tr id="podNotFound" style="display:none;"><td colspan="6" style="text-align:center;">Cannot find by pod name.</td></tr>';

    var callbackGetPods = function (data) {
        if (false == checkValidData(data)) {
            alert("Cannot load pods data");
            return;
        }

        var contents = [ notFoundElement ];
        $.each(data.items, function (index, podItem) {
            var pod = getPod(podItem);

            var nameClassSet;
            var errorMsg = null;
            switch (pod.podStatus) {
                case "Pending":
                    nameClassSet = {span: "pending2", i: "fas fa-exclamation-triangle"};
                    errorMsg = pod.podErrorMsg;
                    break;
                case "Running":
                    nameClassSet = {span: "running2", i: "fas fa-check-circle"}; break;
                case "Succeeded":
                    nameClassSet = {span: "succeeded2", i: "fas fa-check-circle"}; break;
                case "Failed":
                    nameClassSet = {span: "failed2", i: "fas fa-exclamation-circle"};
                    errorMsg = pod.podErrorMsg;
                    break;
                case "Unknown":
                default:
                    nameClassSet = {span: "unknown2", i: "fas fa-exclamation-triangle"};
                    errorMsg = pod.podErrorMsg;
                    break;
            }

            var nameHtml =
                '<span class="' + nameClassSet.span + '"><i class="' + nameClassSet.i + '"></i></span>'
                + '<a href="/caas/workloads/pods/' + pod.name + '"> ' + pod.name + '</a>';
            if (errorMsg != null && errorMsg != "")
                nameHtml += '<br><span class="' + nameClassSet.span + '">' + errorMsg + '</span>';

            var podRowHtml = '<tr name="podRow" data-pod-name="' + pod.name + '" data-created-on="' + pod.creationTimestamp + '">'
                + '<td>' + nameHtml + '</td>'
                + '<td>' + pod.namespace + '</td>'
                + '<td>' + pod.nodeName + '</td>'
                + '<td>' + pod.podStatus + '</td>'
                + '<td>' + pod.restartCount + '</td>'
                + '<td>' + pod.creationTimestamp + '</td></tr>'
            contents.push(podRowHtml);
        });

        // append pod tbody
        $('#pods_table_in_node > tbody').html(contents);

        // default sort : pod's name
        sortTable("pods_table_in_node", "pod-name", true);
    }

    var getPod = function (podItem) {
        // required : name, namespace, node, status, restart(count), created on
        var _metadata = podItem.metadata;
        var _spec = podItem.spec;
        var _status = podItem.status;
        var _podErrorMsg = null;

        switch (_status.phase) {
            case "Pending":
            case "Failed":
            case "Unknown":
                var findConditions = _status.conditions.filter(function (item) { return item.reason != null && item.message != null});
                if (findConditions.length > 0)
                    _podErrorMsg = findConditions[0].reason + " (" + findConditions[0].message + ")";
                else
                    _podErrorMsg = null;
                break;
            default:
                break;
        }

        // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
        return {
            name: _metadata.name,
            namespace: _metadata.namespace,
            nodeName: (_spec.nodeName != null? _spec.nodeName : "-"),
            podStatus: _status.phase,
            podErrorMsg: _podErrorMsg,
            restartCount: processIfDataIsNull(
                _status.containerStatuses, function (data) {
                    return data.reduce(function (a, b) {
                        return {restartCount: a.restartCount + b.restartCount};
                    }, {restartCount: 0}).restartCount;
                }, 0),
            creationTimestamp: _metadata.creationTimestamp
        };
    }

    // filter pod list by pod name
    var setPodsList = function(findValue) {
        var podNotFound = $("#podNotFound");
        var podRows = $("tr[name=podRow]");
        if (nvl(findValue) === "") {
            podNotFound.hide();
            podRows.show();
        } else {
            $.each(podRows, function(index, row) {
                var row = $(row);
                if (row.data("podName").indexOf(findValue) > -1)
                    row.show();
                else
                    row.hide();
            });
        }
    };

    // ON LOAD
    $(document.body).ready(function () {
        // TODO :: Change chart functions.
        //createChart("current", "cpu");
        //createChart("current", "mem");
        //createChart("current", "disk");

        $("#tableSearchBtn").on("click", function(event) {
            var keyword = $("#table-search-01").val();
            setPodsList(keyword);
        });

        // add sort-arrow click event in pods table
        $(".sort-arrow").on("click", function(event) {
            var tableId = "pods_table_in_node";
            var sortKey = $(event.currentTarget).data('sort-key');
            var isAscending = $(event.currentTarget).hasClass('sort')? true : false;
            sortTable(tableId, sortKey, isAscending);
        });

        getNode(nodeName, callbackGetNodeSummary);
    });
</script>
<!-- Nodes Summary 끝 -->
