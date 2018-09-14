<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="content">
    <jsp:include page="common-pods.jsp" flush="true"/>

    <%-- NODES HEADER INCLUDE --%>
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
    $(document.body).ready(function () {
        viewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>".replace("{namespace:.+}", NAME_SPACE)
            .replace("{resourceName:.+}", G_POD_NAME);
        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
        viewLoading('hide');
    });

    // CALLBACK
    var callbackGetList = function (data) {
        viewLoading('show');

        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Pod 정보를 가져오지 못했습니다.", false);
            $('#noResultArea').children().html("Pod의 Event 목록을 가져오지 못했습니다.");
            $('#noResultArea').show();
            $('#resultHeaderArea').hide();
            return;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var listLength = data.items.length;

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        $.each(data.items, function (index, itemList) {
            var messageHtml = $('<span data-toggle="tooltip"></span>').attr('title', itemList.message).html(itemList.message)[0].outerHTML;
            if (0 == itemList.message.indexOf("Error")) {
                messageHtml = '<span class="red2"><i class="fas fa-exclamation-circle"></i></span> ' + $(messageHtml).addClass("red2")[0].outerHTML;
            }
            var source = (itemList.source.component + ': ' + itemList.source.host);
            var subObject = "";
            if ("Pod" === itemList.involvedObject.kind && G_POD_NAME === itemList.involvedObject.name) {
                subObject = "-";
            } else {
                subObject = (itemList.involvedObject != null)? (itemList.involvedObject.kind + ': ' + itemList.involvedObject.name) : '-';
            }
            var count = itemList.count;
            var fristTimestamp = itemList.firstTimestamp;
            var lastTimestamp = itemList.lastTimestamp;
            resultArea.append("<tr>"
                + "<td>" + messageHtml + "</td>"
                + "<td data-toggle='tooltip' title='" + source + "'>" + source + "</td>"
                + "<td data-toggle='tooltip' title='" + subObject + "'>" + subObject + "</td>"
                + "<td>" + count + "</td>"
                + "<td>" + fristTimestamp + "</td>"
                + "<td>" + lastTimestamp + "</td>"
                + "</tr>");
        });

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
        }

        viewLoading('hide');
    };
</script>
