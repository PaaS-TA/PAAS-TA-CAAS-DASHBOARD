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
            <button type="button" id="btnReset2"> [ 목록 초기화 ] </button>
        </div>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted deepskyblue 4px;">
    </div>
</div>
<script type="text/javascript">
  function getAllDeployments(){
    procCallAjax("/workload/deployments/getList.do", "GET", null, null, callbackGetList);
  }

  function getDeployments() {
    var namespaceVal = $( "#namespace" ).val();
    var deploymentVal = $( "#deployment" ).val();
    if (false == ( namespaceVal != null && namespaceVal.replace(/\s/g, '').length > 0 ))
      namespaceVal = undefined;
    if (false == ( deploymentVal != null && deploymentVal.replace(/\s/g, '').length > 0 ))
      deploymentVal = undefined;

    var reqUrl = "/workload/deployments";

    if ( namespaceVal != null ) {
      reqUrl += "/" + namespaceVal;
      if ( deploymentVal != null ) {
        reqUrl += "/getDeployment.do";
        var param = {
          name: deploymentVal
        }
        procCallAjax( reqUrl, "GET", param, null, callbackGetDeployment );
      } else {
        reqUrl += "/getList.do"
        procCallAjax( reqUrl, "GET", null, null, callbackGetList );
      }
    } else {
      procCallAjax( reqUrl + "/getList.do", "GET", null, null, callbackGetList );
    }
  }

  var stringifyJSON = function(obj) {
    return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
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
    htmlString.push("DEPLOYMENTS LIST :: <br><br>");
    htmlString.push( "ResultCode :: " + data.resultCode + " || "
      + "Message :: " + data.resultMessage + " <br><br>");

    //
    $.each(data.items, function(index, itemList) {
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
        + "<br><br>" );
    });

    //var $resultArea = $('#resultArea');
    $('#resultArea').html(htmlString);
  };

  var callbackGetDeployment = function(data) {
    if (RESULT_STATUS_FAIL === data.resultCode) {
      $('#resultArea').html(
        "ResultStatus :: " + data.resultCode + " <br><br>"
        + "ResultMessage :: " + data.resultMessage + " <br><br>");
      return false;
    }

    console.log("CONSOLE DEBUG PRINT :: " + data);

    var htmlString = [];
    htmlString.push("DEPLOYMENTS LIST :: <br><br>");
    htmlString.push( "ResultCode :: " + data.resultCode + " || "
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
      + "Status(Replica) :: " + replicaStatus + "<br><br>" );

    //var $resultArea = $('#resultArea');
    $('#resultArea').html(htmlString);
  }


  // BIND
  $("#btnReset").on("click", function() {
    $('#resultArea').html("");
  });

  $("#btnReset2").on("click", function() {
    $('#resultArea').html("");
  });

  // ALREADY READY STATE
  $(document).ready(function(){
    $("#btnAllSearch").on("click", function (e) {
      getAllDeployments();
    });

    $("#btnSearch").on("click", function (e) {
      getDeployments();
    });
  });

  // ON LOAD
  $(document.body).ready(function () {
      getAllDeployments();
  });

</script>
