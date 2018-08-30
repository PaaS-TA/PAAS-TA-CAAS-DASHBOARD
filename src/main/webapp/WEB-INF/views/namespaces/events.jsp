<%--
  Namespaces main
  @author REX
  @version 1.0
  @since 2018.08.07
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>--%>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <span id="title"></span></h1>
    <%--<%@include file="./tab.jsp" %>--%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <!-- Events 시작-->
    <div class="cluster_content02 row two_line two_view harf_view custom_display_block">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="eventList" class="table_event condition alignL">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody id="resultAreaForNameSpaceEventList">
                            </tbody>
                        </table>
                        <p id="emptyEventList" class="service_p" style="display:none;">이벤트가 없습니다.</p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Events 끝 -->
</div>

<script type="text/javascript">

    var getEventList = function(namespace, replicasetName) {
        procCallAjax("/api/namespaces/"+namespace+"/events/resource/"+replicasetName, "GET", null, null, callbackGetEventList);
    };

    var callbackGetEventList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultCode) return false;

        var htmlString = [];

        $.each(data.items, function (index, itemList) {
            var eventMessage = itemList.message;
            var sourceComponent  = itemList.source.component;
            var sourceHost   = nvl(itemList.source.host);
            var subObject    = nvl2(itemList.involvedObject.fieldPath,"-");
            var eventCount   = itemList.count;
            var firstSeen    = itemList.firstTimestamp;
            var lastSeen     = itemList.lastTimestamp;
            var eventType    = itemList.type;

            if (eventMessage.indexOf("Error creating:") != -1)
                eventMessage = "<span class=\"red2\"><i class=\"fas fa-exclamation-circle\"></i> " + eventMessage + "</span>"

            htmlString.push(
                "<tr>"
                + "<td>" + eventMessage +"</td>"
                + "<td>" + sourceComponent  +" "+sourceHost + "</td>"
                + "<td>" + subObject + "</td>"
                + "<td>" + eventCount + "</td>"
                + "<td>" + firstSeen + "</td>"
                + "<td>" + lastSeen + "</td>"
                + "</tr>"
            );
        });

        var resultArea = $("#resultAreaForNameSpaceEventList");
        var eventList = $("#eventList");
        var emptyEventList = $("#emptyEventList");

        resultArea.html("");

        if(data.items.length > 1) {
            resultArea.html(htmlString);
            emptyEventList.hide();
            eventList.show();
        } else {
            eventList.hide();
            emptyEventList.show();
        }
    };

    $(document.body).ready(function () {
        getEventList(NAME_SPACE, NAME_SPACE);
        // getEventList("hyerin-test-case", "kubernetes-ciss-test-d5f846fd7");

        var urlPath = window.location.href;
        var urlPathSplit = urlPath.split("/");
        var namespaceId = urlPathSplit[6];

        $("#title").html(namespaceId);
    });

</script>
