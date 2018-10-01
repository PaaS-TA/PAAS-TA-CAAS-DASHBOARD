<%--TODO :: CREATE COMMENTS--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonEvents.jsp"/>


<script type="text/javascript">

    // GET LIST
    var getList = function () {
        var resourceName = "<c:out value='${namespace}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{resourceName:.+}", resourceName);

        procGetCommonEventsList(reqUrl, resourceName);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>


<%--TODO :: REMVOE AFTER CHECK--%>
<%--&lt;%&ndash; // TODO :: REMOVE PAGE? &ndash;%&gt;--%>
<%--<%@ page import="org.paasta.caas.dashboard.common.Constants" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>

<%--<div class="content">--%>
    <%--<h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <span id="title"></span></h1>--%>
    <%--<jsp:include page="../common/contentsTab.jsp" flush="true"/>--%>
    <%--<!-- Events 시작-->--%>
    <%--<div class="cluster_content02 row two_line two_view harf_view custom_display_block">--%>
        <%--<ul class="maT30">--%>
            <%--<li>--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Events</p>--%>
                    <%--</div>--%>
                    <%--<div class="view_table_wrap">--%>
                        <%--&lt;%&ndash;<table id="eventList" class="table_event condition alignL">&ndash;%&gt;--%>
                        <%--<table class="table_event condition alignL">--%>
                            <%--<colgroup>--%>
                                <%--<col style=".">--%>
                                <%--<col style=".">--%>
                                <%--<col style=".">--%>
                                <%--<col style=".">--%>
                                <%--<col style=".">--%>
                                <%--<col style=".">--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                            <%--<tr id="noResultArea" style="display: none;"><td colspan='6'><p class='service_p'>조회 된 Events가 없습니다.</p></td></tr>--%>
                            <%--<tr id="resultHeaderArea">--%>
                                <%--<td>Message</td>--%>
                                <%--<td>Source</td>--%>
                                <%--<td>Sub-object</td>--%>
                                <%--<td>Count</td>--%>
                                <%--<td>First seen</td>--%>
                                <%--<td>Last seen</td>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody id="resultArea">--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                        <%--&lt;%&ndash;<p id="emptyEventList" class="service_p" style="display:none;">조회 된 Events가 없습니다.</p>&ndash;%&gt;--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
        <%--</ul>--%>
    <%--</div>--%>
    <%--<!-- Events 끝 -->--%>
<%--</div>--%>

<%--<script type="text/javascript">--%>

    <%--var getEventList = function(namespace, replicasetName) {--%>
        <%--viewLoading('show');--%>

        <%--var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"--%>
            <%--.replace("{namespace:.+}", namespace)--%>
            <%--.replace("{resourceName:.+}", replicasetName);--%>

        <%--procCallAjax(reqUrl, "GET", null, null, callbackGetEventList);--%>
    <%--};--%>

    <%--var callbackGetEventList = function(data) {--%>
        <%--if (!procCheckValidData(data)) {--%>
            <%--return false;--%>
        <%--}--%>

        <%--var htmlString = [];--%>

        <%--$.each(data.items, function (index, itemList) {--%>
            <%--var eventMessage = itemList.message;--%>
            <%--var sourceComponent  = itemList.source.component;--%>
            <%--var sourceHost   = nvl(itemList.source.host);--%>
            <%--var subObject    = nvl(itemList.involvedObject.fieldPath,"-");--%>
            <%--var eventCount   = itemList.count;--%>
            <%--var firstSeen    = itemList.firstTimestamp;--%>
            <%--var lastSeen     = itemList.lastTimestamp;--%>
            <%--var eventType    = itemList.type;--%>

            <%--if (eventMessage.indexOf("Error creating:") != -1)--%>
                <%--eventMessage = "<span class=\"red2\"><i class=\"fas fa-exclamation-circle\"></i> " + eventMessage + "</span>"--%>

            <%--htmlString.push(--%>
                <%--"<tr>"--%>
                <%--+ "<td>" + eventMessage +"</td>"--%>
                <%--+ "<td>" + sourceComponent  +" "+sourceHost + "</td>"--%>
                <%--+ "<td>" + subObject + "</td>"--%>
                <%--+ "<td>" + eventCount + "</td>"--%>
                <%--+ "<td>" + firstSeen + "</td>"--%>
                <%--+ "<td>" + lastSeen + "</td>"--%>
                <%--+ "</tr>"--%>
            <%--);--%>
        <%--});--%>

        <%--var resultArea = $("#resultArea");--%>
        <%--var resultHeaderArea = $('#resultHeaderArea');--%>
        <%--var noResultArea = $('#noResultArea');--%>

        <%--resultArea.html("");--%>

        <%--if(data.items.length > 1) {--%>
            <%--resultArea.html(htmlString);--%>
            <%--noResultArea.hide();--%>
            <%--resultHeaderArea.show();--%>
            <%--resultArea.show();--%>
        <%--} else {--%>
            <%--resultHeaderArea.hide();--%>
            <%--resultArea.hide();--%>
            <%--noResultArea.show();--%>
        <%--}--%>

        <%--viewLoading('hide');--%>
    <%--};--%>

    <%--$(document.body).ready(function () {--%>
        <%--var namespace = '<c:out value="${namespace}"/>';--%>

        <%--getEventList(NAME_SPACE, namespace);--%>

        <%--$("#title").html(namespace);--%>
    <%--});--%>

<%--</script>--%>
