<div class="cluster_tabs clearfix">
    <ul>
        <li id="namespacesTab" name="tab01" class="cluster_tabs_on" onclick="procMovePage('/caas/clusters/namespaces/---');">Details</li>
        <li id="namespacesTab_events" name="tab02" class="cluster_tabs_right" onclick="procMovePage('/caas/clusters/namespaces/---/events');">Events</li>
    </ul>
    <div class="cluster_tabs_line"></div>
</div>

<script>
    var urlPath = window.location.href;
    var urlPathSplit = urlPath.split("/");
    var namespaceId = urlPathSplit[6];

    $("#title").html(namespaceId);

    $("#namespacesTab").attr("onclick", "procMovePage('/caas/clusters/namespaces/"+namespaceId+"');");
    $("#namespacesTab_events").attr("onclick", "procMovePage('/caas/clusters/namespaces/"+namespaceId+"/events');");

    if(urlPath.indexOf("?")  != -1) {
        urlPath = urlPath.substring(0, urlPath.indexOf("?"));
    }

    $("li[id^='namespacesTab']").attr("class", "");
    $("li[id^='namespacesTab']").addClass("cluster_tabs_right");

    if(urlPath.indexOf("/events")  != -1) {
        $("#namespacesTab_events").attr("class", "");
        $("#namespacesTab_events").addClass("cluster_tabs_on");

        $("#namespacesTab_events").removeAttr("onclick");
        $("#namespacesTab_events").attr("style", "cursor: default;");
    } else {
        $("#namespacesTab").attr("class", "");
        $("#namespacesTab").addClass("cluster_tabs_on");

        $("#namespacesTab").removeAttr("onclick");
        $("#namespacesTab").attr("style", "cursor: default;");
    }
</script>