<%--
  Nodes summary
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span>
        <c:out value="${nodeName}" default="-"/></h1>

    <jsp:include page="../common/contentsTab.jsp"/>

    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_second_box">
                <jsp:include page="../pods/list.jsp"/>
            </li>
            <li class="cluster_second_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Conditions</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="node_conditions" class="table_event condition alignL">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="conditionsNotFound" style="display:none;">
                                <td colspan="6"><p class='service_p'>Node의 Condition 정보가 없습니다.</p></td>
                            </tr>
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

    // GET NODE
    var getNode = function() {
        var resourceName = '<c:out value="${nodeName}" default="" />';
        var reqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_NODES_LIST %>'.replace('{nodeName:.+}', resourceName);

        procCallAjax(reqUrl, 'GET', null, null, callbackGetNodeSummary);
    };

    // CALLBACK GET NODE SUMMARY
    var callbackGetNodeSummary = function(data) {
        procViewLoading('show');

        var podNotFound = $('#noPodListResultArea');
        var podsTableHeader = $('#podListResultHeaderArea');
        var conditionsNotFound = $('#conditionsNotFound');
        var conditionsTableHeader = $('#conditionsTableHeader');

        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return;
        }

        var nodeName = data.metadata.name;
        var conditions = data.status.conditions;
        $.each(conditions, function(index, condition) {
            condition.lastHeartbeatTime = condition.lastHeartbeatTime.replace(/T/g, ' ').replace(/Z$/g, '');
            condition.lastTransitionTime = condition.lastTransitionTime.replace(/T/g, ' ').replace(/Z$/g, '');
        });

        // SET PODS TABLE
        var podListReqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_NODE %>'
            .replace('{namespace:.+}', NAME_SPACE).replace('{nodeName:.+}', nodeName);
        getPodListUsingRequestURL(podListReqUrl);

        // SET NODE'S CONDITIONS
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
            $('#conditionResultArea').html(contents);
            podNotFound.hide();
            podsTableHeader.show();
            conditionsNotFound.hide();
            conditionsTableHeader.show();
        } else {
            podNotFound.show();
            podsTableHeader.hide();
            conditionsNotFound.show();
            conditionsTableHeader.hide();
        }

        procSetToolTipForTableTd('conditionResultArea');
        $('[data-toggle="tooltip"]').tooltip();
        procViewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        getNode();
    });
</script>
