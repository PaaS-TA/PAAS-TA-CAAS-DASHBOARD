<%--
  Created by IntelliJ IDEA.
  User: GT63
  Date: 2018-08-02
  Time: 오후 3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">

<script type="text/javascript">

    var RESULT_STATUS_SUCCESS = "<%= Constants.RESULT_STATUS_SUCCESS %>";
    var RESULT_STATUS_FAIL = "<%= Constants.RESULT_STATUS_FAIL %>";

</script>
