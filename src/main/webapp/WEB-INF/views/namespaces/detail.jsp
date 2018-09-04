<%@ page contentType="text/html;charset=UTF-8" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <span id="title"></span></h1>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view">
        <ul id="detailTab" class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Details</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style='width:20%'>
                                <col style=".">
                            </colgroup>
                            <tbody id="noResultAreaForNameSpaceDetails" style="display: none;"></tbody>
                            <tbody id="resultAreaForNameSpaceDetails" style="display: none;">
                                <tr>
                                    <th><i class="cWrapDot"></i> Name</th>
                                    <td id="nameSpaceName"></td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Creation Time</th>
                                    <td id="nameSpaceCreationTime"></td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Status</th>
                                    <td id="nameSpaceStatus"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Details 끝 -->
</div>

<script id="quota-template" type="text/x-handlebars-template">
<li class="cluster_second_box maB50">
    <div class="sortable_wrap">
        <div class="sortable_top">
            <p>Resource Quotas</p>
        </div>
        <div class="view_table_wrap">
            <table class="table_event condition alignL">
                <p class="p30">- <strong>Name</strong> : {{metadata.name}} / - <strong>Scopes</strong> :
                    {{#if spec.scopes}}
                        {{spec.scopes}}
                    {{else}}
                        -
                    {{/if}}
                </p>
                <colgroup>
                    <col style='width:auto;'>
                    <col style='width:20%;'>
                    <col style='width:20%;'>
                </colgroup>
                <thead>
                    <tr>
                        <td>Resource Name</td>
                        <td>Hard</td>
                        <td>Used</td>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</li>
</script>

<script type="text/javascript">

    var getDetail = function() {
        viewLoading('show');

        procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail.do", "GET", null, null, callbackGetDetail);
    };

    var callbackGetDetail = function(data) {
        var noResultAreaForNameSpaceDetails = $("#noResultAreaForNameSpaceDetails");
        var resultAreaForNameSpaceDetails = $("#resultAreaForNameSpaceDetails");

        if (data.resultCode == "500") {
            noResultAreaForNameSpaceDetails.show();
            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        $("#title").html(data.metadata.name);
        $("#nameSpaceName").html(data.metadata.name);
        $("#nameSpaceCreationTime").html(data.metadata.creationTimestamp);
        $("#nameSpaceStatus").html(data.status.phase);

        resultAreaForNameSpaceDetails.show();

        viewLoading('hide');
    };

    var getResourceQuotaList = function(namespace) {
        viewLoading('show');

        procCallAjax("/caas/clusters/namespaces/"+namespace+"/getResourceQuotaList.do", "GET", null, null, callbackGetResourceQuotaList);
    };

    var callbackGetResourceQuotaList = function(data) {
        var source = $("#quota-template").html();
        var template = Handlebars.compile(source);
        var trHtml = "";

        if (data.resultCode == "500") {
            var html0 = template(null);
            html0 = html0.replace("<tbody>", "<tbody><tr><p class=service_p'>조회 된 ResourceQuota가 없습니다.</p></tr>");

            $("#detailTab").append(html0);

            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        for (var i = 0; i < data.items.length; i++) {
            var html = template(data.items[i]);
            var hards = data.items[i].status.hard;
            var useds = data.items[i].status.used;

            for ( var key in hards ) {
                trHtml +=
                    "<tr>"
                    + "<td>" + key + "</td>"
                    + "<td>" + hards[key] + "</td>"
                    + "<td>" + useds[key] + "</td>"
                    + "</tr>";
            }
            html = html.replace("<tbody>", "<tbody>"+trHtml);

            $("#detailTab").append(html);
        }

        viewLoading('hide');
    }

    $(document.body).ready(function () {
        getDetail();

        getResourceQuotaList(NAME_SPACE);
    });

</script>
