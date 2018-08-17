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
    <div id="resultAreaForHPA" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted darkgreen 4px;">
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

            $resultArea.append("<a href='javascript:void(0);'><span style='color: orangered;'>[ DETAIL ]</span></a>" + " || "
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

    // GET LIST
    var getDetail = function(replicasetName) {
        procCallAjax("/workload/namespaces/hrjin-namespace/replicasets/"+replicasetName, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        console.log(data);
        // Detail init
        $('#headTextType').text("DETAIL");
        $('#btnSearch').hide();
        $('#btnReset').hide();

        // TODO :: develop Pods / Services / Horizontal Pod Autoscaler(HorizontalPodAutoscaler 리소스 등록 필요)
        //$('#resultAreaForPods').show();
        //$('#resultAreaForServices').show();
        //$('#resultAreaForHPA').show();

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

        var replicasetName = data.metadata.name;
        var namespace = data.metadata.namespace;
        var labels = JSON.stringify(data.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
        var creationTimestamp = data.metadata.creationTimestamp;
        var replicas = data.status.replicas;   //  TOBE ::  current / desired
        var images = new Array;
        var annotations = JSON.stringify(data.metadata.annotations).replace(/["{}]/g, '').replace(/:/g, '=');
        var deployment = ""; // TODO :: label selector로 deployment 조회 및 링크

        var containers = data.spec.template.spec.containers;
        for(var i=0; i < containers.length; i++){
            images.push(containers[i].image);
        }


        $resultArea.append(
                  "Name :: " + replicasetName + " || "
                + "Namespace :: " + namespace + " || "
                + "Labels :: " + labels+ " || "
                + "Annotations :: " + annotations+ " || "
                + "Created on :: " + creationTimestamp + " || "
                + "Images :: " + images.join(",")
                + "Pods :: " + replicas+ " || "
                + "Managing deployment:: " + deployment+ " || "
                + "<br><br>");

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
