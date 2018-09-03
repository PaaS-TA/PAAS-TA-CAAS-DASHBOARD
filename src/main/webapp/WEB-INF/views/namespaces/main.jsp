<%@ page contentType="text/html;charset=UTF-8" %>

<div class="content">
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <div class="cluster_content02 row two_line two_view harf_view custom_display_block">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Namespaces</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:20%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                                <tr>
                                    <td>Name</td>
                                    <td>Status</td>
                                    <td>Created on</td>
                                </tr>
                            </thead>
                            <tbody id="resultAreaForNameSpace">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript">
    //TODO 이중에 골라서.

    // $('body').loadingModal({text: 'Showing loader animations...'});
    //
    // var delay = function(ms){ return new Promise(function(r) { setTimeout(r, ms) }) };
    // var time = 2000;
    //
    // delay(time)
    //     .then(function() { $('body').loadingModal('animation', 'rotatingPlane').loadingModal('backgroundColor', 'red'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'wave'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'wanderingCubes').loadingModal('backgroundColor', 'green'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'spinner'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'chasingDots').loadingModal('backgroundColor', 'blue'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'threeBounce'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'circle').loadingModal('backgroundColor', 'black'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'cubeGrid'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'fadingCircle').loadingModal('backgroundColor', 'gray'); return delay(time);})
    //     .then(function() { $('body').loadingModal('animation', 'foldingCube'); return delay(time); } )
    //     .then(function() { $('body').loadingModal('color', 'black').loadingModal('text', 'Done :-)').loadingModal('backgroundColor', 'yellow');  return delay(time); } )
    //     .then(function() { $('body').loadingModal('hide'); return delay(time); } )
    //     .then(function() { $('body').loadingModal('destroy') ;} );

    var getDetail = function() {
        $('body').loadingModal();
        $('body').loadingModal('animation', 'chasingDots').loadingModal('color', 'black').loadingModal('backgroundColor', 'white');

        procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail.do", "GET", null, null, callbackGetDetail);
    };

    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultCode) return false;

        var htmlString = [];

        htmlString.push(
            "<tr>"
            + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> <a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + data.metadata.name + "</a></td>"
            + "<td>" + data.status.phase + "</td>"
            + "<td>" + data.metadata.creationTimestamp + "</td>"
            + "</tr>");

        var resultArea = $("#resultAreaForNameSpace");
        resultArea.html(htmlString);

        $('body').loadingModal('destroy') ;
    };

    $(document.body).ready(function () {
        getDetail();
    });

</script>