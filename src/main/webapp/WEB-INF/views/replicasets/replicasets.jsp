<%--
  Replicaset main
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="padding: 10px;">
    <div id="headText">REPLICASET :: REPLICASET <span id="headTextType">LIST</span></div>
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
    <div id="resultAreaForPods" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted yellowgreen 4px;">
    </div>
    <div id="resultAreaForServices" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted greenyellow 4px;">
    </div>
    <div id="resultAreaForHPA" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted greenyellow 4px;">
    </div>
<script type="text/javascript">

    // GET LIST
    var getList = function() {
        procCallAjax("/workload/namespaces/hrjin-namespace/replicasets", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        console.log(data);

        var htmlString = [];
        var $resultArea = $('#resultArea');

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
            var labelsList = JSON.stringify(itemList.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
            var creationTimestamp = itemList.metadata.creationTimestamp;
            var replicas = itemList.status.replicas;   //  TOBE ::  current / desired
            var images = new Array;

            var containers = itemList.spec.template.spec.containers;

            for(var i=0; i < containers.length; i++){
                images.push(containers[i].image);
            }

            $resultArea.append("<a href='javascript:void(0);'>[ DETAIL ]</a>" + " || "
                    + "Name :: " + replicasetName + " || "
                    + "Namespace :: " + namespace + " || "
                    + "Labels :: " + labelsList+ " || "
                    + "Pods :: " + replicas+ " || "
                    + "Created on :: " + creationTimestamp + " || "
                    + "Images :: " + images.join(",")
                    + "<br><br>");

            $(document).on( "click", "#resultArea a:eq("+index+")" ,function(e){
                getDetail(replicasetName);
            });

        });

    };

    // GET LIST
    var getDetail = function(replicasetName) {
        procCallAjax("/workload/namespaces/hrjin-namespace/replicasets/"+replicasetName, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        console.log(data);

        $('#headTextType').text("DETAIL");

        var $resultArea = $('#resultArea');

        $resultArea.html("");
        $resultArea.append("REPLICASET DETAIL :: <br><br>");

        //-- Replica Set List
        //metadata.name
        //metadata.namespace
        //metadata.labels
        //status.annotaion
        //metadata.creationTimestamp
        //metadata.selector
        //spec.containers.image
        //managing deployment // label selector로 deployment 조회 및 링크

        $.each(data, function (index, itemList) {

            $resultArea.append(
                    "name :: " + "aaa" + " || "
                    + "type :: " + "bbb" + " || "
                    + "creationTimestamp :: " + "cccc"
                    + "<br><br>");

        });

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
