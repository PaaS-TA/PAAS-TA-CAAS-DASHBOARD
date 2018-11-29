<%--
  Nodes details
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span>
        <c:out value="${nodeName}" default="-"/></h1>

    <jsp:include page="../common/contentsTab.jsp"/>

    <!-- Nodes Details 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
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
                                <td id="node_name"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td id="node_labels" class="labels_wrap"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="node_annotations" class="labels_wrap"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="node_created_at"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Addresses</th>
                                <td id="node_addresses" class="labels_wrap"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Pod CIDR</th>
                                <td id="node_pod_cidr"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Unschedulable</th>
                                <td id="node_unschedulable"> -</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_second_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>System info</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Machine ID</th>
                                <td id="node_machine_id"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> System UUID</th>
                                <td id="node_system_uuid"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Boot ID</th>
                                <td id="node_boot_id"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kernel Version</th>
                                <td id="node_kernel_version"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> OS Images</th>
                                <td id="node_images"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Container Runtime Version</th>
                                <td id="node_container_version"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kubelet version</th>
                                <td id="node_kubenet_version"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kube-Proxy Version</th>
                                <td id="node_kubeproxy_version"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Operation system</th>
                                <td id="node_os_name"> -</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Architecture</th>
                                <td id="node_architecture"> -</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">

    // GET NODE
    var getNode = function() {
        var resourceName = '<c:out value="${nodeName}" default="" />';
        var reqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_NODES_LIST %>'
            .replace('{nodeName:.+}', resourceName);

        procCallAjax(reqUrl, 'GET', null, null, callbackGetNodeDetail);
    };

    // REPLACE FIRST LETTER ONLY TO UPPER-CASE ALPHABET LETTER FROM EXTERNAL STRING(OR OBJECT)
    var upperCaseFirstLetterOnly = function(obj) {
        return (obj + '').charAt(0).toUpperCase() + (obj + '').substring(1);
    };

    // CALLBACK GET NODE DETAIL
    var callbackGetNodeDetail = function(data) {
        procViewLoading('show');

        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return;
        }

        var metadata = data.metadata;
        var spec = data.spec;
        var status = data.status;

        var labels = procSetSelector(metadata.labels);
        var annotations = metadata.annotations;
        var addressesObj = {};
        for (var i = 0; i < status.addresses.length; i++) {
            addressesObj[status.addresses[i]['type']] = status.addresses[i]['address'];
        }

        var addresses = procSetSelector(addressesObj);
        var unschedulable = false;
        if ('' !== nvl(spec.taints) && spec.taints instanceof Array) {
            for (var i = 0; i < spec.taints.length; i++) {
                if (spec.taints[i].key === 'node-role.kubernetes.io/master' && spec.taints[i].effect !== 'NoSchedule') {
                    unschedulable = true;
                    break;
                }
            }
        }

        var nodeInfo = status.nodeInfo;

        $('#node_name').html(metadata.name);
        $('#node_labels').html(procCreateSpans(labels));
        $('#node_annotations').html(procSetAnnotations(annotations));
        $('#node_created_at').html(metadata.creationTimestamp);
        $('#node_addresses').html(procCreateSpans(addresses));
        $('#node_pod_cidr').html(nvl(spec.podCIDR, ' -'));
        $('#node_unschedulable').html(upperCaseFirstLetterOnly(unschedulable));

        $('#node_machine_id').html(nvl(nodeInfo.machineID, ' -'));
        $('#node_system_uuid').html(nvl(nodeInfo.systemUUID, ' -'));
        $('#node_boot_id').html(nvl(nodeInfo.bootID, ' -'));
        $('#node_kernel_version').html(nodeInfo.kernelVersion);
        $('#node_images').html(nodeInfo.osImage);
        $('#node_container_version').html(nodeInfo.containerRuntimeVersion);
        $('#node_kubenet_version').html(nodeInfo.kubeletVersion);
        $('#node_kubeproxy_version').html(nodeInfo.kubeProxyVersion);
        $('#node_os_name').html(nodeInfo.operatingSystem);
        $('#node_architecture').html(nodeInfo.architecture);

        procViewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        getNode();
    });
</script>
<!-- Nodes Details 끝 -->
