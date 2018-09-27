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
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
    <!-- Overview 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <!-- 그래프 시작 -->
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Overview</p>
                        <div class="sortable_right label">
                            <span class="running2 maR10"><i class="fas fa-circle"></i></span>Running
                            <span class="failed2 maL25 maR10"><i class="fas fa-circle"></i></span>Failed
                            <span class="pendding2 maL25 maR10"><i class="fas fa-circle"></i></span>Pendding
                            <span class="succeeded2 maL25 maR10"><i class="fas fa-circle"></i></span>Succeeded
                        </div>
                    </div>
                    <div class="graphArea"><div id="piechart01" style="height: 260px"></div></div>
                    <div class="graphArea"><div id="piechart02" style="height: 260px"></div></div>
                    <div class="graphArea"><div id="piechart03" style="height: 260px"></div></div>
                    <div style="clear:both;"></div>
                </div>
            </li>
            <!-- 그래프 끝 -->
            <!-- Deployments 시작 -->
            <li class="cluster_third_box">
                <jsp:include page="../deployments/list.jsp" flush="true"/>
            </li>
            <!-- Deployments 끝 -->

            <!-- Pods 시작 -->
            <li class="cluster_third_box">
                <jsp:include page="../pods/list.jsp" flush="true"/>
            </li>
            <!-- Pods 끝 -->

            <!-- Replica Sets 시작 -->
            <li class="cluster_fourth_box maB50">
                <jsp:include page="../replicasets/list.jsp" flush="true"/>
            </li>
            <!-- Replica Sets 끝 -->
        </ul>
    </div>
    <!-- Overview 끝 -->

</div>

<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script type="text/javascript">
    // ON LOAD
    $(window).bind("load", function () {
        getDeploymentsList();
        getPodsList();
        getReplicaSetsList("");
        createChart();
    });

    var createChart = function() {
        var devListLength = G_DEPLOYMENTS_LIST_LENGTH;

        var podsChartRunningPer   = G_PODS_CHART_RUNNING_CNT   / G_PODS_LIST_LENGTH * 100;
        var podsChartFailedPer    = G_PODS_CHART_FAILED_CNT    / G_PODS_LIST_LENGTH * 100;
        var podsChartPenddingPer  = G_PODS_CHART_PENDING_CNT   / G_PODS_LIST_LENGTH * 100;
        var podsChartSucceededPer = G_PODS_CHART_SUCCEEDED_CNT / G_PODS_LIST_LENGTH * 100;

        var devChartRunningPer   = G_DEV_CAHRT_RUNNING_CNT  / devListLength * 100;
        var devChartFailedPer    = G_DEV_CHART_FAILED_CNT   / devListLength * 100;
        var devChartPenddingPer  = G_DEV_CHART_PENDDING_CNT / devListLength * 100;
        var devChartSucceededPer = G_DEV_CHART_SUCCEEDEDCNT / devListLength * 100;
        // ReplicaSets Statistics
        var repsChartRunningPer   = G_REPLICA_SETS_CHART_RUNNING_CNT   / G_REPLICA_SETS_LIST_LENGTH * 100;
        var repsChartFailedPer    = G_REPLICA_SETS_CHART_FAILED_CNT    / G_REPLICA_SETS_LIST_LENGTH * 100;
        var repsChartPenddingPer  = G_REPLICA_SETS_CHART_PENDDING_CNT  / G_REPLICA_SETS_LIST_LENGTH * 100;
        var repsChartSucceededPer = G_REPLICA_SETS_CHART_SUCCEEDED_CNT / G_REPLICA_SETS_LIST_LENGTH * 100;

        // 도넛차트
        var pieColors = ['#3076b2', '#85c014', '#f01108' , '#333440'];
        Highcharts.chart('piechart01', {
            chart: {
                type: 'pie',
                marginTop: 0
            },
            title: {
                text: 'Deployments',
                y : 120, // y position
                style: {
                    fontSize: '15px',
                    fontWeight: 'bold'
                }
            },
            plotOptions: {
                pie: {
                    innerSize: 110,
                    colors : pieColors,
                    dataLabels: {
                        enabled: true,
                        format: '{point.percentage:.0f} %',
                        distance: -25,
                        style: {
                            fontSize: '14px',
                            fontWeight: 'bold'
                        }
                    }
                }
            },
            tooltip: {
                headerFormat: '',
                pointFormat: '{point.name}: <b>{point.y:.2f}%</b><br/>',
                footerFormat:''
            },
            series: [{
                data: [
                    ['Succeeded', devChartSucceededPer],
                    ['Running', devChartRunningPer],
                    ['Failed', devChartFailedPer],
                    ['Pendding', devChartPenddingPer]
                ]
            }],
            credits: { // logo hide
                enabled: false
            }
        });
        Highcharts.chart('piechart02', {
            chart: {
                type: 'pie',
                marginTop: 0
            },
            title: {
                text: 'Pods',
                y : 120, // y position
                style: {
                    fontSize: '15px',
                    fontWeight: 'bold'
                }
            },
            plotOptions: {
                pie: {
                    innerSize: 110,
                    colors : pieColors,
                    dataLabels: {
                        enabled: true,
                        format: '{point.percentage:.0f} %',
                        distance: -25,
                        style: {
                            fontSize: '14px',
                            fontWeight: 'bold'
                        }
                    }
                }
            },
            tooltip: {
                headerFormat: '',
                pointFormat: '{point.name}: <b>{point.y:.2f}%</b><br/>',
                footerFormat:''
            },
            series: [{
                data: [
                    ['Succeeded', podsChartSucceededPer],
                    ['Running', podsChartRunningPer],
                    ['Failed', podsChartFailedPer],
                    ['Pendding', podsChartPenddingPer]
                ]
            }],
            credits: { // logo hide
                enabled: false
            }
        });
        Highcharts.chart('piechart03', {
            chart: {
                type: 'pie',
                marginTop: 0
            },
            title: {
                text: 'Replica Sets',
                y : 120, // y position
                style: {
                    fontSize: '15px',
                    fontWeight: 'bold'
                }
            },
            plotOptions: {
                pie: {
                    innerSize: 110,
                    colors : pieColors,
                    dataLabels: {
                        enabled: true,
                        format: '{point.percentage:.0f} %',
                        distance: -25,
                        style: {
                            fontSize: '14px',
                            fontWeight: 'bold'
                        }
                    }
                }
            },
            tooltip: {
                headerFormat: '',
                pointFormat: '{point.name}: <b>{point.y:.2f}%</b><br/>',
                footerFormat:''
            },
            series: [{
                data: [
                    ['Succeeded', repsChartSucceededPer],
                    ['Running', repsChartRunningPer],
                    ['Failed', repsChartFailedPer],
                    ['Pendding', repsChartPenddingPer]
                ]
            }],
            credits: { // logo hide
                enabled: false
            }
        });
    };

</script>