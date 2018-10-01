<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  ReplicaSet events
  @author CISS
  @version 1.0
  @since 2018.08.15
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <c:out value="${replicaSetName}"/></h1>
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
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='.'>
                                <col style='.'>
                                <col style='.'>
                                <col style='.'>
                                <col style='.'>
                                <col style='.'>
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

    // GET LIST
    var getList = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{resourceName:.+}", '<c:out value="${replicaSetName}"/>');

        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
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
                    + "<td><p>" + items[i].message + "</p></td>"
                    + "<td><p>" + items[i].source.component + " " + nvl(items[i].source.host) + "</p></td>"
                    + "<td><p>" + nvl(items[i].involvedObject.fieldPath, "-") + "</p></td>"
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

        procSetToolTipForTableTd('resultArea');
        viewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        getList();
    });

</script>