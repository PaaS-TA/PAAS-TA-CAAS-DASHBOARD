<%--
  Services detail
  @author REX
  @version 1.0
  @since 2018.08.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> nginx-2-6bd764c757-jhgnd (Services_sample)</h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on">Details</li>
            <li name="tab02" class="cluster_tabs_right">Events</li>
            <li name="tab03" class="cluster_tabs_right">YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Services Details 시작 -->
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
                                <td>kube-flannel-ds</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td>default</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Label Selector</th>
                                <td><span class="bg_gray">app : nginx-2</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Type</th>
                                <td>NodePort</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Session Affinity</th>
                                <td>None</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Cluster IP</th>
                                <td><a href="http://10.98.1.44" target="_blank">10.98.1.44</a></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Internal endpoints</th>
                                <td><p>infra-admin-service:2227 TCP</p><p>infra-admin-service:30341 TCP</p></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_third_box">
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
                        <table class="table_event condition alignL service-lh">
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
                                <td>aaa</td>
                                <td>Node_sample_01</td>
                                <td>Waiting</td>
                                <td>0</td>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_pods_view.html">spring-cloud-web-user</a></td>
                                <td>default</td>
                                <td>Node_sample_02</td>
                                <td>Running</td>
                                <td>1</td>
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
            <li class="cluster_fourth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Endpoints</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Host</td>
                                <td>Ports (Name, Port, Protocol)</td>
                                <td>Node</td>
                                <td>Ready</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>10.244.1.100</td>
                                <td>web-user, 80, TCP</td>
                                <td>ip-172-31-22-173</td>
                                <td>True</td>
                            </tr>
                            <tr>
                                <td>10.244.3.50</td>
                                <td>web-user, 80, TCP</td>
                                <td>ip-172-31-22-173</td>
                                <td>True</td>
                            </tr>
                            </tbody>
                            <!--tfoot>
                                <tr>-
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
    <!-- Services Details 끝 -->
    <!-- Services Events 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh">
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
                                <td>Created pod: aa-57cff4f9df-xcstf</td>
                                <td>replicaset-controller</td>
                                <td>-</td>
                                <td>1</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td>Created pod: aa-57cff4f9df-xcstf</td>
                                <td>replicaset-controller</td>
                                <td>-</td>
                                <td>1</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td>Created pod: aa-57cff4f9df-xcstf</td>
                                <td>replicaset-controller</td>
                                <td>-</td>
                                <td>1</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Services Events 끝 -->
    <!-- Services YAML 시작-->
    <div class="cluster_content03 row two_line two_view harf_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>YAML</p>
                    </div>
                    <div class="paA30">
                        <div class="yaml">
                                    <pre class="brush: cpp">
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
    annotations:
    kubectl.kubernetes.io/last-applied-Config: |
        {"apiVersion":"extensions/v1beta1","kind":"DaemonSet","metadata":{"annotations":{},"labels":{"addonmanCreated onr.kubernetes.io/mode":"Reconcile","k8s-app":"fluentd-gcp","kubernetes.io/cluster-service":"true","version":"v2.0.17"},"name":"fluentd-gcp-v2.0.17","namespace":"kube-system"},"spec":{"template":{"metadata":{"annotations":{"scheduler.alpha.kubernetes.io/critical-pod":""},"labels":{"k8s-app":"fluentd-gcp","kubernetes.io/cluster-service":"true","version":"v2.0.17"}},"spec":{"containers":[{"env":[{"name":"FLUENTD_ARGS","value":"--no-supervisor -q"}],"Images":"gcr.io/google-containers/fluentd-gcp:2.0.17","livenessProbe":{"exec":{"command":["/bin/sh","-c","LIVENESS_THRESHOLD_SECONDS=\${LIVENESS_THRESHOLD_SECONDS:-300}; STUCK_THRESHOLD_SECONDS=\${LIVENESS_THRESHOLD_SECONDS:-900}; if [ ! -e /var/log/fluentd-buffers ]; then\n  exit 1;\nfi; LAST_MODIFIED_DATE=`stat /var/log/fluentd-buffers | grep Modify | sed -r \"s/Modify: (.*)/\\1/\"`; LAST_MODIFIED_TIMESTAMP=`date -d \"$LAST_MODIFIED_DATE\" +%s`; if [ `date +%s` -gt `expr $LAST_MODIFIED_TIMESTAMP + $STUCK_THRESHOLD_SECONDS` ]; then\n  rm -rf /var/log/fluentd-buffers;\n  exit 1;\nfi; if [ `date +%s` -gt `expr $LAST_MODIFIED_TIMESTAMP + $LIVENESS_THRESHOLD_SECONDS` ]; then\n  exit 1;\nfi;\n"]},"initialDelaySeconds":600,"periodSeconds":60},"name":"fluentd-gcp","resources":{"limits":{"memory":"300Mi"},"requests":{"cpu":"100m","memory":"200Mi"}},"volumeMounts":[{"mountPath":"/var/log","name":"varlog"},{"mountPath":"/var/lib/docker/containers","name":"varlibdockercontainers","readOnly":true},{"mountPath":"/host/lib","name":"libsystemddir","readOnly":true},{"mountPath":"/etc/fluent/config.d","name":"config-volume"}]},{"command":["/monitor","--stackdriver-prefix=container.googleapis.com/internal/addons","--api-override=https://monitoring.googleapis.com/","--source=fluentd:http://_NAMESPACE","valueFrom":{"fieldRef":{"fieldPath":"metadata.namespace"}}}],"Images":"gcr.io/google-containers/prometheus-to-sd:v0.2.2","name":"prometheus-to-sd-exporter"}],"dnsPolicy":"Default","nodeSelector":{"beta.kubernetes.io/fluentd-ds-ready":"true"},"serviceAccountName":"fluentd-gcp","terminationGracePeriodSeconds":30,"tolerations":[{"effect":"NoSchedule","key":"node.alpha.kubernetes.io/ismaster"},{"effect":"NoExecute","operator":"Exists"},{"effect":"NoSchedule","operator":"Exists"}],"volumes":[{"hostPath":{"path":"/var/log"},"name":"varlog"},{"hostPath":{"path":"/var/lib/docker/containers"},"name":"varlibdockercontainers"},{"hostPath":{"path":"/usr/lib64"},"name":"libsystemddir"},{"configMap":{"name":"fluentd-gcp-config-v1.2.3"},"name":"config-volume"}]}},"updateStrategy":{"type":"RollingUpdate"}}}
    creationTimestamp: 2018-07-03T04:43:57Z
    generation: 1
    labels:
    addonmanCreated onr.kubernetes.io/mode: Reconcile
    k8s-app: fluentd-gcp
    kubernetes.io/cluster-service: "true"
    version: v2.0.17
    name: fluentd-gcp-v2.0.17
    namespace: kube-system
                                    </pre>
                        </div>
                        <!--button class="btns colors4">Save</button>
                        <button class="btns colors5">Cancel</button>
                        <button class="btns colors9 pull-right maL05">copy</button>
                        <button class="btns colors9 pull-right">Download</button>
                        <div class="yamlArea">
                            <div class="number">1<br/>2<br/>3<br/>4<br/>5</div>
                            <div class="text">fff<br/>ddd<br/>dfff<br/>dddd<br/>ddd<br/>dfff<br/>dddd</div>
                            <div style="clear:both;"></div>
                        </div>
                        <button class="btns colors4">Save</button>
                        <button class="btns colors5">Cancel</button-->
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Services YAML 끝 -->
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

<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>

<!-- SyntexHighlighter -->
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shCore.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushCpp.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushCSharp.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushPython.js"/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shCore.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shThemeDefault.css"/>">

<script type="text/javascript">
    SyntaxHighlighter.defaults['quick-code'] = false;
    SyntaxHighlighter.all();
</script>

<style>
    .syntaxhighlighter .gutter .line{border-right-color:#ddd !important;}
</style>
<!-- SyntexHighlighter -->

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
    SERVICE 상세조회 :: SERVICE DETAIL
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
    <div id="resultAreaForPods" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted yellowgreen 4px;">
    </div>
    <div id="resultAreaForEndpoints" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted greenyellow 4px;">
    </div>
</div>
<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />

<script type="text/javascript">

    // GET DETAIL
    var getDetail = function() {
        var reqUrl = "<%= Constants.API_URL %>/services/" + document.getElementById('requestServiceName').value;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var serviceName;
        var endpointsPreString;
        var nodePort;
        var specPortsList;
        var specPortsListLength;
        var endpoints ="";
        var postfixString;
        var htmlString = [];

        serviceName = data.metadata.name;
        endpointsPreString = serviceName + "." + data.metadata.namespace + ":";
        nodePort = data.spec.ports.nodePort;

        if (nodePort === undefined) {
            nodePort = "0";
        }

        specPortsList = data.spec.ports;
        specPortsListLength = specPortsList.length;

        for (var i = 0; i < specPortsListLength; i++) {
            (i === specPortsListLength - 1) ? postfixString = "" : postfixString = ", ";

            endpoints += endpointsPreString + specPortsList[i].port + " " + specPortsList[i].protocol + ", "
                + endpointsPreString + nodePort + " " + specPortsList[i].protocol + postfixString;
        }

        htmlString.push("SERVICE DETAIL :: <br><br>");

        var selector = procSetSelector(data.spec.selector);

        htmlString.push(
            "name :: " + data.metadata.name + "<br>"
            + "namespace :: " + data.metadata.namespace + "<br>"
            + "creationTimestamp :: " + data.metadata.creationTimestamp + "<br>"
            + "Label selector :: " + selector + "<br>"
            + "type :: " + data.spec.type + "<br>"
            + "sessionAffinity :: " + data.spec.sessionAffinity + "<br>"
            + "clusterIP :: " + data.spec.clusterIP + "<br>"
            + "endpoints :: " + endpoints + "<br>");

        $('#resultArea').html(htmlString);
        getDetailForPods(selector);
    };


    // GET DETAIL
    var getDetailForPods = function(selector) {
        var reqUrl = "<%= Constants.API_URL %>/workload/namespaces/kube-system/pods/service/_all/" + selector;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPods);
    };


    // CALLBACK
    var callbackGetDetailForPods = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var items = data.items;
        var listLength = items.length;
        var htmlString = [];

        htmlString.push("POD LIST :: <br><br>");

        for (var i = 0; i < listLength; i++) {
            htmlString.push(
                "name :: " + items[i].metadata.name + " || "
                + "namespace :: " + items[i].metadata.namespace + " || "
                + "node :: " + items[i].spec.nodeName + " || "
                + "status :: " + items[i].status.phase + " || "
                + "restarts :: " + items[i].status.containerStatuses[0].restartCount + " || "
                + "creationTimestamp :: " + items[i].metadata.creationTimestamp
                + "<br><br>");
        }

        $('#resultAreaForPods').html(htmlString);
        getDetailForEndpoints();
    };


    // GET DETAIL
    var getDetailForEndpoints = function() {
        var reqUrl = "<%= Constants.API_URL %>/endpoints/" + document.getElementById('requestServiceName').value;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForEndpoints);
    };


    // CALLBACK
    var callbackGetDetailForEndpoints = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var items = data.subsets;
        var subsetsListLength = items.length;

        for (var i = 0; i < subsetsListLength; i++) {

            var addresses = items[i].addresses;
            var ports = items[i].ports;
            var listLength = addresses.length;
            var separatorString = ", ";
            var portsString = '';
            var nodeName = '';
            var htmlString = [];
            var nodeNameList = [];

            htmlString.push("ENDPOINT LIST :: <br><br>");

            for (var j = 0; j < listLength; j++) {
                var portName =  ports[j].name;
                var portNameString =  "[unset]";

                if (portName !== null) {
                    portNameString = portName;
                }

                portsString = portNameString + separatorString + ports[j].port + separatorString + ports[j].protocol;
                nodeName = addresses[j].nodeName;

                htmlString.push(
                    "host :: " + addresses[j].ip + " || "
                    + "ports :: " + portsString + " || "
                    + "node :: " + nodeName + " || "
                    + "ready :: " + "<span class='" + nodeName + "'></span>"
                    + "<br><br>");

                nodeNameList.push(nodeName)
            }
        }

        $('#resultAreaForEndpoints').html(htmlString);
        getDetailForNodes(nodeNameList);
    };


    // GET DETAIL
    var getDetailForNodes = function(nodeNameList) {
        var listLength = nodeNameList.length;
        var reqUrl;

        for (var i = 0; i < listLength; i++) {
            reqUrl = "<%= Constants.API_URL %>/nodes/" + nodeNameList[i];
            procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForNodes);
        }
    };


    // CALLBACK
    var callbackGetDetailForNodes = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var items = data.status.conditions;
        var conditionsListLength = items.length;

        for (var i = 0; i < conditionsListLength; i++) {
            if (items[i].type === "Ready") {
                $('.' + data.metadata.name).text(items[i].status);
            }
        }
    };


    // BIND
    $("#btnSearch").on("click", function() {
        getDetail();
    });


    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });


    // BIND
    $(".btnDetail").on("click", function() {
        var serviceName = this.value();
        alert("serviceName :: " + serviceName);
    });


    // ON LOAD
    $(document.body).ready(function () {
        // getDetail();
    });

</script>
