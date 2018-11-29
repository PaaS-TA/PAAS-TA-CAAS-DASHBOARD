<%--
  Common events
  @author REX
  @version 1.0
  @since 2018.10.01
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <span id="commonEventsViewTitle"> - </span></h1>
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
    <!-- Events 시작-->
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
                            <tr id="noResultCommonEventsArea"><td colspan='6'><p class='service_p'>조회 된 Event가 없습니다.</p></td></tr>
                            <tr id="resultHeaderCommonEventsArea" style="display: none;">
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody id="resultCommonEventsArea">
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
    <!-- Events 끝 -->
</div>


<script type="text/javascript">

    // GET LIST
    var procGetCommonEventsList = function (reqUrl, titleString) {
        procViewLoading('show');

        $('#commonEventsViewTitle').html(titleString);
        procCallAjax(reqUrl, "GET", null, null, callbackProcGetCommonEventsList);
    };


    // CALLBACK
    var callbackProcGetCommonEventsList = function (data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        var resultCommonEventsArea = $('#resultCommonEventsArea');
        var resultHeaderCommonEventsArea = $('#resultHeaderCommonEventsArea');
        var noResultCommonEventsArea = $('#noResultCommonEventsArea');

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
            resultHeaderCommonEventsArea.hide();
            resultCommonEventsArea.hide();
            noResultCommonEventsArea.show();
        } else {
            noResultCommonEventsArea.hide();
            resultHeaderCommonEventsArea.show();
            resultCommonEventsArea.show();
            resultCommonEventsArea.html(htmlString);
        }

        procSetToolTipForTableTd('resultCommonEventsArea');
        procViewLoading('hide');
    };

</script>
