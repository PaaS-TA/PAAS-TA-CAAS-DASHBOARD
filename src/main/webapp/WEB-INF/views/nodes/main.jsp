<%--
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

    <%-- NODES SUMMARY :: BEGIN --%>
    <%@include file="summary.jsp" %>
    <%-- NODES SUMMARY :: END --%>

    <%-- NODES DETAIL :: BEGIN--%>
    <%@include file="detail.jsp" %>
    <%-- NODES DETAIL :: END --%>

    <%-- NODES EVENT :: BEGIN--%>
    <%@include file="event.jsp" %>
    <%-- NODES EVENT :: END --%>
</div>

<!-- modal -->
<div class="modal fade in" id="layerpop">
    <%-- layerpop is used nodes' detail --%>
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
    var getNode = function () {
        var urlSplits = window.location.href.replace(/\?.*/, '').split('/');
        var nodeName = urlSplits[urlSplits.length - 1];

        if (nodeName == null) {
            alert("Cannot get node name.");
            return;
        }

        var reqUrl = "<%= Constants.API_URL %>/nodes/" + nodeName;
        procCallAjax(reqUrl, "GET", null, null, callbackGetNode);
    }

    var callbackGetNode = function (data) {
        if (false == checkInvalidData(data)) {
            alert("Cannot load node info.");
            return;
        }

        var nodeName = data.metadata.name;

        callbackGetNodeSummary(nodeName, data.status.conditions);

        // TODO :: write logic for node detail
        //callbackGetNodeDetail(data);

        // TODO :: write logic for node event
        //callbackGetNodeEvent(data);
    }

    var callbackGetNodeSummary = function (nodeName, conditions) {
        // get pods, conditions
        var podsReqUrl = "<%= Constants.API_URL %>/workloads/pods/node/" + nodeName;

        // pod info : Name, Namespace, Node, Status, Restarts, Created on
        procCallAjax(podsReqUrl, "GET", null, null, callbackGetPods);

        // set conditions
        var contents = [];
        $.each(conditions, function (index, condition) {
            contents.push('<tr>'
                + '<td>' + condition.type + '</td>'
                + '<td>' + condition.status + '</td>'
                + '<td>' + condition.lastHeartbeatTime + '</td>'
                + '<td>' + condition.lastTransitionTime + '</td>'
                + '<td>' + condition.reason + '</td>'
                + '<td>' + condition.message + '</td></tr>');
        });

        // append conditions tbody
        $('#tbody_node_conditions').html(contents);
    }


    var callbackGetNodeDetail = function (data) {
        // TODO :: write logic
    }

    var callbackGetNodeEvent = function (data) {
        // TODO :: write logic
    }

    var callbackGetPods = function (data) {
        if (false == checkInvalidData(data)) {
            alert("Cannot load pods data");
            return;
        }

        var contents = [];
        $.each(data.items, function (index, podItem) {
            var pod = getPod(podItem);
            var nameHtml = '<span class="green2"><i class="fas fa-check-circle"></i></span><a href="/workload/pods/' + pod.name + '">' + pod.name + '</a>';
            contents.push('<tr>'
                + '<td>' + nameHtml + '</td>'
                + '<td>' + pod.namespace + '</td>'
                + '<td>' + pod.nodeName + '</td>'
                + '<td>' + pod.podStatus + '</td>'
                + '<td>' + pod.restartCount + '</td>'
                + '<td>' + pod.creationTimestamp + '</td></tr>');
        });

        // append pod tbody
        $('#tbody_node_pods').html(contents);
    }

    var getPod = function (podItem) {
        // required : name, namespace, node, status, restart(count), created on
        var _metadata = podItem.metadata;
        var _spec = podItem.spec;
        var _status = podItem.status;

        // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
        var pod = {
            name: _metadata.name,
            namespace: _metadata.namespace,
            nodeName: _spec.nodeName,
            podStatus: _status.phase,
            restartCount: processIfDataIsNull(
                _status.containerStatuses, function (data) {
                    return data.reduce(function (a, b) {
                        return {restartCount: a.restartCount + b.restartCount};
                    }, {restartCount: 0}).restartCount;
                }, 0),
            creationTimestamp: _metadata.creationTimestamp
        };

        return pod;
    }

    var checkInvalidData = function (data) {
        if (RESULT_STATUS_FAIL === data.resultCode) {
            console.log("ResultStatus :: " + data.resultCode + " / " + "ResultMessage :: " + data.resultMessage);
            return false;
        } else {
            return true;
        }
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
</script>

<script type="text/javascript">
    var loadLayerpop = function () {
        // MOVE LAYERPOP UNDER BODY ELEMENT
        var layerpop = $('#layerpop');
        layerpop.parent().find(layerpop).remove();
        $('body').append(layerpop);
    };

    // ON LOAD
    $(document.body).ready(function () {
        createChart("current", "cpu");
        createChart("current", "mem");
        createChart("current", "disk");

        loadLayerpop();

        getNode();
    });
</script>
