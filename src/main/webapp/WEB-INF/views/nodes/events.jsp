<%--
  Nodes events
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="content">
    <jsp:include page="commonNodes.jsp"/>

    <jsp:include page="../common/contentsTab.jsp"/>

    <!-- NodeEvents 시작-->
    <div class="cluster_content03 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="nodeEventsTable" class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="nodeEventsnotFound" style="display:none;">
                                <td colspan='6'><p class='service_p'>조회 된 Events가 없습니다.</p></td>
                            </tr>
                            <tr id="nodeEventsTableHeader" class="headerSortFalse">
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
        var eventList = items.map(function(data) {
            var tmpSource = data.source.component + (nvl(data.source.host) ? ' ' + nvl(data.source.host) : '');
            var tmpSubObject;
            if ('' !== nvl(data.involvedObject)) {
                tmpSubObject = nvl(data.involvedObject.fieldPath, '-');
            } else {
                tmpSubObject = '-';
            }
            return {
                message: data.message,
                source: tmpSource,
                subObject: tmpSubObject,
                count: data.count,
                firstSeen: data.firstTimestamp,
                lastSeen: data.lastTimestamp
            };
        });

        return eventList;
    };

    // CALLBACK GET NODE EVENT
    var callbackGetNodeEvent = function(data) {
        viewLoading('show');

        var nodeEventsNotFound = $('#nodeEventsnotFound');
        var nodeEventsTableHeader = $('#nodeEventsTableHeader');
        var nodeEventsResultArea = $('#nodeEventsResultArea');

        nodeEventsNotFound.show();
        nodeEventsTableHeader.hide();
        nodeEventsResultArea.hide();

        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
            return;
        }

        var eventList = getEventList(data.items);
        var listCount = 0;

        $.each(eventList, function(index, event) {
            var messageHtml;
            if (0 === event.message.indexOf('Error')) {
                messageHtml = '<span class="red2 tableTdToolTipFalse"><i class="fas fa-exclamation-circle"></i></span> '
                    + '<span class="red2">' + event.message + '</span>';
            } else {
                messageHtml = '<span>' + event.message + '</span>';
            }
            nodeEventsResultArea.append('<tr>'
                + '<td>'       + messageHtml     + '</td>'
                + '<td><span>' + event.source    + '</span></td>'
                + '<td><span>' + event.subObject + '</span></td>'
                + '<td>'       + event.count     + '</td>'
                + '<td>'       + event.firstSeen + '</td>'
                + '<td>'       + event.lastSeen  + '</td>'
                + '</tr>');

            listCount++;
        });

        if (listCount > 0) {
            nodeEventsNotFound.hide();
            nodeEventsTableHeader.show();
            nodeEventsResultArea.show();

            var eventsTable = $('#nodeEventsTable');
            eventsTable.tablesorter({
                sortList: [[4, 0]] // 0 = ASC, 1 = DESC
            });
            eventsTable.trigger('update');
            $('.headerSortFalse > td').unbind();
        }

        procSetToolTipForTableTd('nodeEventsResultArea');
        $('[data-toggle="tooltip"]').tooltip();

        viewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        var reqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>'
            .replace('{namespace:.+}', NAME_SPACE).replace('{resourceName:.+}', G_NODE_NAME);

        procCallAjax(reqUrl, 'GET', null, null, callbackGetNodeEvent);
    });
</script>
<!-- NodeEvents 끝 -->
