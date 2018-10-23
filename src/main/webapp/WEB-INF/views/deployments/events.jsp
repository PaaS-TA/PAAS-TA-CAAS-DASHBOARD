<%--
  Deployment events
  @author PHR
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonEvents.jsp"/>


<script type="text/javascript">

    var getDetail = function() {
        viewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_DEPLOYMENTS_DETAIL %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{deploymentsName:.+}", "<c:out value='${deploymentsName}'/>");
        procCallAjax(reqUrl, "GET", null, null, getList);
    };

    // GET LIST
    var getList = function (data) {
        var resourceName = "<c:out value='${deploymentsName}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{resourceName:.+}", data.metadata.uid);

        procGetCommonEventsList(reqUrl, resourceName);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
