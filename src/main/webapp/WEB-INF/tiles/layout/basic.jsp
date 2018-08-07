<%--
  Basic template for Tiles

  author: REX
  version: 1.0
  since: 2018.08.07
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
    <title><tiles:getAsString name="title" /></title>
</head>
<body>
    <header id="header">
        <tiles:insertAttribute name="header" />
    </header>

    <section id="section-left-menu">
        <tiles:insertAttribute name="left-menu" />
    </section>

    <section id="section-body">
        <div id="body-contents">
            <tiles:insertAttribute name="body" />
        </div>
    </section>

    <footer id="footer">
        <tiles:insertAttribute name="footer" />
    </footer>
</body>
</html>
