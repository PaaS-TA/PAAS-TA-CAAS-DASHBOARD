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
        <!-- cluster_tabs_left or cluster_tabs_on or cluster_tabs_right -->
        <li name="tab01" class="cluster_tabs_left" id="clusters_nodes_summary">Summary</li>
        <li name="tab02" class="cluster_tabs_right" id="clusters_nodes_details">Details</li>
        <li name="tab03" class="cluster_tabs_right" id="clusters_nodes_events">Events</li>
    </ul>
    <div class="cluster_tabs_line"></div>
</div>
<script>
    var nodeName;
    var currentTab;

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
        nodeNameSubject.html( nodeNameSubject.html().replace("NODE_NAME", (" " + nodeName)) );

        // change style class to current page's tab and remove onclick event
        var tabElements = $('div.cluster_tabs > ul > li');
        $.each(tabElements, function (index, item) {
            var _tabName = $(item).attr('id').replace('clusters_nodes_', '');
            if (_tabName == currentTab) {
                $(item).removeAttr('onclick');
                $(item).attr('class', 'cluster_tabs_on');
                $(item).attr('style', 'cursor: default');
                if (index > 1)
                    $(tabElements[index - 1]).attr('class', 'cluster_tabs_left');
                if (index < (tabElements.length - 1))
                    $(tabElements[index + 1]).attr('class', 'cluster_tabs_right');
            } else {
                $(item).attr('onclick', 'procMovePage("/caas/clusters/nodes/' + nodeName + '/' + _tabName + '")');
            }
        });
    });
</script>