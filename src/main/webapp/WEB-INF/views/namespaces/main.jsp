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
                                <tr id="noResultHeaderAreaForNameSpace" style="display: none;"><td colspan='3'><p class='service_p'>조회 된 NameSpace가 없습니다.</p></td></tr>
                                <tr id="resultHeaderAreaForNameSpace" style="display: none;">
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

    var getDetail = function() {
        viewLoading('show');

        procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail", "GET", null, null, callbackGetDetail);
    };

    var callbackGetDetail = function(data) {
        var resultAreaForNameSpace = $("#resultAreaForNameSpace");
        var noResultHeaderAreaForNameSpace = $("#noResultHeaderAreaForNameSpace");
        var resultHeaderAreaForNameSpace = $("#resultHeaderAreaForNameSpace");

        if (data.resultCode == "500") {
            noResultHeaderAreaForNameSpace.show();
            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        var htmlString = [];

        htmlString.push(
            "<tr>"
            + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> <a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + data.metadata.name + "</a></td>"
            + "<td>" + data.status.phase + "</td>"
            + "<td>" + data.metadata.creationTimestamp + "</td>"
            + "</tr>");

        resultAreaForNameSpace.html(htmlString);
        noResultHeaderAreaForNameSpace.hide();
        resultHeaderAreaForNameSpace.show();

        viewLoading('hide');
    };

    $(document.body).ready(function () {
        getDetail();
    });

</script>