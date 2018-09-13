<%--
  Services events
  @author REX
  @version 1.0
  @since 2018.08.28
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="fa fa-file-alt" style="color:#2a6575;"></span> <c:out value="${serviceName}"/></h1>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <!-- Services Events 시작-->
    <div class="cluster_content02 row two_line two_view harf_view custom_display_block">
        <ul class="maT30">
            <li>
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
                            <tr id="noResultArea"><td colspan='6'><p class='service_p'>조회 된 Events가 없습니다.</p></td></tr>
                            <tr id="resultHeaderArea" style="display: none;">
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            <tr>
                                <td colspan="6"> - </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Services Events 끝 -->
</div>
<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />


<script type="text/javascript">

    // GET LIST
    var getList = function () {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{resourceName:.+}", document.getElementById('requestServiceName').value);
        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function (data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            return false;
        }

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        var items = data.items;
        var listLength = items.length;
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            htmlString.push(
                "<tr>"
                + "<td>" + items[i].message + "</td>"
                + "<td>" + items[i].source.component + " " + nvl(items[i].source.host) + "</td>"
                + "<td>" + nvl(items[i].involvedObject.fieldPath, "-") + "</td>"
                + "<td>" + items[i].count + "</td>"
                + "<td>" + items[i].firstTimestamp + "</td>"
                + "<td>" + items[i].lastTimestamp + "</td>"
                + "</tr>");
        }

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
        }

        viewLoading('hide');
    };


    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
