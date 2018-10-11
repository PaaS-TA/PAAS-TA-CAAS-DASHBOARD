<%--TODO :: CREATE COMMENTS--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonEvents.jsp"/>


<script type="text/javascript">

    // GET LIST
    var getList = function () {
        var resourceName = "<c:out value='${namespace}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_NAMESPACE_EVENTS_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE);

        procGetCommonEventsList(reqUrl, resourceName);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
