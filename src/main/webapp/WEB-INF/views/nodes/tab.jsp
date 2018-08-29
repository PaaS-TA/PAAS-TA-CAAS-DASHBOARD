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

    // TODO :: MODIFY SCRIPTS :: DO NOT USE :: let >> ONLY ECMAScript 5, NOT ECMAScript 6
    var getURLInfo = function() {
        let urlSplits = window.location.href.replace(/\?.*/, '').split('/');
        let slices = urlSplits.splice(urlSplits.indexOf("caas") + 1, urlSplits.length - urlSplits.indexOf("caas"));

        let valueFrame = {
            category: slices[0],
            page: slices[1]
        };

        if (slices.length > 2)
            valueFrame['selector'] = slices[2];

        if (slices.length > 3)
            valueFrame['tab'] = slices[3];

        return valueFrame;
    };

    $(document.body).ready(function () {
        let urlInfo = getURLInfo();
        nodeName = urlInfo.selector;
        currentTab = urlInfo.tab;

        if (nodeName == null) {
            alert("Cannot get node name.");
            //nodeName = "CANNOT_GET_NODE_NAME";
            return;
        }

        // set subject of page
        let nodeNameSubject = $("#cluster_node_name");
        nodeNameSubject.html( nodeNameSubject.html().replace("NODE_NAME", (" " + nodeName)) );

        // change style class to current page's tab
        $('#clusters_nodes_' + currentTab).attr("class", "cluster_tabs_on");

        /*
        $.each($('.cluster_tabs.clearfix > ul > li'), function (index, tab) {
            let tabElement = $(tab);
            let tabType = tabElement.attr("tab-type");
            if (tabType == currentTab)
                tabElement.attr("class", "cluster_tabs_on");
            else {
                tabElement.attr("class", "cluster_tabs_right");
                tabElement.on("click", function(event) {
                    if (currentTab != $(event.currentTarget).attr("tab-type")) {
                        let redirectURL = window.location.href.replace(
                            "/" + currentTab, ("/" + $(event.currentTarget).attr("tab-type")));
                        window.location.replace(redirectURL);
                    }
                });
            }
        });
        */

        /*
        $('.cluster_tabs.clearfix > ul > li').on("click", function(event) {
            var tabLi = $(event.currentTarget);
            var tabType = tabLi.attr("tab-type");
            tabLi.attr

            var redirectURL = window.location.href.replace("/summary", ("/" + $(event.currentTarget).attr("tab-type")));
            window.location.replace(redirectURL);
        });
        */
    });
</script>