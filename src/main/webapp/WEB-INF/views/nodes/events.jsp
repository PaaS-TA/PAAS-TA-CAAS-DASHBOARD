<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <jsp:include page="commonNodes.jsp"/>

    <%-- NODES HEADER INCLUDE --%>
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

    <!-- NodeEvents 시작-->
    <div class="cluster_content03 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="events_table_in_node" class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="nodeEventsnotFound" style="display:none;"><td colspan='6'><p class='service_p'>조회 된 Events가 없습니다.</p></td></tr>
                            <tr id="nodeEventsTableHeader">
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody id="nodeEventsResultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript">
    // PARSE EVENT FROM DATA
    var getEventList = function(items) {
        return items.map(function(data) {
            var tmpSource = data.source.component + (nvl(data.source.host)? ' ' + nvl(data.source.host) : '');
            var tmpSubObject = nvl(data.involvedObject.fieldPath, '-');
            return {
                message: data.message,
                source: tmpSource,
                subObject: tmpSubObject,
                count: data.count,
                firstSeen: data.firstTimestamp,
                lastSeen: data.lastTimestamp
            };
        }).sort(function(eventA, eventB) {
            // sort : first seen
            var firstA = eventA.firstSeen;
            var firstB = eventB.firstSeen;
            var _ascending = true;
            var _reverseNumber = (_ascending) ? 1 : -1;
            if (firstA === firstB)
                return 0;
            else {
                if (firstA == null)
                    return -1 * _reverseNumber;
                else if (firstB == null)
                    return _reverseNumber;
                else if (firstA > firstB)
                    return _reverseNumber;
                else
                    return -1 * _reverseNumber;
            }
        });
    };

    var callbackGetNodeEvent = function (data) {
        viewLoading('show');

        var nodeEventsNotFound = $('#nodeEventsnotFound');
        var nodeEventsTableHeader = $('#nodeEventsTableHeader');
        var nodeEventsResultArea = $('#nodeEventsResultArea');
        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Node의 Event 목록을 가져오지 못했습니다.", false);
            nodeEventsNotFound.show();
            nodeEventsTableHeader.hide();
            nodeEventsResultArea.hide();
            return;
        }

        var eventList = getEventList(data.items);
        var listLength = eventList.length;

        $.each(eventList, function (index, event) {
            var messageHtml;
            if (0 === event.message.indexOf("Error")) {
                messageHtml = '<span class="red2"><i class="fas fa-exclamation-circle"></i></span> <span class="red2" data-toggle="tooltip">';
            } else {
                messageHtml = '<span data-toggle="tooltip">';
            }
            messageHtml = $(messageHtml + event.message + '</span>').attr('title', event.message)[0].outerHTML;
            nodeEventsResultArea.append("<tr>"
                + "<td>" + messageHtml + "</td>"
                + "<td><p>" + event.source + "</p></td>"
                + "<td><p>" + event.subObject + "</p></td>"
                + "<td>" + event.count + "</td>"
                + "<td>" + event.firstSeen + "</td>"
                + "<td>" + event.lastSeen + "</td>"
                + "</tr>");
        });

        if (listLength < 1) {
            nodeEventsNotFound.show();
            nodeEventsTableHeader.hide();
            nodeEventsResultArea.hide();
        } else {
            nodeEventsNotFound.hide();
            nodeEventsTableHeader.show();
            nodeEventsResultArea.show();
        }

        // TOOL TIP
        procSetToolTipForTableTd('resultArea');
        $('[data-toggle="tooltip"]').tooltip();

        viewLoading('hide');
    };

    var getEventsListByNode = function(namespace, nodeName) {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"
            .replace("{namespace:.+}", namespace).replace("{resourceName:.+}", nodeName);

        procCallAjax(reqUrl, "GET", null, null, callbackGetNodeEvent);
    };

    $(document.body).ready(function () {
        viewLoading('show');
        getEventsListByNode(NAME_SPACE, G_NODE_NAME);
        viewLoading('hide');
    });

</script>
<!-- NodeEvents 끝 -->
