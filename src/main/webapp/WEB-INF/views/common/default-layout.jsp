<%--
  Default layout

  author: REX
  version: 1.0
  since: 2018.08.08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
    <title><tiles:getAsString name="title" /></title>

    <%--COMMON LIBRARY :: BEGIN--%>
    <%@include file="commonLibs.jsp" %>
    <%--COMMON LIBRARY :: END--%>

</head>
<body>
    <header id="header">
        <div style="height: 100px; padding: 10px; background-color: #ffff77;">
            <tiles:insertAttribute name="header" />
        </div>
    </header>

    <div style="width: 100%; background-color: #99ff77;">
        <div style="float: left; width: 200px; min-height: 550px; padding: 10px;">
        <section id="section-left-menu">
            <tiles:insertAttribute name="left-menu" />
        </section>
        </div>

        <div style="margin-left: 200px; min-height: 550px; background-color: #ffffff;">
        <section id="section-body">
            <div id="body-contents">
                <tiles:insertAttribute name="body" />
            </div>
        </section>
        </div>
    </div>
    <div style="clear: both;"></div>
    <div style="height: 100px; padding: 10px; background-color: #ffcc77;">
        <footer id="footer">
            <tiles:insertAttribute name="footer" />
        </footer>
    </div>
</body>
</html>
