<%--
  PersistentVloume main
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> oracle-test-pv (Volumes_sample)</h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on">Details</li>
            <li name="tab02" class="cluster_tabs_right">YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Details 시작 -->
    <div class="cluster_content01 row two_line two_view harf_view">
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
                                <td>kube-flannel-ds</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td><span class="bg_gray">type : oracle-test</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td>Available</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Claim</th>
                                <td>-</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Reclaim policy</th>
                                <td>Recycle</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Access modes</th>
                                <td>ReadWriteOnce</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Reason</th>
                                <td>-</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Message</th>
                                <td>-</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_second_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Source</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Path</th>
                                <td>/home/rex/hyerin</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_third_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Capacity</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style="width:50%;">
                                <col style="width:50%;">
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Resource name</th>
                                <td>Quantity</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Storage</td>
                                <td>100 Mi</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Details 끝 -->
    <!-- YAML 시작-->
    <div class="cluster_content02 row two_line two_view">
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
                                <th><i class="cWrapDot"></i> 인스턴스 수 설정
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
                                <th><i class="cWrapDot"></i> CPU 임계 값 설정
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
                                <th><i class="cWrapDot"></i> 메모리 사이즈 설정
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
                                <th><i class="cWrapDot"></i> 시간 설정</th>
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


<%--TODO :: REMOVE--%>
<div style="padding: 10px;">
    <div id="headText">PERSISTENT VOLUME :: PERSISTENT VLOUME <span id="headTextType">LIST</span></div>
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
    <div id="resultAreaForSource" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted yellowgreen 4px;">
    </div>
    <div id="resultAreaForCapacity" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted greenyellow 4px;">
    </div>
</div>
<script type="text/javascript">

    // GET LIST
    var getList = function() {
        procCallAjax("/clusters/api/persistentvolumes", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        console.log(data);

        var $resultArea = $('#resultArea');

        $resultArea.append("PERSISTENT-VOLUME LIST :: <br><br>");

//  name            metadata.name
//  Capacity        spec.capacity.storage  (key-storage말고 value만 노출 다시 확인필요)
//  Access Modes    spec.accessModes
//  Reclaim policy  spec.persistentVolumeReclaimPolicy
//  Claim          -- 역으로 검색 필요
//  storage class   spec.storageClassName
//  reason         -- 못찾음
//  created on      --metadata.creationTimestamp

        $.each(data.items, function (index, itemList) {

            var pvName = itemList.metadata.name;
            var capacity = JSON.stringify(itemList.spec.capacity);
            var accessModes = itemList.spec.accessModes;
            var reclaimPolicy = itemList.spec.persistentVolumeReclaimPolicy;
            var claim = "";
            var storageClass = nvl(itemList.spec.storageClassName);
            var reason = "";
            var creationTimestamp = itemList.metadata.creationTimestamp;

            //var images = new Array;

//            var containers = itemList.spec.template.spec.containers;
//            for(var i=0; i < containers.length; i++){
//                images.push(containers[i].image);
//            }

            $resultArea.append("<a href='javascript:void(0);'><span style='color: orangered;'>[ DETAIL ]</span></a>"
                    + "Name :: " + pvName + " || "
                    + "Capacity :: " + capacity + " || "
                    + "Access Modes :: " + accessModes + " || "
                    + "reclaimPolicy :: " + reclaimPolicy+ " || "
                    + "claim :: " + claim+ " || "
                    + "storageClass :: " + storageClass+ " || "
                    + "reason :: " + reason+ " || "
                    + "Created on :: " + creationTimestamp
                    + "<br><br>");

            $(document).on( "click", "#resultArea a:eq("+index+")" ,function(e){
                getDetail(pvName);
            });

        });

    };

    // GET LIST
    var getDetail = function(pvName) {
        procCallAjax("/clusters/persistentvolumes/"+pvName, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        console.log(data);
        // Detail init
        $('#headTextType').text("DETAIL");
        $('#btnSearch').hide();
        $('#btnReset').hide();


        var $resultArea = $('#resultArea');

        $resultArea.html("");
        $resultArea.append("PERSISTENT-VOLUME DETAIL :: <br><br>");

//        -- detail
//        Name             metadata.name
//        Labels           metadata.labels
//        Creation Time    metadata.creationTimestamp
//        status           status.phase
//        Claim            -
//        Reclaim policy   spec.persistentVolumeReclaimPolicy
//        Access modes     spec.accessModes
//        Storage class    spec.storageClassName
//        Reason           -
//        Message          -

        var pvName = data.metadata.name;
        var labels = JSON.stringify(data.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
        var creationTimestamp = data.metadata.creationTimestamp;
        var status = data.status.phase;
        var claim = "";
        //optional 항목에만 nvl적용
        var reclaimPolicy   = nvl(data.spec.persistentVolumeReclaimPolicy);
        var accessModes     = nvl(data.spec.accessModes)
        var storageClass    = nvl(data.spec.storageClassName);
        var reason = "";
        var message = "";

        $resultArea.append(
                  "Name :: " + pvName + "<br>"
                + "Labels :: " + labels+ "<br>"
                + "Creation Time :: " + creationTimestamp + "<br>"
                + "Status :: " + status+ "<br>"
                + "Claim :: " + claim+ "<br>"
                + "Reclaim policy:: " + reclaimPolicy+ "<br>"
                + "accessModes :: " + accessModes+ "<br>"
                + "storageClass :: " + storageClass+ "<br>"
                + "reason :: " + reason+ "<br>"
                + "message :: " + message
                + "<br><br>");


        // Get Source
        //        Path    spec.hostPath.path
        var $resultAreaForSource = $('#resultAreaForSource');
        $resultAreaForSource.show();

        $resultAreaForSource.html("");
        $resultAreaForSource.append("Source :: <br><br>");

        var sourcePath = data.spec.hostPath.path;

        $resultAreaForSource.append(
                "Path :: " + sourcePath
                + "<br><br>");

        // Capacity (List)
        //        Resource name  storage     spec.capacity. key
        //        Quantity       100M        spec.capacity. value
        var $resultAreaForCapacity = $('#resultAreaForCapacity');
        $resultAreaForCapacity.show();

        $resultAreaForCapacity.html("");
        $resultAreaForCapacity.append("Capacity :: <br><br>");

        var capacity = data.spec.capacity;

        var headerHtml = "<tr><td style='padding-right: 30px;'>Resource name</td><td>Quantity</td></tr>";

        $resultAreaForCapacity.append("<table frame=void>")
        var count  = 0;
        for(var key in capacity){
            if( count == 0){
                $resultAreaForCapacity.append(headerHtml);
                count++;
            }

            $resultAreaForCapacity.append(
                    "<tr align='center'>" +
                    "<td>"+key+"</td>" +
                    "<td>"+capacity[key]+"</td>" +
                    "</tr>"
            );
        }
        $resultAreaForCapacity.append("</table>")

    };

    // BIND
    $("#btnSearch").on("click", function() {
        getList();
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
        // getList();
    });

</script>
