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

        var selector = JSON.stringify(data.spec.selector).replace(/["{}]/g, '').replace(/:/g, '=');

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
    var getDetailForPods = function(reqSelector) {
        procCallAjax("/workload/pods/getListBySelector.do", "GET", {selector : reqSelector}, null, callbackGetDetailForPods);
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
    };


    // GET DETAIL
    var getDetailForEndpoints = function() {
        procCallAjax("/endpoints/get.do", "GET", {serviceName : document.getElementById('requestServiceName').value}, null, callbackGetDetailForEndpoints);
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
                    + "ready :: " + "<span id='" + nodeName + "'></span>"
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

        for (var i = 0; i < listLength; i++) {
            procCallAjax("/nodes/get.do", "GET", {nodeName : nodeNameList[i]}, null, callbackGetDetailForNodes);
        }
    };


    // CALLBACK
    var callbackGetDetailForNodes = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var items = data.status.conditions;
        var conditionsListLength = items.length;

        for (var i = 0; i < conditionsListLength; i++) {
            if (items[i].type === "Ready") {
                $('#' + data.metadata.name).text(items[i].status);
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
        getDetail();
        getDetailForEndpoints();
    });

</script>
