<%--<%@page contentType="text/html" pageEncoding="UTF-8" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="details.userid" var="userid"/>
    <sec:authentication property="details.username" var="username"/>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <script>
        location.href='/common/error/unauthorized';
    </script>
</sec:authorize>
<%
    String aa = request.getParameter("aa");
    out.println(aa);
%>
test2
<br>
<br>
userid = ${userid}
<br>
username = ${username}
<br>
