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
    <%--<%@include file="../clusters/tab.jsp" %>--%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <div class="cluster_content02 row two_line two_view harf_view custom_display_block">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Namespaces</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:20%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                                <tr>
                                    <td>Name</td>
                                    <td>Status</td>
                                    <td>Created on</td>
                                </tr>
                            </thead>
                            <tbody id="resultAreaForNameSpace">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript">

    var getDetail = function() {
        procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail.do", "GET", null, null, callbackGetDetail);
    };

    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultCode) return false;

        var htmlString = [];

        htmlString.push(
            "<tr>"
            + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> <a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + data.metadata.name + "</a></td>"
            + "<td>" + data.status.phase + "</td>"
            + "<td>" + data.metadata.creationTimestamp + "</td>"
            + "</tr>");

        var resultArea = $("#resultAreaForNameSpace");
        resultArea.html(htmlString);
    };

    $(document.body).ready(function () {
        getDetail();
    });

</script>