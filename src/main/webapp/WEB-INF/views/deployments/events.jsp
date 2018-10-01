<%--
  Deployment main
  @author PHR
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>

<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <c:out value="${deploymentsName}"/> </h1>
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
                       <table class="table_event condition alignL service-lh" >
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

<input type="hidden" id="requestDeploymentsName" name="requestDeploymentsName" value="<c:out value='${deploymentsName}' default='' />" />

<script type="text/javascript">

    var getDetail = function() {
        viewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>".replace("{namespace:.+}", NAME_SPACE)
                                                                                    .replace("{resourceName:.+}", document.getElementById('requestDeploymentsName').value);
        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
    };

    // CALLBACK
    var callbackGetList = function (data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
            return false;
        }

        var listLength = data.items.length;

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        $.each(data.items, function (index, itemList) {
            var message = itemList.message;
            var source = itemList.source.component;
            var subObject = itemList.involvedObject.fieldPath;
            var count = itemList.count;
            var fristTimestamp = itemList.firstTimestamp;
            var lastTimestamp = itemList.lastTimestamp;
            var subObjectObject = "";
            if(!subObject) {
                subObjectObject = "<td>" + nvl(subObject, "-") + "</td>";
            } else {
                subObjectObject = "<td><p>" + subObject + "</p></td>";
            }
            resultArea.append("<tr>"
                                + "<td><p>" + message + "</p></td>"
                                + "<td><p>" + source + "</p></td>"
                                + subObjectObject
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

        procSetToolTipForTableTd('resultArea');
        viewLoading('hide');
    };

    $(document.body).ready(function () {
        getDetail();
    });

</script>
