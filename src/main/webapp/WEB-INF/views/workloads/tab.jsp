<%--
  Workloads' Tab
  User: hgcho
  Date: 2018-08-30
  Time: 오전 11:03
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="cluster_tabs clearfix">
    <ul>
        <li name="tab01" class="cluster_tabs_left" id="workloads_overview" onclick="procMovePage('/caas/workloads/overview');">Overview</li>
        <li name="tab02" class="cluster_tabs_right" id="workloads_deployments" onclick="procMovePage('/caas/workloads/deployments');">Deployments</li>
        <li name="tab03" class="cluster_tabs_right" id="workloads_pods" onclick="procMovePage('/caas/workloads/pods');">Pods</li>
        <li name="tab04" class="cluster_tabs_right" id="workloads_replicasets" onclick="procMovePage('/caas/workloads/replicasets');">Replica Sets</li>

        <%--TODO :: REMOVE--%>
        <li name="tab05" class="cluster_tabs_right" onclick="procMovePage('/caas/workloads/deployments');">Deployments VIEW</li>
        <li name="tab06" class="cluster_tabs_right" onclick="procMovePage('/caas/workloads/pods');">Pods VIEW</li>
        <li name="tab07" class="cluster_tabs_right" onclick="procMovePage('/caas/workloads/replicasets');">Replica Sets VIEW</li>
    </ul>
    <div class="cluster_tabs_line"></div>
</div>
<script>
    var currentTab;

    $(document.body).ready(function () {
        currentTab = getURLInfo().page;

        // change style class to current page's tab and remove onclick event
        var tabElements = $('div.cluster_tabs > ul > li');
        $.each(tabElements, function (index, item) {
            // TODO :: REMOVE INDEX < 4 CONDITIONS (DEVELOPMENT ONLY)
            if (index < 4) {
                var _tabName = $(item).attr('id').replace('workloads_', '');
                if (_tabName == currentTab) {
                    $(item).removeAttr('onclick');
                    $(item).attr('class', 'cluster_tabs_on');
                    $(item).attr('style', 'cursor: default');
                    if (index > 1)
                        $(tabElements[index - 1]).attr('class', 'cluster_tabs_left');
                    if (index < (tabElements.length - 1))
                        $(tabElements[index + 1]).attr('class', 'cluster_tabs_right');
                } else {
                    $(item).attr('onclick', 'procMovePage("/caas/workloads/' + _tabName + '")');
                }
            }
        });
    });
</script>
