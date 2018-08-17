<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div style="padding: 10px;">
    NODE 대시보드 :: NODE LIST
    <div style="padding: 10px;">
        <div style="padding: 5px;">
            <div style="padding: 5px;">
                <span>Node: </span>
                <input type="text" id="node">
            </div>
            <button type="button" id="btnSearch"> [ 조회 ] </button>
            <button type="button" id="btnReset"> [ 목록 초기화 ] </button>
        </div>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted deepskyblue 4px;">
    </div>
</div>
<script type="text/javascript">
  function getNodes() {
    var nodeNameVal = $( "#node" ).val();
    if (false == ( nodeNameVal != null && nodeNameVal.replace(/\s/g, '').length > 0 ))
      nodeNameVal = undefined;

    var reqUrl = "/nodes";

    if ( nodeNameVal != null ) {
      var param = {
        nodeName: nodeNameVal
      }
      procCallAjax( reqUrl + "/get.do", "GET", param, null, callbackGetNode );
    } else {
      procCallAjax( reqUrl + "/getList.do", "GET", null, null, callbackGetListNodes );
    }
  }

  /*
  var stringifyJSON = function(obj) {
    return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
  }
  */

  var convertByte = function(capacity) {
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

  var formatCapacity = function(capacity, unit) {
    var unitSize;
    if (unit == null || "" == unit)
      unitSize = 1;
    else {
      if (unit === "Ki")    unitSize = 1024
      if (unit === "Mi")    unitSize = Math.pow(1024, 2);
      if (unit === "Gi")    unitSize = Math.pow(1024, 3);
    }

    return ((capacity / unitSize).toFixed(2) + ' ' + unit);
  }

  // CALLBACK
  var callbackGetListNodes = function(data) {
    console.log("CONSOLE DEBUG PRINT :: " + data);

    var htmlString = [];
    htmlString.push("NODES LIST :: <br><br>");
    htmlString.push( "ResultCode :: " + data.resultCode + " || "
      + "Message :: " + data.resultMessage + " <br><br>");

    if (RESULT_STATUS_FAIL === data.resultCode) {
      $('#resultArea').html(htmlString);
      return false;
    }

    // get data
    $.each(data.items, function(index, itemList) {
      var _metadata = itemList.metadata;
      var _status = itemList.status;

      var name = _metadata.name;
      var ready = _status.conditions.filter(function(condition) {
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
        + "CreationTimestamp :: " + creationTimestamp + "<br><br>" );
    });

    // finally
    $('#resultArea').html(htmlString);
  }

  var callbackGetNode = function(data) {
    console.log("CONSOLE DEBUG PRINT :: " + data);

    var htmlString = [];
    htmlString.push("NODE DETAIL :: <br><br>");
    htmlString.push( "ResultCode :: " + data.resultCode + " || "
      + "Message :: " + data.resultMessage + " <br><br>");

    if (RESULT_STATUS_FAIL === data.resultCode) {
      $('#resultArea').html(htmlString);
      return false;
    }

    // get datum
    var _metadata = data.metadata;
    var _status = data.status;

    var name = _metadata.name;
    var ready = _status.conditions.filter(function(condition) {
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
      + "CreationTimestamp :: " + creationTimestamp + "<br><br>" );

    // finally
    $('#resultArea').html(htmlString);
  }

  // BIND
  $("#btnReset").on("click", function() {
    $('#resultArea').html("");
  });

  // ALREADY READY STATE
  $(document).ready(function(){
    $("#btnSearch").on("click", function (e) {
      getNodes();
    });
  });

  // ON LOAD
  $(document.body).ready(function () {
      getNodes();
  });

</script>
