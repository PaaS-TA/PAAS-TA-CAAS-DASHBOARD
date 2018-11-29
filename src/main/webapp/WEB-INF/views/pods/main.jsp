<%--
  Pods list
  @author Hyungu Cho
  @version 1.0
  @since 2018.09.04
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="content">
    <jsp:include page="../common/contentsTab.jsp"/>

    <div class="cluster_content02 row two_line two_view harf_view" style="display: block;">
        <ul class="maT30">
            <li class="cluster_first_box">
                <jsp:include page="./list.jsp"/>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function() {
        procViewLoading('show');
        getPodsList();
        procViewLoading('hide');
    });
</script>
