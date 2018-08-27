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
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> ip-172-31-20-237 (Node_sample)</h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on">Summary</li>
            <li name="tab02" class="cluster_tabs_right">Details</li>
            <li name="tab03" class="cluster_tabs_right">Events</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
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
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" />
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
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a></td>
                                <td>Namespace_sample_1</td>
                                <td>Node_sample_1</td>
                                <td>Running</td>
                                <td>0</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>Namespace_sample_2</td>
                                <td>Node_sample_2</td>
                                <td>Running</td>
                                <td>1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>Namespace_sample_3</td>
                                <td>Node_sample_3</td>
                                <td>Running</td>
                                <td>1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a></td>
                                <td>Namespace_sample_4</td>
                                <td>Node_sample_4</td>
                                <td>Running</td>
                                <td>0</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>Namespace_sample_5</td>
                                <td>Node_sample_5</td>
                                <td>Running</td>
                                <td>1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>Namespace_sample_6</td>
                                <td>Node_sample_6</td>
                                <td>Running</td>
                                <td>1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">portal-api-deployment</a></td>
                                <td>Namespace_sample_7</td>
                                <td>Node_sample_7</td>
                                <td>Running</td>
                                <td>0</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>Namespace_sample_8</td>
                                <td>Node_sample_8</td>
                                <td>Running</td>
                                <td>1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>Namespace_sample_9</td>
                                <td>Node_sample_9</td>
                                <td>Running</td>
                                <td>1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>Namespace_sample_10</td>
                                <td>Node_sample_10</td>
                                <td>Running</td>
                                <td>1</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            </tbody>
                            <tfoot class="caas-pagenation-wrap">
                            <tr>
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
                            <tbody>
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
    <!-- Nodes Summary 끝 -->
    <!-- Nodes Details 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
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
                                <td>ip-172-31-20-237</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td><span class="bg_gray">app : nginx-2</span> <span class="bg_gray">tier : node</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td><span class="bg_gray">deprecated.daemonset.template.generation: 1</span> <span class="bg_blue"><a href="#" data-target="#layerpop" data-toggle="modal">kubectl.kubernetes.io/last-applied-Config</a></span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Addresses</th>
                                <td><span class="bg_gray">InternalIP : 172.31.22.173</span> <span class="bg_gray">Hostname : ip-172-31-22-173</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Pod CIDR</th>
                                <td>10.244.1.0/24</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Unschedulable</th>
                                <td>false</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_second_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>System info</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Machine ID</th>
                                <td>fd43cfb2cc92450eb65e9d24660e0bc7</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> System UUID</th>
                                <td>EC29F5E7-A61F-19FB-DABA-C4F461DDD978</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Boot ID</th>
                                <td>8bb12b22-eb47-4dbf-ba87-403a57df178c</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kernel Version</th>
                                <td>4.4.0-1062-aws</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> OS Images</th>
                                <td>Ubuntu 16.04.4 LTS</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Container Runtime Version</th>
                                <td>docker://1.13.1</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kubelet version</th>
                                <td>v1.11.0</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kube-Proxy Version</th>
                                <td>v1.11.0</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Operation system</th>
                                <td>linux</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Architecture</th>
                                <td>amd64</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Nodes Details 끝 -->
    <!-- NodeEvents 시작-->
    <div class="cluster_content03 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
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
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Back-off pulling Images "aa"</td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{aa}</td>
                                <td>41923</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td><span class="red2"><i class="fas fa-exclamation-circle"></i> Error: ImagesPullBackOff</span></td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{aa}</td>
                                <td>41278</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td>Back-off pulling Images "bb"</td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{bb}</td>
                                <td>129005</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td><span class="red2"><i class="fas fa-exclamation-circle"></i> Error: ImagesPullBackOff</span></td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{bb}</td>
                                <td>129005</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
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
    <!-- NodeEvents 끝 -->
</div>
<!-- modal -->
<div class="modal fade in" id="layerpop">
    <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center nodes">
            <div class="modal-content">
                <!-- header -->
                <div class="modal-header">
                    <!-- 닫기(x) 버튼 -->
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <!-- header title -->
                    <h4 class="modal-title">kubectl.kubernetes.io/last-applied-configuration</h4>
                </div>
                <!-- body -->
                <div class="modal-body">
                    <p>
                        {"apiVersion":"extensions/v1beta1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"hrjin-spring-music"},"name":"hrjin-spring-music","namespace":"default"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"hrjin-spring-music"}},"template":{"metadata":{"labels":{"app":"hrjin-spring-music"}},"spec":{"automountServiceAccountToken":true,"containers":[{"image":"bluedigm/hrjin-music:0.3","imagePullPolicy":"Always","name":"hrjin-spring-music-container","ports":[{"containerPort":7878}]}],"serviceAccountName":"hrjin-sa4"}}}}
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function () {
        createChart("current", "cpu");
        createChart("current", "mem");
        createChart("current", "disk");
    });
</script>


<%--TODO :: REMOVE--%>
<div style="padding: 10px;">
    NODE 대시보드 :: NODE LIST
    <div style="padding: 10px;">
        <div style="padding: 5px;">
            <div style="padding: 5px;">
                <span>Node: </span>
                <input type="text" id="node">
            </div>
            <button type="button" id="btnSearch"> [ 조회 ]</button>
            <button type="button" id="btnReset"> [ 목록 초기화 ]</button>
        </div>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea"
         style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted deepskyblue 4px;">
    </div>
</div>
<script type="text/javascript">
    function getNodes() {
        var nodeNameVal = $("#node").val();
        if (false == (nodeNameVal != null && nodeNameVal.replace(/\s/g, '').length > 0))
            nodeNameVal = undefined;

        // TODO :: CHECK
        var reqUrl = "<%= Constants.API_URL %>/nodes";

        if (nodeNameVal != null) {
            // var param = {
            //   nodeName: nodeNameVal
            // };
            reqUrl += "/" + nodeNameVal;
            procCallAjax(reqUrl, "GET", null, null, callbackGetNodeDetail);

            // after detail, print theses; conditions, get pods in node,
            var podsReqUrl = "<%= Constants.API_URL %>/workloads/pods/node/" + nodeNameVal;
            procCallAjax(podsReqUrl, "GET", null, null, callbackGetPodsInNode);
        } else {
            procCallAjax(reqUrl, "GET", null, null, callbackGetListNodes);
            // procCallAjax( reqUrl + "/getList.do", "GET", null, null, callbackGetListNodes );
        }
    }

    var stringifyJSON = function (obj) {
        return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
    }

    var processIfDataIsNull = function (data, procCallback, defaultValue) {
        if (data == null)
            return defaultValue;
        else {
            if (procCallback == null)
                return defaultValue;
            else
                return procCallback(data);
        }
    }

    var convertByte = function (capacity) {
        var multipleSize;
        if (capacity.match("Ki").index != -1) {
            multipleSize = 1024;
        } else if (capacity.match("Mi").index != -1) {
            multipleSize = 1024 * 1024;
        } else if (capacity.match("Gi").index != -1) {
            multipleSize = 1024 * 1024 * 1024;
        } else {
            multipleSize = 1;
        }

        return capacity.substring(0, capacity.length - 2) * multipleSize;
    }

    var formatCapacity = function (capacity, unit) {
        var unitSize;
        if (unit == null || "" == unit)
            unitSize = 1;
        else {
            if (unit === "Ki") unitSize = 1024;
            if (unit === "Mi") unitSize = Math.pow(1024, 2);
            if (unit === "Gi") unitSize = Math.pow(1024, 3);
        }

        return ((capacity / unitSize).toFixed(2) + ' ' + unit + 'B');
    }

    // CALLBACK
    var callbackGetListNodes = function (data) {
        console.log("CONSOLE DEBUG PRINT :: " + data);

        var htmlString = [];
        htmlString.push("NODES LIST :: <br><br>");
        htmlString.push("ResultCode :: " + data.resultCode + " || "
                + "Message :: " + data.resultMessage + " <br><br>");

        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(htmlString);
            return false;
        }

        // get data
        $.each(data.items, function (index, itemList) {
            var _metadata = itemList.metadata;
            var _status = itemList.status;

            var name = _metadata.name;
            var ready = _status.conditions.filter(function (condition) {
                return condition.type === "Ready";
            })[0].status;
            var limitCPU = _status.capacity.cpu;
            var requestCPU = limitCPU - _status.allocatable.cpu;
            var limitMemory = convertByte(_status.capacity.memory);

            var requestMemory = limitMemory - convertByte(_status.allocatable.memory);
            var creationTimestamp = _metadata.creationTimestamp;

            // htmlString push
            htmlString.push("Name :: " + name + " || "
                    + "Ready :: " + ready + " || "
                    + "Request CPU :: " + requestCPU + " || "
                    + "Limit CPU :: " + limitCPU + " || "
                    + "Request Memory :: " + formatCapacity(requestMemory, "Mi") + " || "
                    + "Limit Memory :: " + formatCapacity(limitMemory, "Mi") + " || "
                    + "CreationTimestamp :: " + creationTimestamp + "<br><br>");
        });

        // finally
        $('#resultArea').html(htmlString);
    }

    var callbackGetPodsInNode = function (data) {
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(
                    "ResultStatus :: " + data.resultCode + " <br><br>"
                    + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var htmlString = [$('#resultArea').html()];
        htmlString.push("PODS LIST IN NODE :: <br><br>");
        htmlString.push("ResultCode :: " + data.resultCode + " || "
                + "Message :: " + data.resultMessage + " <br><br>");

        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(htmlString);
            return false;
        }

        $.each(data.items, function (index, itemList) {
            // required : name, namespace, node, status, restart(count), created on
            var _metadata = itemList.metadata;
            var _spec = itemList.spec;
            var _status = itemList.status;

            // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
            var podName = _metadata.name;
            var namespace = _metadata.namespace;
            var nodeName = _spec.nodeName;
            var podStatus = _status.phase;
            var restartCount = processIfDataIsNull(_status.containerStatuses,
                    function (data) {
                        return data.reduce(function (a, b) {
                            return { restartCount: a.restartCount + b.restartCount };
                        }, { restartCount: 0 }).restartCount;
                    }, 0);

            var creationTimestamp = _metadata.creationTimestamp;

            htmlString.push(">> Name :: " + podName + " || "
                    + "Namespace :: " + namespace + " || "
                    + "Node :: " + nodeName + " || "
                    + "Status :: " + podStatus + " || "
                    + "Restart Count :: " + restartCount + " || "
                    + "Created At :: " + creationTimestamp + "<br><br>");
        });

        //var $resultArea = $('#resultArea');
        $('#resultArea').html(htmlString);
    }

    var callbackGetNodeDetail = function (data) {
        console.log("CONSOLE DEBUG PRINT :: " + data);

        var htmlString = [];
        htmlString.push("NODE DETAIL :: <br><br>");
        htmlString.push("ResultCode :: " + data.resultCode + " || "
                + "Message :: " + data.resultMessage + " <br><br>");

        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(htmlString);
            return false;
        }

        // get datum (basic detail)
        var _metadata = data.metadata;
        var _status = data.status;

        var name = _metadata.name;
        var ready = _status.conditions.filter(function (condition) {
            return condition.type === "Ready";
        })[0].status;
        var limitCPU = _status.capacity.cpu;
        var requestCPU = limitCPU - _status.allocatable.cpu;
        var limitMemory = convertByte(_status.capacity.memory);

        var requestMemory = limitMemory - convertByte(_status.allocatable.memory);
        var creationTimestamp = _metadata.creationTimestamp;

        // htmlString push
        htmlString.push("Name :: " + name + " <br><br>"
                + "Ready :: " + ready + " <br><br>"
                + "Request CPU :: " + requestCPU + " <br><br>"
                + "Limit CPU :: " + limitCPU + " <br><br>"
                + "Request Memory :: " + formatCapacity(requestMemory, "Mi") + " <br><br>"
                + "Limit Memory :: " + formatCapacity(limitMemory, "Mi") + " <br><br>"
                + "CreationTimestamp :: " + creationTimestamp + "<br><br>");

        htmlString.push("--------------------------------------------- <br><br>");

        // get datum : system info
        var nodeInfo = _status.nodeInfo;
        var machineId = nodeInfo.machineID;
        var systemUUID = nodeInfo.systemUUID;
        var bootID = nodeInfo.bootID;
        var kernalVersion = nodeInfo.kernelVersion;
        var osImages = nodeInfo.osImage;
        var containerRuntimeVersion = nodeInfo.containerRuntimeVersion;
        var kubeletVersion = nodeInfo.kubeletVersion;
        var kubeProxyVersion = nodeInfo.kubeProxyVersion;
        var operatingSystem = nodeInfo.operatingSystem;
        var architecture = nodeInfo.architecture;

        htmlString.push("NODE SYSTEM INFO :: <br><br>");
        htmlString.push("Machine Id :: " + machineId + " <br><br>"
                + "System UUID :: " + systemUUID + " <br><br>"
                + "Boot ID :: " + bootID + " <br><br>"
                + "Kernal Version :: " + kernalVersion + " <br><br>"
                + "Os Images :: " + osImages + " <br><br>"
                + "Container Runtime Version :: " + containerRuntimeVersion + " <br><br>"
                + "Kubelet Version :: " + kubeletVersion + " <br><br>"
                + "Kube-Proxy Version :: " + kubeProxyVersion + " <br><br>"
                + "Operating System :: " + operatingSystem + " <br><br>"
                + "Architecture :: " + architecture + " <br><br>"
                + "--------------------------------------------- <br><br>"
        );
        // finally
        $('#resultArea').html(htmlString);
    }

    // BIND
    $("#btnReset").on("click", function () {
        $('#resultArea').html("");
    });

    // BIND
    $("#btnReset").on("click", function() {
      $('#resultArea').html("");
    });

    // ALREADY READY STATE
    $(document).ready(function () {
        $("#btnSearch").on("click", function (e) {
            getNodes();
        });
    });

    // ON LOAD
    $(document.body).ready(function () {
        // getNodes();
    });
</script>
