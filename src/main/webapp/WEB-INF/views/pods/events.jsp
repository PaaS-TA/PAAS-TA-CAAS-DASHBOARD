<%--
  Pods events
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="content">
    <jsp:include page="commonPods.jsp"/>

    <jsp:include page="../common/contentsTab.jsp"/>

    <!-- Events 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="resultTable" class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="noResultArea" style="display: none;">
                                <td colspan='6'><p class='service_p'>조회 된 Events가 없습니다.</p></td>
                            </tr>
                            <tr id="resultHeaderArea" class="headerSortFalse">
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Events 끝 -->
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

    // CALLBACK
    var callbackGetList = function(data) {
        viewLoading('show');

        var noResultArea = $('#noResultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var resultArea = $('#resultArea');

        noResultArea.show();
        resultHeaderArea.hide();
        resultArea.hide();

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
            resultArea.append('<tr>'
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
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();

            var eventsTable = $('#resultTable');
            eventsTable.tablesorter({
                sortList: [[4, 0]] // 0 = ASC, 1 = DESC
            });
            eventsTable.trigger('update');
            $('.headerSortFalse > td').unbind();
        }

        // TOOL TIP
        procSetToolTipForTableTd('resultArea');
        $('[data-toggle="tooltip"]').tooltip();

        viewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        var reqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>'
            .replace('{namespace:.+}', NAME_SPACE).replace('{resourceName:.+}', G_POD_NAME);

        procCallAjax(reqUrl, 'GET', null, null, callbackGetList);
    });
</script>
