<%--
  Default layout

  author: REX
  version: 1.0
  since: 2018.08.08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta content='IE=edge' http-equiv='X-UA-Compatible'/>
    <meta name='format-detection' content='telephone=no'/>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
    <title><tiles:getAsString name="title"/></title>

    <%--COMMON LIBRARY :: BEGIN--%>
    <%@include file="commonLibs.jsp" %>
    <%--COMMON LIBRARY :: END--%>

</head>
<body>
    <div class="wrap dashboard">
        <tiles:insertAttribute name="header"/>
        <tiles:insertAttribute name="left-menu"/>
        <div class="contain">
            <tiles:insertAttribute name="body"/>
            <tiles:insertAttribute name="footer"/>
        </div>
    </div>
    <div>
        <tiles:insertAttribute name="modal"/>
    </div>
    <textarea id="out_a" title="">
    </textarea>
</body>
</html>
