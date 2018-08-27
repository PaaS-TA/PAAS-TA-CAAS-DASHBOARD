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
                            <td>Name
                                <button class="sort-arrow"><i class="fas fa-caret-down"></i></button>
                            </td>
                            <td>Namespace</td>
                            <td>Node</td>
                            <td>Status</td>
                            <td>Restarts</td>
                            <td>Created on
                                <button class="sort-arrow"><i class="fas fa-caret-down"></i></button>
                            </td>
                        </tr>
                        </thead>
                        <tbody id="tbody_node_pods">
                        <!-- TODO :: REMOVE UNDER EXAMPLE -->
                        <!-- block example start -->
                        <!--
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">portal-api-deployment</a></td>
                            <td>Namespace_sample_1</td>
                            <td>Node_sample_1</td>
                            <td>Running</td>
                            <td>0</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">spring-cloud-web-user</a></td>
                            <td>Namespace_sample_2</td>
                            <td>Node_sample_2</td>
                            <td>Running</td>
                            <td>1</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">spring-cloud-web-user</a></td>
                            <td>Namespace_sample_3</td>
                            <td>Node_sample_3</td>
                            <td>Running</td>
                            <td>1</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">portal-api-deployment</a></td>
                            <td>Namespace_sample_4</td>
                            <td>Node_sample_4</td>
                            <td>Running</td>
                            <td>0</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">spring-cloud-web-user</a></td>
                            <td>Namespace_sample_5</td>
                            <td>Node_sample_5</td>
                            <td>Running</td>
                            <td>1</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">spring-cloud-web-user</a></td>
                            <td>Namespace_sample_6</td>
                            <td>Node_sample_6</td>
                            <td>Running</td>
                            <td>1</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">portal-api-deployment</a></td>
                            <td>Namespace_sample_7</td>
                            <td>Node_sample_7</td>
                            <td>Running</td>
                            <td>0</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">spring-cloud-web-user</a></td>
                            <td>Namespace_sample_8</td>
                            <td>Node_sample_8</td>
                            <td>Running</td>
                            <td>1</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">spring-cloud-web-user</a></td>
                            <td>Namespace_sample_9</td>
                            <td>Node_sample_9</td>
                            <td>Running</td>
                            <td>1</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_pods_view.html">spring-cloud-web-user</a></td>
                            <td>Namespace_sample_10</td>
                            <td>Node_sample_10</td>
                            <td>Running</td>
                            <td>1</td>
                            <td>2018-07-04 20:15:30</td>
                        </tr>
                        -->
                        <!-- block example end -->
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
                        <!-- TODO :: REMOVE EXAMPLE
                        <tr>
                            <td>OutOfDisk</td>
                            <td>False</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>KubeletHasSufficientDisk</td>
                            <td>kubelet has sufficient disk space available</td>
                        </tr>
                        <tr>
                            <td>MemoryPressure</td>
                            <td>False</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>KubeletHasSufficientMemory</td>
                            <td>kubelet has sufficient memory available</td>
                        </tr>
                        <tr>
                            <td>DiskPressure</td>
                            <td>False</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>KubeletHasNoDiskPressure</td>
                            <td>kubelet has no disk pressure</td>
                        </tr>
                        <tr>
                            <td>PIDPressure</td>
                            <td>False</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>KubeletHasSufficientPID</td>
                            <td>kubelet has sufficient PID available</td>
                        </tr>
                        <tr>
                            <td>Ready</td>
                            <td>True</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>2018-07-04 20:15:30</td>
                            <td>KubeletReady</td>
                            <td>kubelet is posting ready status. AppArmor enabled</td>
                        </tr>
                        -->
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
<!-- Nodes Summary 끝 -->
