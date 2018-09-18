<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="content">
    <jsp:include page="commonNodes.jsp" flush="true"/>

    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_second_box">
                <jsp:include page="../pods/list.jsp" flush="true"/>
            </li>
            <li class="cluster_second_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Conditions</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="conditionsNotFound" style="display:none;"><td colspan="6"><p class='service_p'>Node의 Condition 정보가 없습니다.</p></td></tr>
                            <tr id="conditionsTableHeader">
                                <td>Type</td>
                                <td>Status</td>
                                <td>Last heartbeat time</td>
                                <td>Last transition time</td>
                                <td>Reason</td>
                                <td>Message</td>
                            </tr>
                            </thead>
                            <tbody id="conditionResultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>
<script type="text/javascript">
    // CALLBACK GET NODE SUMMARY
    var callbackGetNodeSummary = function(data) {
        viewLoading('show');

        // check data validation
        var podNotFound = $('#noPodListResultArea');
        var podsTableHeader = $('#podListResultHeaderArea');
        var conditionsNotFound = $('#conditionsNotFound');
        var conditionsTableHeader = $('#conditionsTableHeader');
        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            var podNotFoundMessage = nvl(data.resultMessage, "Node의 Pod 정보를 가져오지 못했습니다.");
            alertMessage(podNotFoundMessage, false);
            podNotFound.find('p').html(podNotFoundMessage);
            podNotFound.show();
            podsTableHeader.hide();

            var conditionsNotFoundMessage = nvl(data.resultMessage, "Node의 정보를 가져오지 못했습니다.");
            alertMessage(conditionsNotFoundMessage, false);
            conditionsNotFound.find('p').html(conditionsNotFoundMessage);
            conditionsNotFound.show();
            conditionsTableHeader.hide();
            return;
        }

        var nodeName = data.metadata.name;
        var conditions = data.status.conditions;
        $.each(conditions, function(index, condition) {
            condition.lastHeartbeatTime = condition.lastHeartbeatTime.replace(/T/g, " ").replace(/Z$/g, "");
            condition.lastTransitionTime = condition.lastTransitionTime.replace(/T/g, " ").replace(/Z$/g, "");
        });

        // get pods, conditions
        var podListReqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_NODE %>"
            .replace("{namespace:.+}", NAME_SPACE).replace("{nodeName:.+}", nodeName);
        getPodListUsingRequestURL(podListReqUrl);

        // set conditions
        var contents = [];
        $.each(conditions, function(index, condition) {
            contents.push('<tr>'
                + '<td><p>' + condition.type + '</p></td>'
                + '<td>' + condition.status + '</td>'
                + '<td>' + condition.lastHeartbeatTime + '</td>'
                + '<td>' + condition.lastTransitionTime + '</td>'
                + '<td><p>' + condition.reason + '</p></td>'
                + '<td><p>' + condition.message + '</p></td></tr>');
        });

        if (contents.length > 0) {
            // append conditions tbody
            $('#conditionResultArea').html(contents);
        } else {
            conditionsNotFound.find('p').html("Node의 Condition 목록을 가져오지 못했습니다.");
            conditionsNotFound.show();
            conditionsTableHeader.hide();
        }

        // TOOL TIP
        procSetToolTipForTableTd('conditionResultArea');
        $('[data-toggle="tooltip"]').tooltip();

        viewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        viewLoading('show');
        getNode(G_NODE_NAME, callbackGetNodeSummary);
        viewLoading('hide');
    });
</script>
