<%--
  Common library

  author: REX
  version: 1.0
  since: 2018.08.02
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="details.userid" var="userid"/>
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
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
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
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/caas-common.css"/>'>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/jquery.loadingModal.css"/>'>

<%--TODO :: REMOVE--%>
<link rel='stylesheet' type='text/css' href='<c:url value="/resources/css/jquery.jsonview.min.css"/>'>

<%--JS--%>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-1.12.4.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.cookie.js"/>'></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.splitter.js"/>"></script>
<script type="text/javascript" src='<c:url value="/resources/js/bootstrap.min.js"/>'></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.jscrollpane.min.js"/>"></script>
<script type="text/javascript" src='<c:url value="/resources/js/clipboard.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/handlebars-v4.0.11.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.tablesorter.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/json2yaml.js"/>'></script>
<%--<script type="text/javascript" src='<c:url value="/resources/js/jquery.showLoading.min.js"/>'></script>--%>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.loadingModal.js"/>'></script>

<%--TODO :: REMOVE--%>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.jsonview.min.js"/>'></script>

<%--JS :: USE ONLY ON REQUIRED PAGES--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/ElementQueries.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/img_slide.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/ResizeSensor.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/typeahead.bundle.js"/>'></script>--%>

<script type="text/javascript" src='<c:url value="/resources/js/common.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/caas-common.js"/>'></script>

<script type="text/javascript">

    var RESULT_STATUS_SUCCESS = "<%= Constants.RESULT_STATUS_SUCCESS %>";
    var RESULT_STATUS_FAIL = "<%= Constants.RESULT_STATUS_FAIL %>";

    var USER_ID = "${userid}";
    var USER_NAME = "${username}";
    var SERVICE_INSTANCE_ID = "${serviceInstanceId}";
    var ORGANIZATION_GUID = "${organizationGuid}";
    var SPACE_GUID = "${spaceGuid}";
    var NAME_SPACE = "${nameSpace}";

    var _csrf_token = document.getElementsByName("_csrf")[0].getAttribute("content");
    var _csrf_header = document.getElementsByName("_csrf_header")[0].getAttribute("content");
</script>
