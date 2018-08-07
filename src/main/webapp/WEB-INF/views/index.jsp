<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>

    <%--COMMON LIBRARY :: BEGIN--%>
    <%@include file="common/commonLibs.jsp" %>
    <%--COMMON LIBRARY :: END--%>

</head>
<body>
<div style="padding: 10px;">
    인덱스 페이지 입니다.
</div>
<div style="padding: 10px;">
    <ul>
        <li><a href="javascript:void(0);" onclick="procMovePage('/users');">[ USERS ]</a></li>
        <li><a href="javascript:void(0);" onclick="procMovePage('/cluster/namespaces');">[ NAMESPACES ]</a></li>
        <%--TODO :: MODIFY--%>
        <li><a href="javascript:void(0);" onclick="procMovePage('/cluster/main');">[ CLUSTER ]</a></li>
    </ul>
</div>
</body>
</html>
