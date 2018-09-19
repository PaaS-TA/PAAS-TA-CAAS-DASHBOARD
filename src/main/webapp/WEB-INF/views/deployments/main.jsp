<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
    <!-- Deployments 시작 -->
    <div class="cluster_content02 row two_line two_view harf_view" style="display: block;">
        <ul class="maT30">
            <li class="cluster_first_box">
                <jsp:include page="./list.jsp" flush="true"/>
            </li>
        </ul>
    </div>
    <!-- Deployments 끝 -->
</div>

<script type="text/javascript">

    var getDeploymentsList = function() {
        viewLoading('show');
        var reqUrl = "<%= Constants.URI_API_DEPLOYMENTS_LIST %>".replace("{namespace:.+}", NAME_SPACE);
        procCallAjax(reqUrl, "GET", null, null, callbackGetDeploymentsList);
    };

    $(document.body).ready(function () {
        getDeploymentsList();
    });

</script>
