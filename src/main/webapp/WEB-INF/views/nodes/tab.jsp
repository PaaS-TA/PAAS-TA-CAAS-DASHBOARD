<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- TODO :: REMOVE SUBJECT AND TABS -->
<h1 id="cluster_node_name" class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span>NODE_NAME</h1>
<div class="cluster_tabs clearfix">
    <ul>
        <!-- cluster_tabs_on or cluster_tabs_right -->
        <li name="tab01" class="cluster_tabs_right" id="clusters_nodes_summary" onclick="procMovePage('./summary')">Summary</li>
        <li name="tab02" class="cluster_tabs_right" id="clusters_nodes_details" onclick="procMovePage('./details')">Details</li>
        <li name="tab03" class="cluster_tabs_right" id="clusters_nodes_events" onclick="procMovePage('./events')">Events</li>
    </ul>
    <div class="cluster_tabs_line"></div>
</div>
<script>
    var nodeName;
    var currentTab;

    var getURLInfo = function() {
        var urlSplits = window.location.href.replace(/\?.*/, '').split('/');
        var slices = urlSplits.splice(urlSplits.indexOf("caas") + 1, urlSplits.length - urlSplits.indexOf("caas"));

        var valueFrame = {
            category: slices[0],
            page: slices[1]
        };

        if (slices.length > 2)
            valueFrame['selector'] = slices[2];

        if (slices.length > 3)
            valueFrame['tab'] = slices[3];
        else
            valueFrame['tab'] = '_default';

        return valueFrame;
    };

    $(document.body).ready(function () {
        var urlInfo = getURLInfo();
        nodeName = urlInfo.selector;
        currentTab = urlInfo.tab == "_default"? "details" : urlInfo.tab;


        if (nodeName == null) {
            alert("Cannot get node name.");
            //nodeName = "CANNOT_GET_NODE_NAME";
            return;
        }

        // set subject of page
        var nodeNameSubject = $("#cluster_node_name");
        nodeNameSubject.html( nodeNameSubject.html().replace("NODE_NAME", (" " + nodeName)) );

        // change style class to current page's tab and remove onclick event
        var currentTabElement = $('#clusters_nodes_' + currentTab);
        currentTabElement.removeAttr("onclick");
        currentTabElement.attr("class", "cluster_tabs_on");
        currentTabElement.attr("style", "cursor: default");
    });
</script>