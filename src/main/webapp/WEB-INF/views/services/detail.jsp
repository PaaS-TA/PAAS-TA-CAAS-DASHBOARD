<%--
  Services detail
  @author REX
  @version 1.0
  @since 2018.08.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
        procCallAjax("/services/get.do", "GET", {serviceName : document.getElementById('requestServiceName').value}, null, callbackGetDetail);
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

        htmlString.push(
            "name :: " + data.metadata.name + "<br>"
            + "namespace :: " + data.metadata.namespace + "<br>"
            + "creationTimestamp :: " + data.metadata.creationTimestamp + "<br>"
            + "type :: " + data.spec.type + "<br>"
            + "sessionAffinity :: " + data.spec.sessionAffinity + "<br>"
            + "clusterIP :: " + data.spec.clusterIP + "<br>"
            + "endpoints :: " + endpoints + "<br>");

        $('#resultArea').html(htmlString);
    };


    // TODO
    // GET DETAIL
    var getDetailForPods = function() {
        // procCallAjax("/services/getPods.do", "GET", {serviceName : document.getElementById('requestServiceName').value}, null, callbackGetDetailForPods);
        procCallAjax("/services/get.do", "GET", {serviceName : document.getElementById('requestServiceName').value}, null, callbackGetDetailForPods);
    };


    // TODO
    // CALLBACK
    var callbackGetDetailForPods = function(data) {
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

        htmlString.push("SERVICE PODS DETAIL :: <br><br>");

        htmlString.push(
            "name :: " + data.metadata.name + "<br>"
            + "namespace :: " + data.metadata.namespace + "<br>"
            + "creationTimestamp :: " + data.metadata.creationTimestamp + "<br>"
            + "type :: " + data.spec.type + "<br>"
            + "sessionAffinity :: " + data.spec.sessionAffinity + "<br>"
            + "clusterIP :: " + data.spec.clusterIP + "<br>"
            + "endpoints :: " + endpoints + "<br>");

        $('#resultAreaForPods').html(htmlString);
    };


    // TODO
    // GET DETAIL
    var getDetailForEndpoints = function() {
        // procCallAjax("/services/getEndpoints.do", "GET", {serviceName : document.getElementById('requestServiceName').value}, null, callbackGetDetailForEndpoints);
        procCallAjax("/services/get.do", "GET", {serviceName : document.getElementById('requestServiceName').value}, null, callbackGetDetailForEndpoints);
    };


    // TODO
    // CALLBACK
    var callbackGetDetailForEndpoints = function(data) {
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

        htmlString.push("SERVICE ENDPOINTS DETAIL :: <br><br>");

        htmlString.push(
            "name :: " + data.metadata.name + "<br>"
            + "namespace :: " + data.metadata.namespace + "<br>"
            + "creationTimestamp :: " + data.metadata.creationTimestamp + "<br>"
            + "type :: " + data.spec.type + "<br>"
            + "sessionAffinity :: " + data.spec.sessionAffinity + "<br>"
            + "clusterIP :: " + data.spec.clusterIP + "<br>"
            + "endpoints :: " + endpoints + "<br>");

        $('#resultAreaForEndpoints').html(htmlString);
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
        getDetail();
        getDetailForPods();
        getDetailForEndpoints();
    });

</script>
