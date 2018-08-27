<%--
  Header

  author: REX
  version: 1.0
  since: 2018.08.07
--%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="details.userid" var="userid"/>
    <sec:authentication property="details.username" var="username"/>
    <sec:authentication property="details.serviceInstanceId" var="serviceInstanceId"/>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <script>
        location.href='/common/error/unauthorized';
    </script>
</sec:authorize>
<div>Header</div>

<br>
userid = ${userid}
<br>
username = ${username}
<br>
serviceInstanceId = ${serviceInstanceId}
<br>
