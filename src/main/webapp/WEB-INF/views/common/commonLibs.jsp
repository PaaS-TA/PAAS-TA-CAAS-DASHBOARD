<%--
  Common library

  author: REX
  version: 1.0
  since: 2018.08.02
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="details.userId" var="userId"/>
    <sec:authentication property="details.username" var="username"/>
    <sec:authentication property="details.serviceInstanceId" var="serviceInstanceId"/>
    <sec:authentication property="details.organizationGuid" var="organizationGuid"/>
    <sec:authentication property="details.spaceGuid" var="spaceGuid"/>
    <sec:authentication property="details.nameSpace" var="nameSpace"/>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <script>
        location.href='/common/error/unauthorized';
    </script>
</sec:authorize>

<!--[if lt IE 9]>
<script type="text/javascript" src="/resources/js/html5shiv.min.js"></script>
<script type="text/javascript" src="/resources/js/respond.min.js"></script>
<![endif]-->

<%--CSS--%>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/fontawesome-all.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/nanumbarungothic.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/style.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/normalize.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/bootstrap.min.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/jquery-ui.min.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/jquery.jscrollpane.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/common.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/common_new.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/gspinner.min.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/caas-common.css"/>'>
<link rel="shortcut icon" type="image/x-icon" href="<c:url value="/resources/images/favicon.ico"/>">

<%--JS--%>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-1.12.4.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.cookie.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/bootstrap.min.js"/>'></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.jscrollpane.min.js"/>"></script>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.tablesorter.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/g-spinner.min.js"/>'></script>

<script type="text/javascript">

    var RESULT_STATUS_SUCCESS  = "<%= Constants.RESULT_STATUS_SUCCESS %>";
    var RESULT_STATUS_FAIL     = "<%= Constants.RESULT_STATUS_FAIL %>";
    var URI_API_EVENTS_LIST    = "<%= Constants.API_URL %><%= Constants.URI_API_EVENTS_LIST %>";
    var URI_API_PODS_RESOURCES = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR %>";
    var URI_WORKLOADS_PODS     = "<%= Constants.URI_WORKLOAD_PODS %>";

    var USER_ID = "${userId}";
    var USER_NAME = "${username}";
    var SERVICE_INSTANCE_ID = "${serviceInstanceId}";
    var ORGANIZATION_GUID = "${organizationGuid}";
    var SPACE_GUID = "${spaceGuid}";
    var NAME_SPACE = "${nameSpace}";

    var _csrf_token = document.getElementsByName("_csrf")[0].getAttribute("content");
    var _csrf_header = document.getElementsByName("_csrf_header")[0].getAttribute("content");

</script>

<script type="text/javascript" src='<c:url value="/resources/js/common.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/caas-common.js"/>'></script>
