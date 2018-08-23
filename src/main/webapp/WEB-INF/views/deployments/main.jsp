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
  var getAllDeployments = function (){
    procCallAjax("/workload/deployments/getList.do", "GET", null, null, callbackGetList);
  }

  var getDeployments = function () {
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

    procCallAjax( "/workload/namespaces/"+ namespace + "/replicasets/resource/" + hoho(labels), "GET", null, null, callbackGetReplicasetList);
    procCallAjax( "/workload/namespaces/"+ namespace + "/replicasets/resource/" + hoho(labels), "GET", null, null, callbackGetReplicasetList);
    //procCallAjax( reqUrl + "/getList.do", "GET", null, null, callbackGetList );
  }



    var hoho = function (data) {
      console.log("데이터다 " + data)
        return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D');
    }

  // CALLBACK
  var callbackGetReplicasetList = function(data) {
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
          for(var i=0; i < containers.length; i++){
              images.push(containers[i].image);
          }

          $resultArea.append("<a href='javascript:void(0);'><span style='color: orangered;'>[ DETAIL ]</span></a>"
              + "Name :: " + replicasetName + " || "
              + "Namespace :: " + namespace + " || "
              + "Labels :: " + labels+ " || "
              + "Pods :: " + replicas+ " || "
              + "Created on :: " + creationTimestamp + " || "
              + "Images :: " + images.join(",")
              + "<br><br>");

          $(document).on( "click", "#resultArea a:eq("+index+")" ,function(e){
              getDetail(replicasetName);
          });

      });

  };





















  // BIND
  $("#btnReset").on("click", function() {
    $('#resultArea').html("");
  });

  // ALREADY READY STATE
  $(document).ready(function(){
    $("#btnSearch").on("click", function (e) {
      getDeployments();
    });
  });

  // ON LOAD
  $(document.body).ready(function () {
      getAllDeployments();
  });

</script>
