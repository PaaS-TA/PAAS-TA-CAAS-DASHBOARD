<%--
  Pods events
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonEvents.jsp"/>

<script type="text/javascript">

    var getPod = function () {
        var resourceName = '<c:out value="${podName}" default="" />';

        var reqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_PODS_DETAIL %>'
            .replace('{namespace:.+}', NAME_SPACE).replace('{podName:.+}', resourceName);

        procCallAjax(reqUrl, 'GET', null, null, getList);

    };

    // GET POD'S EVENT LIST
    var getList = function(data) {
        var resourceName = '<c:out value="${podName}" default="" />';

        var reqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>'
            .replace('{namespace:.+}', NAME_SPACE).replace('{resourceUid:.+}', data.metadata.uid);
        procGetCommonEventsList(reqUrl, resourceName);
    };

    // ON LOAD
    $(document.body).ready(function() {
        getPod();
    });
</script>
