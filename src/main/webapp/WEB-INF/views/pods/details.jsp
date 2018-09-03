<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <jsp:include page="common-pods.jsp"/>

    <%-- NODES HEADER INCLUDE --%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <%-- TODO :: CHANGE GRAPH --%>
            <%--
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
            --%>
            <!-- Details 시작 -->
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
                                <td>default</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td><span class="bg_gray">app : nginx-2</span> <span class="bg_gray">tier: node</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td>Running</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> QoS Class</th>
                                <td>BestEffort</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Node</th>
                                <td>
                                    <a href="http://172-31-20-237" target="_blank">ip-172-31-20-237</a>
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> IP</th>
                                <td>
                                    <a href="http://10.244.3.50">10.244.3.50</a>
                                </td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Conditions</th>
                                <td>Initialized: True,  Ready: True,  ContainersReady: True, PodScheduled: True</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Controllers</th>
                                <td>Replica Set : <a href="http://caas_replica_view.html">spring-cloud-web-user-d7c647b44</a></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Volumes</th>
                                <td><a href="#">default-token-9vmgs</a></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Containers 시작 -->
            <li class="cluster_third_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Containers</p>
                    </div>
                    <div class="view_table_wrap toggle">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                                <col style='width:15%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name</td>
                                <td>Status</td>
                                <td>Images</td>
                                <td>Restart count</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <a href="#">portal-api</a>
                                </td>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> Running
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                                <td>1
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td colspan="5">
                                    <table class="table_detail alignL">
                                        <colgroup>
                                            <col style=".">
                                            <col style=".">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                            <td>portal-api</td>
                                        </tr>
                                        <tr>
                                            <td>Image</td>
                                            <td>bluedigm/hyerin:portalapi</td>
                                        </tr>
                                        <tr>
                                            <td>Environment variables</td>
                                            <td>SPRING_PROFILES_ACTIVE: local<br/>
                                                CONFIG_SERVER: 45.77.19.223<br/>
                                                EUREKA_SERVER: registration-service.default.svc.cluster.local</td>
                                        </tr>
                                        <tr>
                                            <td>Commands</td>
                                            <td>perl <br/>
                                                -Mbignum=bpi<br/>
                                                -wle <br/>
                                                print bpi(2000) </td>
                                        </tr>
                                        <tr>
                                            <td>Args</td>
                                            <td>-</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="#">portal-api</a>
                                </td>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> Running
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                                <td>1
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td colspan="5">
                                    <table class="table_detail alignL">
                                        <colgroup>
                                            <col style=".">
                                            <col style=".">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                            <td>portal-api</td>
                                        </tr>
                                        <tr>
                                            <td>Image</td>
                                            <td>bluedigm/hyerin:portalapi</td>
                                        </tr>
                                        <tr>
                                            <td>Environment variables</td>
                                            <td>SPRING_PROFILES_ACTIVE: local<br/>
                                                CONFIG_SERVER: 45.77.19.223<br/>
                                                EUREKA_SERVER: registration-service.default.svc.cluster.local</td>
                                        </tr>
                                        <tr>
                                            <td>Commands</td>
                                            <td>perl <br/>
                                                -Mbignum=bpi<br/>
                                                -wle <br/>
                                                print bpi(2000) </td>
                                        </tr>
                                        <tr>
                                            <td>Args</td>
                                            <td>-</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="#">portal-api</a>
                                </td>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> Running
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                                <td>1
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td colspan="5">
                                    <table class="table_detail alignL">
                                        <colgroup>
                                            <col style=".">
                                            <col style=".">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                            <td>portal-api</td>
                                        </tr>
                                        <tr>
                                            <td>Image</td>
                                            <td>bluedigm/hyerin:portalapi</td>
                                        </tr>
                                        <tr>
                                            <td>Environment variables</td>
                                            <td>SPRING_PROFILES_ACTIVE: local<br/>
                                                CONFIG_SERVER: 45.77.19.223<br/>
                                                EUREKA_SERVER: registration-service.default.svc.cluster.local</td>
                                        </tr>
                                        <tr>
                                            <td>Commands</td>
                                            <td>perl <br/>
                                                -Mbignum=bpi<br/>
                                                -wle <br/>
                                                print bpi(2000) </td>
                                        </tr>
                                        <tr>
                                            <td>Args</td>
                                            <td>-</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Containers 끝 -->
        </ul>
    </div>
    <!-- Details  끝 -->
</div>

<!-- modal -->
<div class="modal fade dashboard" id="layerpop">
    <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
            <div class="modal-content">
                <!-- header -->
                <div class="modal-header">
                    <!-- 닫기(x) 버튼 -->
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <!-- header title -->
                    <h4 class="modal-title">Auto- Scaling  설정</h4>
                </div>
                <!-- body -->
                <div class="modal-body">
                    <div class="modal-bg">
                        <span>
                            앱 이름
                        </span>
                        <div class="pull-right">
                            <input id="check1" checked="checked" type="checkbox" />
                            <label for="check1">자동확장 시</label>
                            <input id="check2" type="checkbox" />
                            <label for="check2">자동축소 사용</label>
                        </div>
                    </div>
                    <div class="">
                        <table class="modal_t">
                            <colgroup>
                                <col style='width: 123px;'>
                                <col style='width:40px;'>
                                <col>
                                <col style='width:50px;'>
                                <col style='width:40px;'>
                                <col>
                                <col style='width:20px;'>
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>인스턴스 수 설정
                                </th>
                                <td>최소</td>
                                <td>
                                    <div>
                                        <input type="text" value="1" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                <td><p>개</p>
                                </td>
                                </td>
                                <td>최대</td>
                                <td>
                                    <div>
                                        <input type="text" value="10" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                </td>
                                <td><p>개</p>
                                </td>
                            </tr>
                            <tr>
                                <th>CPU 임계 값 설정
                                </th>
                                <td>최소</td>
                                <td>
                                    <div>
                                        <input type="text" value="20"/>
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                <td><p>%</p>
                                </td>
                                </td>
                                <td>최대</td>
                                <td>
                                    <div>
                                        <input type="text" value="80" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                </td>
                                <td><p>%</p>
                                </td>
                            </tr>
                            <tr>
                                <th>메모리 사이즈 설정
                                </th>
                                <td>최소</td>
                                <td>
                                    <div>
                                        <input type="text" value="256" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                <td><p>MB</p>
                                </td>
                                </td>
                                <td>최대</td>
                                <td>
                                    <div>
                                        <input type="text" value="2048" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                </td>
                                <td><p>MB</p>
                                </td>
                            </tr>
                            <tr>
                                <th>시간 설정</th>
                                <td> </td>
                                <td>
                                    <input class="time_left" type="text" value="10" />
                                </td>
                                <td> </td>
                                <td> </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btns2 colors4 pull-left" data-dismiss="modal">삭제</button>
                    <button type="button" class="btns2 colors4" data-dismiss="modal">변경</button>
                    <button type="button" class="btns2 colors5" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>
