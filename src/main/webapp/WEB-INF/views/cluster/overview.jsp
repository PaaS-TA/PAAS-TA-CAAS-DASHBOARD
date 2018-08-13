<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>main</title>

    <script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>

    <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet">

    <script type="text/javascript" src="<c:url value='/resources/js/jquery.jsonPresenter.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.jsonPresenter.css' />" rel="stylesheet">

</head>
<body class="hold-transition login-page">

<div>
    <br>
        <div class="mt50 ml50">
            <img src="<c:url value='/resources/images/flower.png' />">
        </div>
    </span>
</div>
<span> OVERVIEW 화면입니다.</span></br>

<c:choose>
    <c:when test="${!empty sessionScope.REPLICASET_VIEW}">
       <span> LIST(VIEW) 영역 입니다.</span></br>
        <c:choose>
            <c:when test="${!empty sessionScope.REPLICASET_EXCUTE}">
                <span> 실행(EXCUTE) 영역 입니다.</span></br>
            </c:when>
            <c:when test="${!empty sessionScope.REPLICASET_DELETE}">
                <span> 삭제(DELETE)버튼 영역 입니다.</span></br>
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <span> REPLICASET-VIEW 를 찾지 못함.</span></br>
    </c:otherwise>
</c:choose>

<!-- if 문법 참고용입니다.
     실제로 아래 경우에는 c:choose c:when c:otherwise 사용 권장 -->
<c:if test="${empty sessionScope}">
    <button><a href="/accept/ruleset">Admin Session Create.</a></button></br>
</c:if>

<c:if test="${!empty sessionScope}">
    <button><a href="/session/invalidate">Admin Session Remove.</a></button>
</c:if>



<script type="text/javascript">

    // JavaScript 내에서 session 참조시
    var approver 		 = '<c:out value="${sessionScope.approver}"/>';
    console.log("approver:::"+approver);

    $(document).ready(function(){
//        $("#namespaces").on("click", function (e) {
//            getNamespaces();
//        });
//
//        $("#pods").on("click", function (e) {
//            getPods();
//        });

    });
</script>
</body>
</html>


