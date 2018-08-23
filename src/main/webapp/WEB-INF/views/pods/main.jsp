<%--
  Pod main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> nginx-2-6bd764c757-jhgnd (Pods 명)</h1>
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
                        </div>
                        <button class="btns colors4">Save</button>
                        <button class="btns colors5">Cancel</button-->
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
    POD 대시보드 :: PODS DASHBOARD
    <div style="padding: 10px;">
        <div style="padding: 5px;">
            <div style="padding: 5px;">
                <span>Namespace: </span>
                <input type="text" id="namespace">
                <span>&nbsp;&nbsp;&nbsp;//&nbsp;&nbsp;&nbsp;</span>
                <span>Pod name: </span>
                <input type="text" id="pod">
            </div>
            <button type="button" id="btnSearch"> [ 조회(None / NS / NS+Dep) ] </button>
            <button type="button" id="btnReset"> [ 목록 초기화 ] </button>
        </div>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted deepskyblue 4px;">
    </div>
</div>
<script type="text/javascript">
  var getAllPods = function(){
    // get all pod list
    procCallAjax("/workload/pods/_all/getList.do", "GET", null, null, callbackGetList);
  }

  var getPods = function() {
    // get pod list in namespace or pod detail
    // ex) get pod list ->  /workload/pods/default/getList.do
    // ex) get pod detail -> /workload/pods/default/getPod.do?podName=nginx-deployment-67594d6bf6-h5fh7
    var namespaceVal = $( "#namespace" ).val();
    var podVal = $( "#pod" ).val();
    if (false == ( namespaceVal != null && namespaceVal.replace(/\s/g, '').length > 0 ))
      namespaceVal = undefined;
    if (false == ( podVal != null && podVal.replace(/\s/g, '').length > 0 ))
      podVal = undefined;

    var reqUrl = "/workload/pods";

    if ( namespaceVal != null ) {
      reqUrl += "/" + namespaceVal;
      if ( podVal != null ) {
        reqUrl += "/getPod.do";
        var param = {
          podName: podVal
        }
        procCallAjax( reqUrl, "GET", param, null, callbackGetPod );
      } else {
        reqUrl += "/getList.do"
        procCallAjax( reqUrl, "GET", null, null, callbackGetList );
      }
    } else {
      procCallAjax( reqUrl + "/getList.do", "GET", null, null, callbackGetList );
    }
  }

  var stringifyJSON = function(obj) {
    return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=').replace(/\,/g, ', ');
  }

  var processIfDataIsNull = function (data, procCallback, defaultValue) {
    if (data == null)
      return defaultValue;
    else {
      if (procCallback == null)
        return defaultValue;
      else
        return procCallback( data );
    }
  }

  // CALLBACK
  var callbackGetList = function(data) {
    if (RESULT_STATUS_FAIL === data.resultCode) {
      $('#resultArea').html(
        "ResultStatus :: " + data.resultCode + " <br><br>"
        + "ResultMessage :: " + data.resultMessage + " <br><br>");
      return false;
    }

    console.log("CONSOLE DEBUG PRINT :: " + data);

    var htmlString = [];
    htmlString.push("PODS LIST :: <br><br>");
    htmlString.push( "ResultCode :: " + data.resultCode + " || "
      + "Message :: " + data.resultMessage + " <br><br>");

    //
    $.each(data.items, function(index, itemList) {
      // get data
      var _metadata = itemList.metadata;
      var _spec = itemList.spec;
      var _status = itemList.status;

      // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
      var podName = _metadata.name;
      var namespace = _metadata.namespace;
      var nodeName = _spec.nodeName;
      var podStatus = _status.phase;
      var restartCount = processIfDataIsNull( _status.containerStatuses,
        function ( data ) {
          return data.reduce( function ( a, b ) {
            return { restartCount: a.restartCount + b.restartCount };
          }, { restartCount: 0 } ).restartCount;
        }, 0 );
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
        + "<br><br>" );
    });

    //var $resultArea = $('#resultArea');
    $('#resultArea').html(htmlString);
  };

  var callbackGetPod = function(data) {
    if (RESULT_STATUS_FAIL === data.resultCode) {
      $('#resultArea').html(
        "ResultStatus :: " + data.resultCode + " <br><br>"
        + "ResultMessage :: " + data.resultMessage + " <br><br>");
      return false;
    }

    console.log("CONSOLE DEBUG PRINT :: " + data);

    // get data
    var _metadata = data.metadata;
    var _spec = data.spec;
    var _status = data.status;

    // required : name, namespace, labels, created time, status, QoS Class, Node, IP (host, internal network IP for pod), Conditions, Controllers, Volumes
    // QOS Class, IPs, Conditions, Controllers, Volumes -> null or undefined.
    var podName = _metadata.name;
    var namespace = _metadata.namespace;
    var labels = stringifyJSON(_metadata.labels);
    var creationTimestamp = _metadata.creationTimestamp;
    var status = _status.phase;
    var nodeName = _spec.nodeName;
    var qosClass = processIfDataIsNull(_status.qosClass, null, "None");
    var ips = stringifyJSON({
      hostIP: processIfDataIsNull(_status.hostIP, null, "Not allocated"),
      podIP: processIfDataIsNull(_status.podIP, null, "Not allocated")
    });
    var conditions = processIfDataIsNull( _status.conditions, function ( data ) {
      return data.map( function ( value ) {
        return value.type + ": " + value.status;
      } );
    }, "Unknown status of condition(s)" );
    var controllers = processIfDataIsNull(_metadata.ownerReferences, function (data) {
      return _metadata.ownerReferences.filter( function ( value ) {
        return value.controller == true;
      } ).reduce( function ( a, b ) {
        a[ b.type ] = b.name;
      }, {} );
    }, "None");
    var volumes = processIfDataIsNull(_spec.volumes, function(data) {
      return stringifyJSON(data.map(function (value) { return value.name; }));
    }, "None");
    var errorMessage = "";

    // htmlString push
    var htmlString = [];
    htmlString.push("Name :: " + podName + " <br><br>"
      + "Namespace :: " + namespace + " <br><br>"
      + "Labels :: " + labels + " <br><br>"
      + "Created At :: " + creationTimestamp + " <br><br>"
      + "Status :: " + status + " <br><br>"
      + "QOS Class :: " + qosClass + " <br><br>"
      + "Node :: " + nodeName + " <br><br>"
      + "IP :: " + ips + " <br><br>"
      + "Conditions :: " + conditions + " <br><br>"
      + "Controllers :: " + controllers + " <br><br>"
      + "Volumes :: " + volumes + " <br><br>"
      + "Error message :: " + errorMessage + "<br><br>" );

    //var $resultArea = $('#resultArea');
    $('#resultArea').html(htmlString);
  }


  // BIND
  $("#btnReset").on("click", function() {
    $('#resultArea').html("");
  });

  // ALREADY READY STATE
  $(document).ready(function(){
    $("#btnAllSearch").on("click", function (e) {
      getAllPods();
    });

    $("#btnSearch").on("click", function (e) {
      getPods();
    });
  });

  // ON LOAD
  $(document.body).ready(function () {
      // getAllPods();
  });

</script>
