<%--
  Services main
  @author REX
  @version 1.0
  @since 2018.08.09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
        procCallAjax("/services/getList.do", "GET", null, null, callbackGetList);
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

        for (var i = 0; i < listLength; i++) {
            var tempSelectorList = selectorList[i].split(",");
            procCallAjax("/workload/pods/getListBySelector.do", "GET", {selector : tempSelectorList[0], serviceName : tempSelectorList[1]}, null, callbackGetDetailForPods);
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


    // BIND
    $(".btnDetail").on("click", function() {
        var serviceName = this.value();
        alert("serviceName :: " + serviceName);
    });


    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
