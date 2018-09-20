<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  Intro overview main
  @author REX
  @version 1.0
  @since 2018.09.10
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="content">
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
    <div class="cluster_tabs clearfix"></div>
    <!-- Intro 시작-->
    <div class="cluster_content01 row two_line two_view">
        <ul id="detailTab">
            <!-- Namespace 시작-->
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Namespace</p>
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
            <!-- Namespace 끝-->
            <!-- Plan 시작-->
            <li class="maT30">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Plan</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style='width:20%'>
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Type</th>
                                <td>CaaS service plan 1</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Description</th>
                                <td>
                                    <p>
                                        2 CPUs, 2GB Memory, 10GB Disk (free)
                                    </p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Plan 끝-->
        </ul>
    </div>
    <!-- Intro 끝 -->
</div>

<div id="quota-template" style="display:none;">
    <li class="cluster_second_box maB50">
        <div class="sortable_wrap">
            <div class="sortable_top">
                <p>Resource Quotas</p>
            </div>
            <div class="view_table_wrap">
                <table class="table_event condition alignL">
                    <p class="p30">- <strong>Name</strong> : {{metadata.name}} / - <strong>Scopes</strong> :
                        {{spec.scopes}}
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
</div>

<script type="text/javascript">

    var getDetail = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_NAME_SPACES_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE);

        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    var callbackGetDetail = function(data) {
        var noResultAreaForNameSpaceDetails = $("#noResultAreaForNameSpaceDetails");
        var resultAreaForNameSpaceDetails = $("#resultAreaForNameSpaceDetails");

        if (data.resultCode === "500") {
            noResultAreaForNameSpaceDetails.show();
            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        // $("#title").html(data.metadata.name);
        $("#title").html(NAME_SPACE);

        // var namespaceName = data.metadata.name;
        var namespaceNameHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + NAME_SPACE + "</a>";

        // $("#nameSpaceName").html(data.metadata.name);
        $("#nameSpaceName").html(namespaceNameHtml);
        $("#nameSpaceCreationTime").html(data.metadata.creationTimestamp);
        $("#nameSpaceStatus").html(data.status.phase);

        resultAreaForNameSpaceDetails.show();

        viewLoading('hide');
    };


    var getResourceQuotaList = function(namespace) {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_NAME_SPACES_RESOURCE_QUOTAS %>"
            .replace("{namespace:.+}", NAME_SPACE);

        procCallAjax(reqUrl, "GET", null, null, callbackGetResourceQuotaList);
    };


    var callbackGetResourceQuotaList = function(data) {
        var html = $("#quota-template").html();

        if (data.resultCode === "500") {
            html = html.replace("<tbody>", "<tbody><tr><p class=service_p'>조회 된 ResourceQuota가 없습니다.</p></tr>");

            $("#detailTab").append(html);

            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        var trHtml = "";

        for (var i = 0; i < data.items.length; i++) {
            var htmlRe = "";
            var hards = data.items[i].status.hard;
            var useds = data.items[i].status.used;
            var name = data.items[i].metadata.name;
            var scopes = data.items[i].spec.scopes;

            if (scopes == null || scopes == "null") {
                scopes = "-";
            }

            for ( var key in hards ) {
                trHtml +=
                    "<tr>"
                    + "<td>" + key + "</td>"
                    + "<td>" + hards[key] + "</td>"
                    + "<td>" + useds[key] + "</td>"
                    + "</tr>";
            }

            htmlRe = html.replace("<tbody>", "<tbody>"+trHtml);

            htmlRe = htmlRe.replace("{{metadata.name}}", name);
            htmlRe = htmlRe.replace("{{spec.scopes}}", scopes);

            $("#detailTab").append(htmlRe);
        }

        viewLoading('hide');
    };


    $(document.body).ready(function () {
        getDetail();
        getResourceQuotaList(NAME_SPACE);
    });

</script>
