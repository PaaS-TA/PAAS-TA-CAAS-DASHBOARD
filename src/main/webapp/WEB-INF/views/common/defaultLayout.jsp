<%--
  Default layout

  author: REX
  version: 1.0
  since: 2018.08.08
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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

    <%@include file="commonLibs.jsp" %>

</head>
<body>
    <div class="wrap dashboard" id="dashboardWrap" style="display: none;">
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
    <div>
        <tiles:insertAttribute name="alert"/>
    </div>
    <div>
        <tiles:insertAttribute name="loadingSpinner"/>
    </div>
</body>
</html>
