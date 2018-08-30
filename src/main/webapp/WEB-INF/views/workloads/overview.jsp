<%--
  Services main
  @author REX
  @version 1.0
  @since 2018.08.09
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on" onclick="procMovePage('/caas/workloads/overview');">Overview</li>
            <li name="tab02" class="cluster_tabs_right" onclick="procMovePage('/caas/workloads/deployments');">Deployments</li>
            <li name="tab03" class="cluster_tabs_right">Pods</li>
            <li name="tab04" class="cluster_tabs_right">Replica Sets</li>

            <%--TODO :: REMOVE--%>
            <li name="tab05" class="cluster_tabs_right" onclick="procMovePage('/caas/workloads/deployments');">Deployments VIEW</li>
            <li name="tab06" class="cluster_tabs_right" onclick="procMovePage('/caas/workloads/pods');">Pods VIEW</li>
            <li name="tab07" class="cluster_tabs_right" onclick="procMovePage('/caas/workloads/replicasets');">Replica Sets VIEW</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
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
                            <span class="pending2 maL25 maR10"><i class="fas fa-circle"></i></span>Pending
                            <span class="succeeded2 maL25 maR10"><i class="fas fa-circle"></i></span>Succeeded
                        </div>
                    </div>
                    <div class="graphArea"><div id="piechart01" style="height: 260px"></div></div>
                    <div class="graphArea"><div id="piechart02" style="height: 260px"></div></div>
                    <div class="graphArea"><div id="piechart03" style="height: 260px"></div></div>
                    <!--<div class="graphArea"><img src="../resources/images/cluster/chart01.png"/></div>
                    <div class="graphArea"><img src="../resources/images/cluster/chart02.png"/></div>
                    <div class="graphArea"><img src="../resources/images/cluster/chart03.png"/></div>-->
                    <div style="clear:both;"></div>
                </div>
            </li>
            <!-- 그래프 끝 -->
            <!-- Deployments 시작 -->
            <li class="cluster_second_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Deployments</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_deployments_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_deployments_view.html">spring-cloud-web-user</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                </td>
                                <td>1 / 1
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:config-1.5<br/>
                                    bluedigm/hyerin:registration-1.5<br/>
                                    bluedigm/hyerin:gateway-1.0<br/>
                                    bluedigm/hyerin:infra-admin<br/>
                                    bluedigm/hyerin:common-api<br/>
                                    bluedigm/hyerin:portalapi<br/>
                                    cissc2/paas-ta-portal-webadmin:0.6<br/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_deployments_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Deployments 끝 -->
            <!-- Pods 시작 -->
            <li class="cluster_third_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
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
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span class="red2"><i class="fas fa-exclamation-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a><br/>
                                    <span class="red2">Back-off restarting failed container</span>
                                </td>
                                <td>
                                    aaa
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
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name<br/>
                                </td>
                                <td>Terminated
                                </td>
                                <td>1
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="red2"><i class="fas fa-exclamation-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment<br/></a>
                                    <span class="red2">Back-off restarting failed container</span>
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
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Pods 끝 -->
            <!-- Replica Sets 시작 -->
            <li class="cluster_fourth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Replica Sets</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">spring-cloud-web-user</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                </td>
                                <td>1 / 1
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:config-1.5<br/>
                                    bluedigm/hyerin:registration-1.5<br/>
                                    bluedigm/hyerin:gateway-1.0<br/>
                                    bluedigm/hyerin:infra-admin<br/>
                                    bluedigm/hyerin:common-api<br/>
                                    bluedigm/hyerin:portalapi<br/>
                                    cissc2/paas-ta-portal-webadmin:0.6<br/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Replica Sets 끝 -->
        </ul>
    </div>
    <!-- Overview 끝 -->
    <!-- Deployments 시작 -->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Deployments</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_deployments_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_deployments_view.html">spring-cloud-web-user</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                </td>
                                <td>1 / 1
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:config-1.5<br/>
                                    bluedigm/hyerin:registration-1.5<br/>
                                    bluedigm/hyerin:gateway-1.0<br/>
                                    bluedigm/hyerin:infra-admin<br/>
                                    bluedigm/hyerin:common-api<br/>
                                    bluedigm/hyerin:portalapi<br/>
                                    cissc2/paas-ta-portal-webadmin:0.6<br/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_deployments_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Deployments 끝 -->
    <!-- Pods 시작 -->
    <div class="cluster_content03 row two_line two_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
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
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span class="red2"><i class="fas fa-exclamation-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment<br/></a>
                                    <span class="red2">Back-off restarting failed container</span>
                                </td>
                                <td>
                                    aaa
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
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name<br/>
                                </td>
                                <td>Terminated
                                </td>
                                <td>1
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td>created node name
                                </td>
                                <td>running
                                </td>
                                <td>2
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="red2"><i class="fas fa-exclamation-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment<br/></a>
                                    <span class="red2">Back-off restarting failed container</span>
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
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Pods 끝 -->
    <!-- Replica Sets 시작 -->
    <div class="cluster_content04 row two_line two_view harf_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Replica Sets</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">spring-cloud-web-user</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                </td>
                                <td>1 / 1
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:config-1.5<br/>
                                    bluedigm/hyerin:registration-1.5<br/>
                                    bluedigm/hyerin:gateway-1.0<br/>
                                    bluedigm/hyerin:infra-admin<br/>
                                    bluedigm/hyerin:common-api<br/>
                                    bluedigm/hyerin:portalapi<br/>
                                    cissc2/paas-ta-portal-webadmin:0.6<br/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Replica Sets 끝 -->
</div>

<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script>
    // 도넛차트
    var pieColors = ['#07ceb0', '#3076b2', '#4b4f53' , '#fe8d14'];
    Highcharts.chart('piechart01', {
        chart: {
            type: 'pie',
            marginTop: 0,
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
                ['Succeeded', 46],
                ['Running', 18],
                ['Failed', 18],
                ['Pendding', 18]
            ]
        }],
        credits: { // logo hide
            enabled: false
        }
    });
    Highcharts.chart('piechart02', {
        chart: {
            type: 'pie',
            marginTop: 0,
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
                ['Succeeded', 46],
                ['Running', 18],
                ['Failed', 18],
                ['Pendding', 18]
            ]
        }],
        credits: { // logo hide
            enabled: false
        }
    });
    Highcharts.chart('piechart03', {
        chart: {
            type: 'pie',
            marginTop: 0,
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
                ['Succeeded', 46],
                ['Running', 18],
                ['Failed', 18],
                ['Pendding', 18]
            ]
        }],
        credits: { // logo hide
            enabled: false
        }
    });
</script>