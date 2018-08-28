<div class="cluster_tabs clearfix">
    <ul>
        <li id="clustersTab_overview" name="tab01" class="cluster_tabs_on" onclick="procMovePage('/caas/clusters/overview');">Overview</li>
        <li id="clustersTab_namespaces" name="tab02" class="cluster_tabs_right" onclick="procMovePage('/caas/clusters/namespaces');">Namespaces</li>
        <li id="clustersTab_nodes" name="tab03" class="cluster_tabs_right" onclick="procMovePage('/caas/clusters/nodes');">Nodes</li>
        <li id="clustersTab_persistentVolumes" name="tab04" class="cluster_tabs_right" onclick="procMovePage('/caas/clusters/persistentVolumes');">Persistent Volumes</li>

        <%--TODO :: REMOVE--%>
        <%--<li name="tab05" class="cluster_tabs_right" onclick="procMovePage('/caas/clusters/namespaces');">Namespaces VIEW</li>--%>
        <li name="tab06" class="cluster_tabs_right" onclick="procMovePage('/caas/clusters/nodes');">Nodes VIEW</li>
        <li name="tab07" class="cluster_tabs_right" onclick="procMovePage('/caas/clusters/persistentVolumes');">Persistent Volumes VIEW</li>
    </ul>
    <div class="cluster_tabs_line"></div>
</div>

<script>
    var urlPath = window.location.href;
    var urlPathSplit = urlPath.split("/");
    var method = urlPathSplit[5];
    if(method.indexOf("?")  != -1) {
        method = urlPathSplit.substring(0, method.indexOf("?"));
    }

    $("li[id^='clustersTab_']").attr("class", "");
    $("li[id^='clustersTab_']").addClass("cluster_tabs_right");
    $("#clustersTab_"+method).attr("class", "");
    $("#clustersTab_"+method).addClass("cluster_tabs_on");
</script>