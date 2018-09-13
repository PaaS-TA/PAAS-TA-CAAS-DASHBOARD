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

<!-- Nodes Summary 시작 -->
<div class="content">
    <jsp:include page="common-nodes.jsp"/>

    <%-- NODES HEADER INCLUDE --%>
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
                        <table id="conditions_in_node" class="table_event condition alignL">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="conditionsNotFound" style="display:none;"><td colspan="6" style="text-align:center;">Node의 Condition 정보가 없습니다.</td></tr>
                            <tr id="conditionsTableHeader">
                                <td>Type</td>
                                <td>Status</td>
                                <td>Last heartbeat time</td>
                                <td>Last transition time</td>
                                <td>Reason</td>
                                <td>Message</td>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <!--tfoot></tfoot-->
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>

<script>
    var callbackGetNodeSummary = function (data) {
        viewLoading('show');

        // check data validation
        var podNotFound = $('#podNotFound');
        var conditionsNotFound = $('#conditionsNotFound');
        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Node 정보를 가져오지 못했습니다.", false);
            podNotFound.children().html("Node의 정보를 가져오지 못했습니다.");
            podNotFound.show();
            $('#podsTableHeader').hide();

            conditionsNotFound.children().html("Node의 정보를 가져오지 못했습니다.");
            conditionsNotFound.show();
            $('#conditionsTableHeader').hide();
            return;
        }

        var nodeName = data.metadata.name;
        var conditions = data.status.conditions;
        $.each(conditions, function (index, condition) {
            condition.lastHeartbeatTime = condition.lastHeartbeatTime.replace(/T/g, " ").replace(/Z.+/g, "");
            condition.lastTransitionTime = condition.lastTransitionTime.replace(/T/g, " ").replace(/Z.+/g, "");
        });

        // get pods, conditions
        var podListReqUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + NAME_SPACE + "/pods/node/" + nodeName;
        getPodListUsingRequestURL(podListReqUrl);

        // set conditions
        var contents = [];
        $.each(conditions, function (index, condition) {
            contents.push('<tr>'
                + '<td class="custom-content-overflow" data-toggle="tooltip" title="' + condition.type + '">' + condition.type + '</td>'
                + '<td>' + condition.status + '</td>'
                + '<td>' + condition.lastHeartbeatTime + '</td>'
                + '<td>' + condition.lastTransitionTime + '</td>'
                + '<td class="custom-content-overflow" data-toggle="tooltip" title="' + condition.reason + '">' + condition.reason + '</td>'
                + '<td class="custom-content-overflow" data-toggle="tooltip" title="' + condition.message + '">' + condition.message + '</td></tr>');
        });

        if (contents.length > 0) {
            // append conditions tbody
            $('#conditions_in_node > tbody').html(contents);
        } else {
            conditionsNotFound.children().html("Node의 Condition 목록을 가져오지 못했습니다.");
            conditionsNotFound.show();
            $('#conditionsTableHeader').hide();
        }

        viewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function () {
        viewLoading('show');
        getNode(G_NODE_NAME, callbackGetNodeSummary);
        viewLoading('hide');
    });
</script>
<!-- Nodes Summary 끝 -->
