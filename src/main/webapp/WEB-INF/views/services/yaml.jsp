<%--
  Services yaml
  @author REX
  @version 1.0
  @since 2018.08.28
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <span class="resultServiceName"><c:out value='${serviceName}' default='' /></span></h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_left" onclick='movePage("detail");'>Details</li>
            <li name="tab02" class="cluster_tabs_left" onclick='movePage("events");'>Events</li>
            <li name="tab03" class="cluster_tabs_on custom_cursor_default">YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Services YAML 시작-->
    <div class="cluster_content03 row two_line two_view harf_view custom_display_block">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>YAML</p>
                    </div>
                    <div class="paA30">
                        <div class="yaml">
                                    <pre class="brush: yaml" id="resultArea"> -
<%--apiVersion: extensions/v1beta1--%>
<%--kind: DaemonSet--%>
<%--metadata:--%>
    <%--annotations:--%>
    <%--kubectl.kubernetes.io/last-applied-Config: |--%>
        <%--{"apiVersion":"extensions/v1beta1","kind":"DaemonSet","metadata":{"annotations":{},"labels":{"addonmanCreated onr.kubernetes.io/mode":"Reconcile","k8s-app":"fluentd-gcp","kubernetes.io/cluster-service":"true","version":"v2.0.17"},"name":"fluentd-gcp-v2.0.17","namespace":"kube-system"},"spec":{"template":{"metadata":{"annotations":{"scheduler.alpha.kubernetes.io/critical-pod":""},"labels":{"k8s-app":"fluentd-gcp","kubernetes.io/cluster-service":"true","version":"v2.0.17"}},"spec":{"containers":[{"env":[{"name":"FLUENTD_ARGS","value":"--no-supervisor -q"}],"Images":"gcr.io/google-containers/fluentd-gcp:2.0.17","livenessProbe":{"exec":{"command":["/bin/sh","-c","LIVENESS_THRESHOLD_SECONDS=\${LIVENESS_THRESHOLD_SECONDS:-300}; STUCK_THRESHOLD_SECONDS=\${LIVENESS_THRESHOLD_SECONDS:-900}; if [ ! -e /var/log/fluentd-buffers ]; then\n  exit 1;\nfi; LAST_MODIFIED_DATE=`stat /var/log/fluentd-buffers | grep Modify | sed -r \"s/Modify: (.*)/\\1/\"`; LAST_MODIFIED_TIMESTAMP=`date -d \"$LAST_MODIFIED_DATE\" +%s`; if [ `date +%s` -gt `expr $LAST_MODIFIED_TIMESTAMP + $STUCK_THRESHOLD_SECONDS` ]; then\n  rm -rf /var/log/fluentd-buffers;\n  exit 1;\nfi; if [ `date +%s` -gt `expr $LAST_MODIFIED_TIMESTAMP + $LIVENESS_THRESHOLD_SECONDS` ]; then\n  exit 1;\nfi;\n"]},"initialDelaySeconds":600,"periodSeconds":60},"name":"fluentd-gcp","resources":{"limits":{"memory":"300Mi"},"requests":{"cpu":"100m","memory":"200Mi"}},"volumeMounts":[{"mountPath":"/var/log","name":"varlog"},{"mountPath":"/var/lib/docker/containers","name":"varlibdockercontainers","readOnly":true},{"mountPath":"/host/lib","name":"libsystemddir","readOnly":true},{"mountPath":"/etc/fluent/config.d","name":"config-volume"}]},{"command":["/monitor","--stackdriver-prefix=container.googleapis.com/internal/addons","--api-override=https://monitoring.googleapis.com/","--source=fluentd:http://_NAMESPACE","valueFrom":{"fieldRef":{"fieldPath":"metadata.namespace"}}}],"Images":"gcr.io/google-containers/prometheus-to-sd:v0.2.2","name":"prometheus-to-sd-exporter"}],"dnsPolicy":"Default","nodeSelector":{"beta.kubernetes.io/fluentd-ds-ready":"true"},"serviceAccountName":"fluentd-gcp","terminationGracePeriodSeconds":30,"tolerations":[{"effect":"NoSchedule","key":"node.alpha.kubernetes.io/ismaster"},{"effect":"NoExecute","operator":"Exists"},{"effect":"NoSchedule","operator":"Exists"}],"volumes":[{"hostPath":{"path":"/var/log"},"name":"varlog"},{"hostPath":{"path":"/var/lib/docker/containers"},"name":"varlibdockercontainers"},{"hostPath":{"path":"/usr/lib64"},"name":"libsystemddir"},{"configMap":{"name":"fluentd-gcp-config-v1.2.3"},"name":"config-volume"}]}},"updateStrategy":{"type":"RollingUpdate"}}}--%>
    <%--creationTimestamp: 2018-07-03T04:43:57Z--%>
    <%--generation: 1--%>
    <%--labels:--%>
    <%--addonmanCreated onr.kubernetes.io/mode: Reconcile--%>
    <%--k8s-app: fluentd-gcp--%>
    <%--kubernetes.io/cluster-service: "true"--%>
    <%--version: v2.0.17--%>
    <%--name: fluentd-gcp-v2.0.17--%>
    <%--namespace: kube-system--%>
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
<%--TODO--%>
<!-- modal -->

<div id="hiddenResultArea" style="display: none;"></div>

<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />


<%--TODO : REMOVE--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>--%>

<!-- SyntexHighlighter -->
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shCore.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushYaml.js"/>"></script>
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
        // createChart("current", "cpu");
        // createChart("current", "mem");
        // createChart("current", "disk");
    });
</script>


<script type="text/javascript">

    // TODO :: REMOVE
    var tempNamespace = "<%= Constants.NAMESPACE_NAME %>";

    // GET DETAIL
    var getDetail = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %>/namespaces/" + tempNamespace + "/services/" + document.getElementById('requestServiceName').value;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        $('#resultArea').html('---\n' + data.sourceTypeYaml);

        viewLoading('hide');
    };


    // MOVE PAGE
    var movePage = function(requestPage) {
        var reqUrl = '<%= Constants.CAAS_BASE_URL %>/services/' + document.getElementById('requestServiceName').value;

        if (requestPage.indexOf('detail') < 0) {
            reqUrl += '/' + requestPage;
        }

        procMovePage(reqUrl);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
