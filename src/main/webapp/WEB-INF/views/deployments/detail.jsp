<%--
  Deployment main
  @author PHR
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>

<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <c:out value="${deploymentsName}"/></h1>
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Details</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td id="name"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td id="namespaceID"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td id="labels" class="labels_wrap"></td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="annotations" class="labels_wrap">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="creationTime"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Selector</th>
                                <td id="selector"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Strategy</th>
                                <td id="strategy"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Min ready seconds</th>
                                <td id="minReadySeconds"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Revision history limit</th>
                                <td id="revisionHistoryLimit"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Rolling update strategy</th>
                                <td id="rollingUpdateStrategy"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td id="status"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Replica Set 시작 -->
            <li class="cluster_third_box">
                <jsp:include page="../replicasets/list.jsp" flush="true"/>
            </li>
            <!-- Replica Set 끝 -->
            <!-- Pods 시작 -->
            <li class="cluster_third_box maB50">
                <jsp:include page="../pods/list.jsp" flush="true"/>
            </li>
            <!-- Pods 끝 -->
        </ul>
    </div>
    <!-- Details  끝 -->
</div>

<script type="text/javascript">

    var getDetail = function() {
        viewLoading('show');
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_DEPLOYMENTS_DETAIL %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{deploymentsName:.+}", "<c:out value='${deploymentsName}'/>");
        procCallAjax(reqUrl, "GET", null, null, callbackGetDeployments);
    };

    // GET DETAIL FOR PODS LIST
    var getDetailForPodsList = function(selector) {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{selector:.+}", selector);
        getPodListUsingRequestURL(reqUrl);
        viewLoading('hide');
    };

    var callbackGetDeployments = function (data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
            return false;
        }

        var metadata = data.metadata;
        var spec = data.spec;
        var status = data.status;

        var deployName = metadata.name;
        var namespace = NAME_SPACE;
        var labels = procSetSelector(metadata.labels);
        var annotations = metadata.annotations;
        var creationTimestamp = metadata.creationTimestamp;

        var selector = procSetSelector(spec.selector).replace(/matchLabels=/g, '');
        var strategy = spec.strategy.type;
        var minReadySeconds = spec.minReadySeconds;
        var revisionHistoryLimit = spec.revisionHistoryLimit;
        var rollingUpdateStrategy = "Max surge: " + spec.strategy.rollingUpdate.maxSurge + ", "
                                    + "Max unavailable: " + spec.strategy.rollingUpdate.maxUnavailable;

        var updatedReplicas = status.updatedReplicas;
        var totalReplicas = status.replicas;
        var availableReplicas = status.availableReplicas;
        var unavailableReplicas = status.unavailableReplicas;
        var replicaStatus = updatedReplicas + " updated, "
            + totalReplicas + " total, "
            + availableReplicas + " available, "
            + unavailableReplicas + " unavailable";

        document.getElementById("name").textContent = deployName;
        document.getElementById("namespaceID").innerHTML = "<td><a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NAMESPACES %>/" + namespace + "\");'>" + namespace + "</td>";
        document.getElementById("labels").innerHTML = procCreateSpans(labels);
        document.getElementById("annotations").innerHTML = createAnnotations(annotations);
        document.getElementById("creationTime").textContent = creationTimestamp;
        document.getElementById("selector").innerHTML = procCreateSpans(selector);
        document.getElementById("strategy").textContent = strategy;
        document.getElementById("minReadySeconds").textContent = minReadySeconds;
        document.getElementById("revisionHistoryLimit").textContent = revisionHistoryLimit;
        document.getElementById("rollingUpdateStrategy").textContent = rollingUpdateStrategy;
        document.getElementById("status").textContent = replicaStatus;

        getReplicaSetsList(replaceLabels(selector));
        getDetailForPodsList(replaceLabels(selector));

    };

    var replaceLabels = function (data) {
        return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D');
    };

    //3개 일때는 동작하지 않을 수 있음.
    var createAnnotations = function (annotations) {
        var tempStr = "";
        Object.keys(annotations).forEach(function (key) {
            var annotation = annotations[key];
            if(typeof JSON.parse(annotation) == 'object') {
                tempStr += '<span class="bg_blue"><a href="#" data-target="#layerpop3" data-toggle="modal">' + key + '</a></span>';
                $('.modal-title').html(key);
                $(".modal-body").html('<p>' + annotation + '</p>');
            } else {
                tempStr += procCreateSpans(key + ":"+ annotation);
            }
        });
        return tempStr;
    };

    $(document.body).ready(function () {
        getDetail();
    });

</script>
