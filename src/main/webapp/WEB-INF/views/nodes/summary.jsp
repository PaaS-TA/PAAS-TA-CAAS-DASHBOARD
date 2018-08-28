<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.27
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- Nodes Summary 시작 -->
<div class="cluster_content01 row two_line two_view harf_view">
    <ul class="maT30">
        <!-- 그래프 시작 -->
        <li class="cluster_first_box">
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
        </li>
        <!-- 그래프 끝 -->
        <li class="cluster_second_box">
            <div class="sortable_wrap">
                <div class="sortable_top">
                    <p>Pods</p>
                    <ul class="colright_btn">
                        <li>
                            <input type="text" id="table-search-01" name="" class="table-search" placeholder="search"/>
                            <button name="button" class="btn table-search-on" type="button">
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
                            <td>Name
                                <button sort-key="pod-name" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>
                            </td>
                            <td>Namespace</td>
                            <td>Node</td>
                            <td>Status</td>
                            <td>Restarts</td>
                            <td>Created on
                                <button sort-key="created-on" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>
                            </td>
                        </tr>
                        </thead>
                        <tbody id="tbody_node_pods">
                        <tr><td colspan="6" style="text-align: center;">LOADING PODS IN NODE</td></tr>
                        </tbody>
                        <tfoot class="caas-pagenation-wrap">
                        <tr>
                            <!-- TODO :: REMOVE PAGINATION -->
                            <!--
                            <td colspan="6" class="caas-pagenation">
                                <ul class="caas-pagenation-angle">
                                    <li><i class="fas fa-angle-double-left"></i></li>
                                    <li><i class="fas fa-angle-left"></i></li>
                                    <li><i class="fas fa-angle-right"></i></li>
                                    <li><i class="fas fa-angle-double-right"></i></li>
                                </ul>
                                <div class="caas-pagenation-pages">
                                    <span>1</span> - <span>10</span> of <span>58</span>
                                </div>
                            </td>
                            -->
                            <td colspan="6" class="caas-pagenation">
                                <a id="pod_more_link" href="#">더 보기</a>
                            </td>
                        </tr>
                        </tfoot>
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
                    <table class="table_event condition alignL">
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
                        <tbody id="tbody_node_conditions">
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

<script>
    var callbackGetNodeSummary = function (nodeName, conditions) {
        // get pods, conditions
        var podsReqUrl = "<%= Constants.API_URL %>/workloads/pods/node/" + nodeName;

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
        $('#tbody_node_conditions').html(contents);
    }

    var callbackGetPods = function (data) {
        if (false == checkInvalidData(data)) {
            alert("Cannot load pods data");
            return;
        }

        var contents = [];
        $.each(data.items, function (index, podItem) {
            let pod = getPod(podItem);

            let nameClassSet;
            switch (pod.podStatus) {
                case "Pending":
                    nameClassSet = {span: "pending2", i: "fas fa-exclamation-circle"}; break;
                case "Running":
                    nameClassSet = {span: "running2", i: "fas fa-check-circle"}; break;
                case "Succeeded":
                    nameClassSet = {span: "succeeded2", i: "fas fa-check-circle"}; break;
                case "Failed":
                    nameClassSet = {span: "failed2", i: "fas fa-exclamation-circle"}; break;
                case "Unknown":
                default:
                    nameClassSet = {span: "unknown2", i: "fas fa-exclamation-circle"}; break;
            }

            let nameHtml =
                '<span class="' + nameClassSet.span + '"><i class="' + nameClassSet.i + '" style="padding-right: 5px;"></i></span>'
                + '<a href="/workload/pods/' + pod.name + '">' + pod.name + '</a>';

            let podRowHtml = '<tr pod-name="' + pod.name + '" created-on="' + pod.creationTimestamp + '">'
                + '<td name="name" value>' + nameHtml + '</td>'
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

        // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
        var pod = {
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

        return pod;
    }
</script>
<!-- Nodes Summary 끝 -->
