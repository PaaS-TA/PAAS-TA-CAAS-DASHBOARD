<%--
  PersistentVloume main
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div style="padding: 10px;">
    <div id="headText">PERSISTENT VOLUME :: PERSISTENT VLOUME <span id="headTextType">LIST</span></div>
    <div style="padding: 10px;">
        <button type="button" id="btnSearch"> [ 조회 ] </button>
        <button type="button" id="btnReset"> [ 초기화 ] </button>
    </div>
    <h1>RESULT</h1>
    <div id="resultArea" style="width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted green 4px;">
    </div>
    <div id="resultAreaForSource" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted yellowgreen 4px;">
    </div>
    <div id="resultAreaForCapacity" style="display:none; width: 98%; height: auto; min-height: 100px; padding: 10px; margin: 1%; border: dotted greenyellow 4px;">
    </div>
<script type="text/javascript">

    // GET LIST
    var getList = function() {
        procCallAjax("/cluster/persistentvolumes", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        console.log(data);

        var $resultArea = $('#resultArea');

        $resultArea.append("PERSISTENT-VOLUME LIST :: <br><br>");

//  name            metadata.name
//  Capacity        spec.capacity.storage  (key-storage말고 value만 노출 다시 확인필요)
//  Access Modes    spec.accessModes
//  Reclaim policy  spec.persistentVolumeReclaimPolicy
//  Claim          -- 역으로 검색 필요
//  storage class   spec.storageClassName
//  reason         -- 못찾음
//  created on      --metadata.creationTimestamp

        $.each(data.items, function (index, itemList) {

            var pvName = itemList.metadata.name;
            var capacity = JSON.stringify(itemList.spec.capacity);
            var accessModes = itemList.spec.accessModes;
            var reclaimPolicy = itemList.spec.persistentVolumeReclaimPolicy;
            var claim = "";
            var storageClass = nvl(itemList.spec.storageClassName);
            var reason = "";
            var creationTimestamp = itemList.metadata.creationTimestamp;

            //var images = new Array;

//            var containers = itemList.spec.template.spec.containers;
//            for(var i=0; i < containers.length; i++){
//                images.push(containers[i].image);
//            }

            $resultArea.append("<a href='javascript:void(0);'><span style='color: orangered;'>[ DETAIL ]</span></a>"
                    + "Name :: " + pvName + " || "
                    + "Capacity :: " + capacity + " || "
                    + "Access Modes :: " + accessModes + " || "
                    + "reclaimPolicy :: " + reclaimPolicy+ " || "
                    + "claim :: " + claim+ " || "
                    + "storageClass :: " + storageClass+ " || "
                    + "reason :: " + reason+ " || "
                    + "Created on :: " + creationTimestamp
                    + "<br><br>");

            $(document).on( "click", "#resultArea a:eq("+index+")" ,function(e){
                getDetail(pvName);
            });

        });

    };

    // GET LIST
    var getDetail = function(pvName) {
        procCallAjax("/cluster/persistentvolumes/"+pvName, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        console.log(data);
        // Detail init
        $('#headTextType').text("DETAIL");
        $('#btnSearch').hide();
        $('#btnReset').hide();

        //$('#resultAreaForSource').show();
        //$('#resultAreaForCapacity').show();

        var $resultArea = $('#resultArea');

        $resultArea.html("");
        $resultArea.append("PERSISTENT-VOLUME DETAIL :: <br><br>");

//        -- detail
//        Name             metadata.name
//        Labels           metadata.labels
//        Creation Time    metadata.creationTimestamp
//        status           status.phase
//        Claim            -
//        Reclaim policy   spec.persistentVolumeReclaimPolicy
//        Access modes     spec.accessModes
//        Storage class    spec.storageClassName
//        Reason           -
//        Message          -

        var pvName = data.metadata.name;
        var labels = JSON.stringify(data.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
        var creationTimestamp = data.metadata.creationTimestamp;
        var status = data.status.phase;
        var claim = "";
        //optional 항목에만 nvl적용
        var reclaimPolicy   = nvl(data.spec.persistentVolumeReclaimPolicy);
        var accessModes     = nvl(data.spec.accessModes)
        var storageClass    = nvl(data.spec.storageClassName);
        var reason = "";
        var message = "";

        $resultArea.append(
                  "Name :: " + pvName + " || "
                + "Labels :: " + labels+ " || "
                + "Creation Time :: " + creationTimestamp + " || "
                + "Status :: " + status+ " || "
                + "Claim :: " + claim+ " || "
                + "Reclaim policy:: " + reclaimPolicy+ " || "
                + "accessModes :: " + accessModes+ " || "
                + "storageClass :: " + storageClass+ " || "
                + "reason :: " + reason+ " || "
                + "message :: " + message
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
