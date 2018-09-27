<%--
  Created by IntelliJ IDEA.
  User: PHR, Hyungu Cho
  Date: 2018-09-04
  Time: 오전 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="content">
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

    <div class="cluster_content02 row two_line two_view harf_view" style="display: block;">
        <ul class="maT30">
            <li class="cluster_first_box">
                <jsp:include page="./list.jsp" flush="true"/>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    // GET LIST
    var getPodList = function() {
        getPodListUsingRequestURL("<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST %>".replace("{namespace:.+}", NAME_SPACE));
    };

    // ON LOAD
    $(document.body).ready(function() {
        viewLoading('show');
        getPodList();
        viewLoading('hide');
    });

</script>
