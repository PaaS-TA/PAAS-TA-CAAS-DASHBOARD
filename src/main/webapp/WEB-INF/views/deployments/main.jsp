<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> nginx-2-6bd764c757-jhgnd (Deployment명)</h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on">Details</li>
            <li name="tab02" class="cluster_tabs_right">Events</li>
            <li name="tab03" class="cluster_tabs_right yamlTab">YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Details 시작-->
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
                                <td>kube-flannel-ds</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td>default</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td><span class="bg_gray">app : nginx-2</span> <span class="bg_gray">tier: node</span></td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td>
                                    <span class="bg_gray">deprecated.daemonset.template.generation: 1</span>
                                    <span class="bg_blue"><a href="#">kubectl.kubernetes.io/last-applied-Config</a></span>
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Selector</th>
                                <td><span class="bg_gray">app : nginx-2</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Strategy</th>
                                <td>RollingUpdate</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Min ready seconds</th>
                                <td>0</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Revision history limit</th>
                                <td>10</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Rolling update strategy</th>
                                <td>Max surge: 25%, Max unavailable: 25%</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td>1 updated, 1 total, 1 available, 0 unavailable</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Replica Set 시작 -->
            <li class="cluster_third_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Replica Set</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Images</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                     <a href="#"><span class="green2"><i class="fas fa-check-circle"></i></span> portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            <tr>
                                <td>
                                     <a href="#"><span class="green2"><i class="fas fa-check-circle"></i></span> portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Replica Set 끝 -->
            <!-- Horizontal Pod Autoscaler 시작 -->
            <!--li class="cluster_fifth_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Horizontal Pod Autoscaler</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style="*">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><i class="cWrapDot"></i> Name</th>
                                    <td>nginx-2-hpa</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Min replicas</th>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Max replicas</th>
                                    <td>3</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Metric</th>
                                    <td>CPU Utilization</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Current/Target value</th>
                                    <td>0%/80%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li-->
            <!-- Horizontal Pod Autoscaler 끝 -->
            <!-- Pods 시작 -->
            <li class="cluster_sixth_box maB50">
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
                                    <span class="red2"><i class="fas fa-exclamation-circle"></i></span> portal-api-deployment<br/>
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
                                     <span class="green2"><i class="fas fa-check-circle"></i></span> portal-api-deployment
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
        </ul>
    </div>
    <!-- Details  끝 -->
    <!-- Events 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
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
                                <td>Created pod: aa-57cff4f9df-xcstf
                                </td>
                                <td>replicaset-controller
                                </td>
                                <td>-
                                </td>
                                <td>1
                                </td>
                                <td>2018-07-08 18:31:01
                                </td>
                                <td>2018-07-09 18:31:01
                                </td>
                            </tr>
                            <tr>
                                <td>Created pod: aa-57cff4f9df-xcstf
                                </td>
                                <td>replicaset-controller
                                </td>
                                <td>-
                                </td>
                                <td>1
                                </td>
                                <td>2018-07-08 18:31:01
                                </td>
                                <td>2018-07-09 18:31:01
                                </td>
                            </tr>
                            <tr>
                                <td>Created pod: aa-57cff4f9df-xcstf
                                </td>
                                <td>replicaset-controller
                                </td>
                                <td>-
                                </td>
                                <td>1
                                </td>
                                <td>2018-07-08 18:31:01
                                </td>
                                <td>2018-07-09 18:31:01
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Events 끝 -->
    <!-- YAML 시작-->
    <div class="cluster_content03 row two_line two_view">
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
                        </div
                        <button class="btns colors4">Save</button>
                        <button class="btns colors5">Cancel</button>-->
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- YAML 끝 -->
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
    DEPLOYMENT 대시보드 :: DEPLOYMENT DASHBOARD
    <div style="padding: 10px;">
        <div style="padding: 5px;">
            <div style="padding: 5px;">
                <span>Namespace: </span>
                <input type="text" id="namespace">
                <span>&nbsp;&nbsp;&nbsp;//&nbsp;&nbsp;&nbsp;</span>
                <span>Deployment: </span>
                <input type="text" id="deployment">
            </div>
            <button type="button" id="btnSearch"> [ 조회(None / NS / NS+Dep) ] </button>
            <button type="button" id="btnReset"> [ 목록 초기화 ] </button>
        </div>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted deepskyblue 4px;">
    </div>
    <h1>Replica Set</h1>
    <div id="replicaArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted deepskyblue 4px;">
    </div>
    <h1>Pod</h1>
    <div id="podArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted deepskyblue 4px;">
    </div>

</div>
<script type="text/javascript">
  var getAllDeployments = function () {
    procCallAjax("/workloads/deployments/getList.do", "GET", null, null, callbackGetList);
  }

  var getDeployments = function () {
    var namespaceVal = $("#namespace").val();
    var deploymentVal = $("#deployment").val();
    if (false == (namespaceVal != null && namespaceVal.replace(/\s/g, '').length > 0))
      namespaceVal = undefined;
    if (false == (deploymentVal != null && deploymentVal.replace(/\s/g, '').length > 0))
      deploymentVal = undefined;

    var reqUrl = "/workloads/deployments";

    if (namespaceVal != null) {
      reqUrl += "/" + namespaceVal;
      if (deploymentVal != null) {
        reqUrl += "/getDeployment.do";
        var param = {
          name: deploymentVal
        }
        procCallAjax(reqUrl, "GET", param, null, callbackGetDeployment);
      } else {
        reqUrl += "/getList.do"
        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
      }
    } else {
      procCallAjax(reqUrl + "/getList.do", "GET", null, null, callbackGetList);
    }
  }

  var stringifyJSON = function (obj) {
    return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
  }

  // CALLBACK
  var callbackGetList = function (data) {
    if (RESULT_STATUS_FAIL === data.resultCode) {
      $('#resultArea').html(
          "ResultStatus :: " + data.resultCode + " <br><br>"
          + "ResultMessage :: " + data.resultMessage + " <br><br>");
      return false;
    }

    console.log("CONSOLE DEBUG PRINT :: " + data);

    var htmlString = [];
    htmlString.push("DEPLOYMENTS LIST :: <br><br>");
    htmlString.push("ResultCode :: " + data.resultCode + " || "
        + "Message :: " + data.resultMessage + " <br><br>");

    //
    $.each(data.items, function (index, itemList) {
      // get data
      var _metadata = itemList.metadata;
      var _spec = itemList.spec;
      var _status = itemList.status;

      var deployName = _metadata.name;
      var namespace = _metadata.namespace;
      var labels = stringifyJSON(_metadata.labels).replace(/,/g, ', ');
      if (labels == null || labels == "null") {
        labels = "None"
      }

      var creationTimestamp = _metadata.creationTimestamp;

      // Set replicas and total Pods are same.
      var totalPods = _spec.replicas;
      var runningPods = totalPods - _status.unavailableReplicas;
      var failPods = _status.unavailableReplicas;
      var images = _spec.images;

      // htmlString push
      htmlString.push("Name :: " + deployName + " || "
          + "Namespace :: " + namespace + " || "
          + "Labels :: " + labels + " || "
          + "CreationTimestamp :: " + creationTimestamp + " || "
          + "Pods :: " + runningPods + "/" + totalPods + " || "
          + "Images :: " + images
          + "<br><br>");
    });

    //var $resultArea = $('#resultArea');
    $('#resultArea').html(htmlString);
  };

  var callbackGetDeployment = function (data) {
    if (RESULT_STATUS_FAIL === data.resultCode) {
      $('#resultArea').html(
          "ResultStatus :: " + data.resultCode + " <br><br>"
          + "ResultMessage :: " + data.resultMessage + " <br><br>");
      return false;
    }

    console.log("CONSOLE DEBUG PRINT :: " + data);

    var htmlString = [];
    htmlString.push("DEPLOYMENTS LIST :: <br><br>");
    htmlString.push("ResultCode :: " + data.resultCode + " || "
        + "Message :: " + data.resultMessage + " <br><br>");

    // get data
    var _metadata = data.metadata;
    var _spec = data.spec;
    var _status = data.status;

    /* Deployment detail is under...
     * - name
     * - namespace
     * - labels
     * - annotations
     * - creation time
     * - selector
     * - strategy (Pod deploy strategy)
     * - min ready seconds
     * - revision history limit
     * - Rolling update strategy detail (maxSurge, maxUnavailable)
     * - Replica status (updated, total, available, unavailable)
     */
    var deployName = _metadata.name;
    var namespace = _metadata.namespace;
    var labels = stringifyJSON(_metadata.labels).replace(/,/g, ', ');
    var annotations = stringifyJSON(_metadata.annotations);
    var creationTimestamp = _metadata.creationTimestamp;

    var selector = stringifyJSON(_spec.selector);
    var strategy = _spec.strategy.type;
    var minReadySeconds = _spec.minReadySeconds;
    var revisionHistoryLimit = _spec.revisionHistoryLimit;
    var rollingUpdateStrategy =
        "Max surge: " + _spec.strategy.rollingUpdate.maxSurge + ", "
        + "Max unavailable: " + _spec.strategy.rollingUpdate.maxUnavailable;
    var images = _spec.images;

    var updatedReplicas = _status.updatedReplicas;
    var totalReplicas = _status.replicas;
    var availableReplicas = _status.availableReplicas;
    var unavailableReplicas = _status.unavailableReplicas;
    var replicaStatus = updatedReplicas + " updated, "
        + totalReplicas + " total, "
        + availableReplicas + " available, "
        + unavailableReplicas + " unavailable.";

    // htmlString push
    htmlString.push(
        "Deploy name :: " + deployName + " <br><br>"
        + "Namespace :: " + namespace + " <br><br>"
        + "Labels :: " + labels + " <br><br>"
        + "Annotations :: " + annotations + " <br><br>"
        + "Creation Time :: " + creationTimestamp + " <br><br>"
        + "Selector :: " + selector + " <br><br>"
        + "Images :: " + images + " <br><br>"
        + "Strategy :: " + strategy + " <br><br>"
        + "Min ready seconds :: " + minReadySeconds + " <br><br>"
        + "Revision history limit :: " + revisionHistoryLimit + " <br><br>"
        + "Rolling update strategy :: " + rollingUpdateStrategy + " <br><br>"
        + "Status(Replica) :: " + replicaStatus + "<br><br>");

    //var $resultArea = $('#resultArea');
    $('#resultArea').html(htmlString);

    procCallAjax( "/workloads/namespaces/"+ namespace + "/replicasets/resource/" + hoho(labels), "GET", null, null, callbackGetReplicasetList);
    procCallAjax( "/api/workloads/namespaces/"+ namespace + "/pods/resource/" + hoho(labels), "GET", null, null, callbackGetPodsList);
  }


  var hoho = function (data) {
    return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D');
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


  // CALLBACK
  var callbackGetReplicasetList = function (data) {
    console.log("히히 드러와땅!");
    if (RESULT_STATUS_FAIL === data.resultStatus) return false;

    console.log(data);

    var $resultArea = $('#replicaArea');

    // TODO :: RESET HTML AREA
    $resultArea.html("");
    $resultArea.append("REPLICASET LIST :: <br><br>");

    //-- Replica Set List
    //items
    //metadata.name
    //metadata.namespace
    //metadata.labels
    //status.replicas
    //metadata.creationTimestamp
    //spec.containers.image

    $.each(data.items, function (index, itemList) {

      var replicasetName = itemList.metadata.name;
      var namespace = itemList.metadata.namespace;
      var labels = JSON.stringify(itemList.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
      var creationTimestamp = itemList.metadata.creationTimestamp;
      var replicas = itemList.status.replicas;   //  TOBE ::  current / desired
      var images = new Array;

      var containers = itemList.spec.template.spec.containers;
      for (var i = 0; i < containers.length; i++) {
        images.push(containers[i].image);
      }

      $resultArea.append("<a href='javascript:void(0);'><span style='color: orangered;'>[ DETAIL ]</span></a>"
          + "Name :: " + replicasetName + " || "
          + "Namespace :: " + namespace + " || "
          + "Labels :: " + labels + " || "
          + "Pods :: " + replicas + " || "
          + "Created on :: " + creationTimestamp + " || "
          + "Images :: " + images.join(",")
          + "<br><br>");

      $(document).on("click", "#resultArea a:eq(" + index + ")", function (e) {
        getDetail(replicasetName);
      });

    });

  };


  var callbackGetPodsList = function (data) {
      if (RESULT_STATUS_FAIL === data.resultCode) {
          $('#podArea').html(
              "ResultStatus :: " + data.resultCode + " <br><br>"
              + "ResultMessage :: " + data.resultMessage + " <br><br>");
          return false;
      }

      console.log("CONSOLE DEBUG PRINT :: " + data);

      var htmlString = [];
      htmlString.push("PODS LIST :: <br><br>");
      htmlString.push("ResultCode :: " + data.resultCode + " || "
          + "Message :: " + data.resultMessage + " <br><br>");

      //
      $.each(data.items, function (index, itemList) {
          // get data
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
          //var restartCount = _status.containerStatuses
          //  .map(function(datum) { return datum.restartCount; })
          //  .reduce(function(a, b) { return a + b; }, 0 );

          var creationTimestamp = _metadata.creationTimestamp;
          // error message will be filtering from namespace's event. a variable value is like...
          //var errorMessage = _status.error.message;
          var errorMessage = "";

          // htmlString push
          htmlString.push("Name :: " + podName + " || "
              + "Namespace :: " + namespace + " || "
              + "Node :: " + nodeName + " || "
              + "Status :: " + podStatus + " || "
              + "Restart Count :: " + restartCount + " || "
              + "Created At :: " + creationTimestamp + " || "
              + "Error message :: " + errorMessage
              + "<br><br>");
      });

      //var $resultArea = $('#resultArea');
      $('#podArea').html(htmlString);
  };


  // BIND
  $("#btnReset").on("click", function () {
    $('#resultArea').html("");
  });

  // ALREADY READY STATE
  $(document).ready(function () {
    $("#btnSearch").on("click", function (e) {
      getDeployments();
    });
  });

  // ON LOAD
  $(document.body).ready(function () {
    // getAllDeployments();
  });
</script>
