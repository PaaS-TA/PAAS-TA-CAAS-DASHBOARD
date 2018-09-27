<%--
  Common-nodes.jsp
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1 id="cluster_node_name" class="view-title"></h1>
<script type="text/javascript">
    var G_NODE_NAME = '<c:out value="${nodeName}"/>';

    // GET NODE
    var getNode = function(nodeName, callbackFunc) {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_NODES_LIST %>".replace("{nodeName:.+}", nodeName);
        procCallAjax(reqUrl, "GET", null, null, callbackFunc);
    };

    // ON LOAD
    $(document.body).ready(function() {
        viewLoading('show');

        var iconHtml = '<span class="fa fa-file-alt" style="color:#2a6575;"></span> ';
        $("#cluster_node_name").html(iconHtml + G_NODE_NAME);

        viewLoading('hide');
    });
</script>
