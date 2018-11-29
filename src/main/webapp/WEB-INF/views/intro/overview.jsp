<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  Intro overview main
  @author REX
  @version 1.0
  @since 2018.09.10
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="content">
    <jsp:include page="../common/contentsTab.jsp"/>
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
                                <td id="planName"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Description</th>
                                <td>
                                    <p id="planDescription"></p>
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
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_NAME_SPACES_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE);

        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    var callbackGetDetail = function(data) {
        var noResultAreaForNameSpaceDetails = $("#noResultAreaForNameSpaceDetails");
        var resultAreaForNameSpaceDetails = $("#resultAreaForNameSpaceDetails");

        if (!procCheckValidData(data)) {
            noResultAreaForNameSpaceDetails.show();
            procViewLoading('hide');
            procAlertMessage('Get NameSpaces Failure.', false);

            return false;
        }

        $("#title").html(NAME_SPACE);

        var namespaceNameHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + NAME_SPACE + "</a>";

        $("#nameSpaceName").html(namespaceNameHtml);
        $("#nameSpaceCreationTime").html(data.metadata.creationTimestamp);
        $("#nameSpaceStatus").html(data.status.phase);

        resultAreaForNameSpaceDetails.show();

        procViewLoading('hide');
    };

    var getPlan = function () {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_COMMON_API_USERS_DETAIL %>"
            .replace("{serviceInstanceId:.+}", SERVICE_INSTANCE_ID)
            .replace("{organizationGuid:.+}", ORGANIZATION_GUID)
            .replace("{userId:.+}", USER_ID);
        
        procCallAjax(reqUrl, "GET", null, null, callbackGetPlan);
    };

    var callbackGetPlan = function (data) {
        $("#planName").text(data.planName);
        $("#planDescription").text(data.planDescription);
    };


    var getResourceQuotaList = function(namespace) {
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_NAME_SPACES_RESOURCE_QUOTAS %>"
            .replace("{namespace:.+}", NAME_SPACE);

        procCallAjax(reqUrl, "GET", null, null, callbackGetResourceQuotaList);
    };


    var callbackGetResourceQuotaList = function(data) {
        var html = $("#quota-template").html();

        if (!procCheckValidData(data)) {
            html = html.replace("<tbody>", "<tbody><tr><p class=service_p'>조회 된 ResourceQuota가 없습니다.</p></tr>");

            $("#detailTab").append(html);

            procViewLoading('hide');
            procAlertMessage();

            return false;
        }

        var skipResourceKey = [ 
            'requests.storage', 
            'limits.ephemeral-storage' 
        ];
        var trHtml;

        for (var i = 0; i < data.items.length; i++) {
            var htmlRe = "";
            var hards = data.items[i].status.hard;
            var useds = data.items[i].status.used;
            var name = data.items[i].metadata.name;
            var scopes = nvl(data.items[i].spec.scopes, "-");

            trHtml = "";
            for ( var key in hards ) {
                if ( skipResourceKey.includes(key) ) {
                    continue;
                }
                
                trHtml += "<tr>"
                    + "<td>" + key + "</td>"
                    + "<td>" + hards[key] + "</td>"
                    + "<td>" + useds[key] + "</td>"
                    + "</tr>";
            }
            
            htmlRe = html.replace("<tbody>", "<tbody>" + trHtml);

            htmlRe = htmlRe.replace("{{metadata.name}}", name);
            htmlRe = htmlRe.replace("{{spec.scopes}}", scopes);

            $("#detailTab").append(htmlRe);
        }

        procViewLoading('hide');
    };


    $(document.body).ready(function () {
        getDetail();
        getPlan();
        getResourceQuotaList(NAME_SPACE);
    });

</script>
