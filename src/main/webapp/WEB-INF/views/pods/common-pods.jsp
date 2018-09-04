<%--
  Common-pods.jsp
  @author Hyungu Cho
  @version 1.0
  @since 2018.09.03
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<h1 id="cluster_node_name" class="view-title">
    <span class="green2"><i class="fas fa-check-circle"></i></span>
</h1>
<script>
    var podName;
    var podStatus;
    var nodeName;
    var currentTab;

    var getNode = function (nodeName, callbackFunc) {
        var reqUrl = "<%= Constants.API_URL %>/nodes/" + nodeName;
        procCallAjax(reqUrl, "GET", null, null, callbackFunc);
    }

    $(document.body).ready(function () {
        var urlInfo = getURLInfo();
        nodeName = urlInfo.resource;
        currentTab = urlInfo.tab == "_default"? "details" : urlInfo.tab;


        if (nodeName == null) {
            alert("Cannot get node name.");
            //nodeName = "CANNOT_GET_NODE_NAME";
            return;
        }

        // set subject of page
        var nodeNameSubject = $("#cluster_node_name");
        nodeNameSubject.html( nodeNameSubject.html() + (" " + nodeName) );
    });
</script>