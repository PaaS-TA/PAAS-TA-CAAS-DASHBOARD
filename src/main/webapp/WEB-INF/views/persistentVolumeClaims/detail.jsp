<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2019-10-28
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <c:out value="${persistentVolumeClaimName}"/></h1>
    <jsp:include page="../common/contentsTab.jsp"/>
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
                                <th><i class="cWrapDot"></i> Requested Storage</th>
                                <td id="requestedStorage"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Access Modes</th>
                                <td id="accessModes"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Volume Name</th>
                                <td id="volumeName"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Volume Mode</th>
                                <td id="volumeMode"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Capacity</th>
                                <td id="capacity"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Storage Class name</th>
                                <td id="storageClassName"></td>
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
        </ul>
    </div>
    <!-- Details  끝 -->
</div>

<script type="text/javascript">

    // GET DETAIL
    var getPersistentVolumeClaimDetail = function () {
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_STORAGES_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{persistentVolumeClaimName:.+}", "<c:out value='${persistentVolumeClaimName}'/>");

        procCallAjax(reqUrl, "GET", null, null, callbackGetPersistentVolumeClaimDetail);
    };

    // CALLBACK
    var callbackGetPersistentVolumeClaimDetail = function (data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        console.log("==================");
        console.log(JSON.stringify(data));
        console.log("==================");

        var metadata = data.metadata;
        var spec = data.spec;
        var status = data.status;

        var persistentVolumeName = metadata.name;
        var namespace = NAME_SPACE;
        var labels = procSetSelector(metadata.labels);
        var annotations = metadata.annotations;
        var creationTimestamp = metadata.creationTimestamp;
        var selector = "";
        if(spec.selector != null) {
            selector = procSetSelector(spec.selector).replace(/matchLabels=/g, '');
        }

        var accessModes = "";
        for(var i = 0; i < spec.accessModes.length; i++) {
            accessModes += '<p>' + spec.accessModes[i] + '</p>';
        }
        var requestedStorage = spec.resources.requests.storage;
        var volumeName = nvl(spec.volumeName, '-');
        var volumeMode = nvl(spec.volumeMode, '-');
        var capacity;
        if(status.capacity != null) {
            capacity = status.capacity.storage;
        } else {
            capacity = '-';
        }

        var storageClassName = spec.storageClassName;
        var status = status.phase;
        

        $('#name').html(persistentVolumeName);
        $('#namespaceID').html("<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NAMESPACES %>/" + namespace + "\");'>" + namespace);
        $('#labels').html(procCreateSpans(labels));
        $('#annotations').html(procSetAnnotations(annotations));
        $('#creationTime').html(creationTimestamp);
        $('#selector').html(nvl(procCreateSpans(selector), '-'));
        $('#requestedStorage').html(requestedStorage);
        $('#accessModes').html(accessModes);
        $('#volumeName').html(volumeName);
        $('#volumeMode').html(volumeMode);
        $('#capacity').html(capacity);
        $('#storageClassName').html(storageClassName);
        $('#status').html(status);

        procViewLoading('hide');
    };


    // ON LOAD
    $(document.body).ready(function () {
        getPersistentVolumeClaimDetail();
    });
</script>