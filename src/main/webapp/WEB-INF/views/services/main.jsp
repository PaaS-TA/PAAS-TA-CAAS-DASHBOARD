<%--
  Services main
  @author REX
  @version 1.0
  @since 2018.08.09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
        <ul>
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Services</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" />
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:10%;'>
                                <col style='width:20%;'>
                                <col style='width:5%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Service Type</td>
                                <td>Cluster IP</td>
                                <td>Endpoints</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="javascript:void(0);" onclick="procMovePage('/services/heapster');">DETAIL TEST</a></td>
                                <%--<td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_services_view.html">portal</a></td>--%>
                                <td>Node Port</td>
                                <td>10.98.1.440</td>
                                <td><p>infra-admin-service:2227 TCP</p><p>infra-admin-service:30341 TCP</p></td>
                                <td>1 / 1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_services_view.html">infra-admin-service</a></td>
                                <td>Cluster IP</td>
                                <td>10.98.1.440</td>
                                <td><p>infra-admin-service:2227 TCP</p><p>infra-admin-service:30341 TCP</p></td>
                                <td>3 / 3</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_services_view.html">infra-admin-service</a></td>
                                <td>Cluster IP</td>
                                <td>10.98.1.440</td>
                                <td><p>registration-service:2221 TCP</p><p>registration-service:3</p></td>
                                <td>0 / 0</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_services_view.html">spring-cloud-web-use</a></td>
                                <td>Cluster IP</td>
                                <td>10.98.1.440</td>
                                <td><p>spring-cloud:8004 TCP</p><p>spring-cloud:31167 TCP</p><p>spring-cloud:2221 TCP</p></td>
                                <td>1 / 1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_services_view.html">kubernetes</a></td>
                                <td>Cluster IP</td>
                                <td>10.98.1.440</td>
                                <td><p>kubernetes:443 TCP</p><p>kubernetes:0 TCP</p></td>
                                <td>1 / 1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            </tbody>
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


<%--TODO :: REMOVE--%>
<div style="padding: 10px;">
    SERVICE 대시보드 :: SERVICE DASHBOARD
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
</div>
<script type="text/javascript">

    // GET LIST
    var getList = function() {
        procCallAjax("<%= Constants.API_URL %>/services", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var serviceName;
        var endpointsPreString;
        var nodePort;
        var specPortsList;
        var specPortsListLength;
        var endpoints ="";
        var postfixString;
        var items = data.items;
        var listLength = items.length;
        var selectorList = [];
        var htmlString = [];

        htmlString.push("SERVICE LIST :: <br><br>");

        // service.namespace:port protocol
        // service.namespace:nodePort protocol -> service.namespace:0 protocol
        
        for (var i = 0; i < listLength; i++) {
            serviceName = items[i].metadata.name;
            endpointsPreString = serviceName + "." + items[i].metadata.namespace + ":";
            nodePort = items[i].spec.ports.nodePort;

            if (nodePort === undefined) {
                nodePort = "0";
            }

            specPortsList = items[i].spec.ports;
            specPortsListLength = specPortsList.length;

            for (var j = 0; j < specPortsListLength; j++) {
                (j === specPortsListLength - 1) ? postfixString = "" : postfixString = ", ";

                endpoints += endpointsPreString + specPortsList[j].port + " " + specPortsList[j].protocol + ", "
                    + endpointsPreString + nodePort + " " + specPortsList[j].protocol + postfixString;
            }

            var selector = procSetSelector(items[i].spec.selector);

            htmlString.push(
                "<a href='javascript:void(0);' onclick='procMovePage(\"/services/" + serviceName + "\");'><span style='color: orangered;'>[ DETAIL ]</span></a> "
                + "name :: " + serviceName + " || "
                + "type :: " + items[i].spec.type + " || "
                + "clusterIP :: " + items[i].spec.clusterIP + " || "
                + "endpoints :: " + endpoints + " || "
                + "pods :: " + "<span id='" + serviceName + "'></span> || "
                + "creationTimestamp :: " + items[i].metadata.creationTimestamp

                + "<br><br>");
            endpoints = "";
            selectorList.push(selector + "," + serviceName);
        }

        $('#resultArea').html(htmlString);
        getDetailForPods(selectorList);
    };


    // GET DETAIL
    var getDetailForPods = function(selectorList) {
        var listLength = selectorList.length;
        var tempSelectorList;
        var reqUrl;

        for (var i = 0; i < listLength; i++) {
            tempSelectorList = selectorList[i].split(",");
            reqUrl = "<%= Constants.API_URL %>/workload/namespaces/kube-system/pods/service/" + tempSelectorList[1] + "/" + tempSelectorList[0];

            procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPods);
        }
    };


    // CALLBACK
    var callbackGetDetailForPods = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

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

        $('#' + data.serviceName).html(runningSum + "/" + totalSum);
    };


    // BIND
    $("#btnSearch").on("click", function() {
        getList();
    });


    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });


    // ON LOAD
    $(document.body).ready(function () {
        // getList();
    });

</script>
