<%--
  Services events
  @author REX
  @version 1.0
  @since 2018.08.28
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonEvents.jsp"/>

<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />
<script type="text/javascript">

    // GET LIST
    var getList = function () {
        var resourceName = "<c:out value='${serviceName}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{resourceUid:.+}", resourceName + '?type=service');

        procGetCommonEventsList(reqUrl, resourceName);
    };

    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
