<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="content">
    <jsp:include page="commonPods.jsp" flush="true"/>

    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

    <!-- Events 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="noResultArea" style="display: none;"><td colspan='6'><p class='service_p'>조회 된 Events가 없습니다.</p></td></tr>
                            <tr id="resultHeaderArea">
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
    // ON LOAD
    $(document.body).ready(function() {
        viewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>".replace("{namespace:.+}", NAME_SPACE)
            .replace("{resourceName:.+}", G_POD_NAME);
        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
        viewLoading('hide');
    });

    // PARSE EVENT FROM DATA
    var getEventList = function(items) {
        return items.map(function(data) {
            var tmpSource = data.source.component + (nvl(data.source.host) ? ' ' + nvl(data.source.host) : '');
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
            var ascending = true;
            var reverseNumber = (ascending) ? 1 : -1;
            if (firstA === firstB)
                return 0;
            else {
                if (firstA == null)
                    return -1 * reverseNumber;
                else if (firstB == null)
                    return reverseNumber;
                else if (firstA > firstB)
                    return reverseNumber;
                else
                    return -1 * reverseNumber;
            }
        });
    };

    // CALLBACK
    var callbackGetList = function(data) {
        viewLoading('show');

        var noResultArea = $('#noResultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var resultArea = $('#resultArea');
        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage(nvl(data.resultMessage, "Pod 정보를 가져오지 못했습니다."), false);
            noResultArea.show();
            resultHeaderArea.hide();
            resultArea.hide();
            return;
        }

        var eventList = getEventList(data.items);
        var listLength = eventList.length;

        $.each(eventList, function(index, event) {
            var messageHtml;
            if (0 === event.message.indexOf("Error")) {
                messageHtml = '<span class="red2 tableTdToolTipFalse"><i class="fas fa-exclamation-circle"></i></span> <span class="red2">';
            } else {
                messageHtml = '<span>';
            }
            messageHtml = $(messageHtml + event.message + '</span>').wrapAll("<div/>").parent().html();
            resultArea.append("<tr>"
                + "<td>" + messageHtml + "</td>"
                + "<td><span>" + event.source + "</span></td>"
                + "<td><span>" + event.subObject + "</span></td>"
                + "<td>" + event.count + "</td>"
                + "<td>" + event.firstSeen + "</td>"
                + "<td>" + event.lastSeen + "</td>"
                + "</tr>");
        });

        if (listLength < 1) {
            noResultArea.show();
            resultHeaderArea.hide();
            resultArea.hide();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
        }

        // TOOL TIP
        procSetToolTipForTableTd('resultArea');
        $('[data-toggle="tooltip"]').tooltip();

        viewLoading('hide');
    };
</script>
