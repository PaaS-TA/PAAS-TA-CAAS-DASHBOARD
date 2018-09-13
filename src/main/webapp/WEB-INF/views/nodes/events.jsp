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
    <jsp:include page="common-nodes.jsp"/>

    <%-- NODES HEADER INCLUDE --%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <!-- NodeEvents 시작-->
    <div class="cluster_content03 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="events_table_in_node" class="table_event condition alignL">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="nodeEventsnotFound" style="display:none;"><td colspan="6" style="text-align:center;">Node의 Event가 없습니다.</td></tr>
                            <tr id="nodeEventsTableHeader">
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
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

<script type="text/javascript">
    var callbackGetNodeEvent = function (data) {
        viewLoading('show');

        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Node의 Event 목록을 가져오지 못했습니다.", false);
            $('#nodeEventsnotFound').children().html("Node의 Event 목록을 가져오지 못했습니다.");
            $('#nodeEventsnotFound').show();
            $('#nodeEventsTableHeader').hide();
            return;
        }

        // pre-sort : last seen (last timestamp)
        data.items.sort(function(itemA, itemB) {
            var _compareA = itemA.lastTimestamp;
            var _compareB = itemB.lastTimestamp;
            var _ascending = false;
            var _reverseNumber = (_ascending)? 1 : -1;
            if (_compareA === _compareB)
                return 0;
            else {
                if (_compareA == null)
                    return -1 * _reverseNumber;
                else if (_compareB == null)
                    return _reverseNumber;
                else if (_compareA > _compareB)
                    return _reverseNumber;
                else
                    return -1 * _reverseNumber;
            }
        });

        var contents = [];
        $.each(data.items, function (index, eventItem) {
            // message, source, sub-object, count, first-seen, last-seen
            // message is including error message
            var _event = getEvent(eventItem);
            var messageHtml = $('<span data-toggle="tooltip"></span>').attr('title', _event.message).html(_event.message)[0].outerHTML;
            if (0 === _event.message.indexOf("Error")) {
                messageHtml = '<span class="red2"><i class="fas fa-exclamation-circle"></i></span> ' + $(messageHtml).addClass("red2")[0].outerHTML;
            }

            var eventRowHtml = '<tr>'
                + '<td>' + messageHtml + '</td>'
                + '<td data-toggle="tooltip" title="' + _event.source + '">' + _event.source + '</td>'
                + '<td data-toggle="tooltip" title="' + _event.subObject + '">' + _event.subObject + '</td>'
                + '<td>' + _event.count + '</td>'
                + '<td>' + _event.firstSeen + '</td>'
                + '<td>' + _event.lastSeen + '</td>'
                + '</tr>';
            contents.push(eventRowHtml);
        });

        if (contents.length > 0) {
            // write event list into tbody
            $('#events_table_in_node > tbody').html(contents);
        } else {
            $('#nodeEventsnotFound').show();
            $('#nodeEventsTableHeader').hide();
        }

        viewLoading('hide');
    };

    var getEvent = function(data) {
        // message, source, sub-object, count, first-seen, last-seen
        // message is including error message
        return {
            message: data.message,
            source: (data.source.host + ": " + data.source.component),
            subObject: (data.involvedObject != null)? (data.involvedObject.kind + ": " + data.involvedObject.name) : "-",
            count: data.count,
            firstSeen: data.firstTimestamp,
            lastSeen: data.lastTimestamp
        };
    };

    var getEventsListByNode = function(namespace, nodeName, callbackFunc) {
        var reqUrl = "<%= Constants.API_URL %>/namespaces/" + namespace + "/events/node/" + nodeName;

        if (null == callbackFunc)
            callbackFunc = callbackGetNodeEvent;

        procCallAjax(reqUrl, "GET", null, null, callbackFunc);
    };

    $(document.body).ready(function () {
        viewLoading('show');
        getEventsListByNode(NAME_SPACE, G_NODE_NAME, callbackGetNodeEvent);
        viewLoading('hide');
    });
</script>
<!-- NodeEvents 끝 -->
