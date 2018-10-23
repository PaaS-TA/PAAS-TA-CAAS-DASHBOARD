<%--
  ReplicaSet events
  @author CISS
  @version 1.0
  @since 2018.08.15
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonEvents.jsp"/>


<script type="text/javascript">

    // GET DETAIL
    var getDetail = function() {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_REPLICA_SETS_DETAIL%>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{replicaSetName:.+}", '<c:out value="${replicaSetName}"/>');
        procCallAjax(reqUrl, "GET", null, null, getList);
    };

    // GET LIST
    var getList = function (data) {
        var resourceName = "<c:out value='${replicaSetName}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{resourceUid:.+}", data.metadata.uid);

        procGetCommonEventsList(reqUrl, resourceName);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
