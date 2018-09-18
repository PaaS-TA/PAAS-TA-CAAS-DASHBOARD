<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="content">
    <jsp:include page="commonNodes.jsp" flush="true"/>
    
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

    <!-- Nodes Details 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box" id="nodeDetailNotFound" style="display:none;">Node의 정보를 가져오지 못했습니다.</li>
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
                                <td id="node_name"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td id="node_labels" class="labels_wrap"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="node_annotations" class="labels_wrap"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="node_created_at"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Addresses</th>
                                <td id="node_addresses" class="labels_wrap"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Pod CIDR</th>
                                <td id="node_pod_cidr"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Unschedulable</th>
                                <td id="node_unschedulable"></td>
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
                                <td id="node_machine_id"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> System UUID</th>
                                <td id="node_system_uuid"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Boot ID</th>
                                <td id="node_boot_id"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kernel Version</th>
                                <td id="node_kernel_version"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> OS Images</th>
                                <td id="node_images"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Container Runtime Version</th>
                                <td id="node_container_version"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kubelet version</th>
                                <td id="node_kubenet_version"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kube-Proxy Version</th>
                                <td id="node_kubeproxy_version"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Operation system</th>
                                <td id="node_os_name"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Architecture</th>
                                <td id="node_architecture"></td>
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
    // SET CONTENT TO LAYER POP MODAL
    var setLayerpop = function(eventElement) {
        var select = $(eventElement);
        var title = select.data('title');
        if (title instanceof Object) {
            title = JSON.stringify(title);
        }

        var content = select.data('content');
        if (content instanceof Object) {
            content = '<p>' + JSON.stringify(content) + '</p>';
        } else {
            content = '<p>' + content + '</p>';
        }

        $('.modal-title').html(title);
        $('.modal-body').html(content);
    };

    // CREATE SPANS FUNCTION FOR LABEL, ANNOTATION
    var createSpans = function(inputData, type) {
        var data = inputData.replace(/=/g, ':').split(/,\s/);
        var spanHtml = "";

        $.each(data, function(index, item) {
            if (type === "true" && index > 0)
                spanHtml += '<br>';

            var htmlString = null;
            var separatorIndex = item.indexOf(": ");
            if (separatorIndex > 0) {
                var title = item.substring(0, separatorIndex);
                var content = item.substring(separatorIndex + 2);
                try {
                    var test = JSON.parse(content);    // JSON object test only
                    if (test instanceof Object || test instanceof Array) {
                        htmlString = $('<span class="bg_blue" onclick="setLayerpop(this)" data-target="#layerpop3" data-toggle="modal" '
                            + 'data-title="' + title + '"><a>' + title + '</a></span> ')
                            .attr('data-content', content).wrapAll("<div/>").parent().html();
                    }
                } catch (e) {
                }
            }

            if (null == htmlString)
                htmlString = '<span class="bg_gray">' + item.replace(": ", ":") + '</span>';

            spanHtml += (htmlString + ' ');
        });

        return spanHtml;
    };

    // STRINGIFY KEY-VALUE FUNCTION
    var stringifyKeyValue = function(data, mapFunc) {
        if (data instanceof Array) {
            if (null == mapFunc)
                arrayFunc = function(index, item) {
                    return item
                };

            return data.map(mapFunc).reduce(function(prevItem, item) {
                return prevItem + ", " + item;
            });
        } else {
            return Object.keys(data).map(function(key) {
                return key + ": " + data[key];
            })
                .reduce(function(prevItem, item) {
                    return prevItem + ", " + item;
                });
        }
    };

    // CALLBACK GET NODE DETAIL
    var callbackGetNodeDetail = function(data) {
        viewLoading('show');

        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage(nvl(data.resultMessage, "Node 정보를 가져오지 못했습니다."), false);
            $("#nodeDetailNotFound").show();
            return;
        }

        var metadata = data.metadata;
        var spec = data.spec;
        var status = data.status;

        // name, labels, annotations, created-at, addresses, pod-cidr, unschedulable
        var name = metadata.name;
        var labels = stringifyKeyValue(metadata.labels);
        var annotations = stringifyKeyValue(metadata.annotations);
        var createdAt = metadata.creationTimestamp;
        var addresses = stringifyKeyValue(status.addresses, function(item) {
            return item.type + ": " + item.address;
        });
        var podCIDR = spec.podCIDR;
        var unschedulable = spec.taints != null ?
            spec.taints.filter(
                function(item) {
                    return item.key === 'node-role.kubernetes.io/master' && item.effect !== 'NoSchedule';
                }).length > 0 : false;

        // get datum : system info
        var nodeInfo = status.nodeInfo;

        // basic info
        $('#node_name').html(name);
        $('#node_labels').html(createSpans(labels, "false"));
        $('#node_annotations').html(createSpans(annotations, "false"));
        $('#node_created_at').html(createdAt);
        $('#node_addresses').html(createSpans(addresses, "false"));
        $('#node_pod_cidr').html(podCIDR);
        $('#node_unschedulable').html(unschedulable.toString());

        // system info
        $('#node_machine_id').html(nodeInfo.machineID);
        $('#node_system_uuid').html(nodeInfo.systemUUID);
        $('#node_boot_id').html(nodeInfo.bootID);
        $('#node_kernel_version').html(nodeInfo.kernelVersion);
        $('#node_images').html(nodeInfo.osImage);
        $('#node_container_version').html(nodeInfo.containerRuntimeVersion);
        $('#node_kubenet_version').html(nodeInfo.kubeletVersion);
        $('#node_kubeproxy_version').html(nodeInfo.kubeProxyVersion);
        $('#node_os_name').html(nodeInfo.operatingSystem);
        $('#node_architecture').html(nodeInfo.architecture);

        viewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        viewLoading('show');
        getNode(G_NODE_NAME, callbackGetNodeDetail);
        viewLoading('hide');
    });
</script>
<!-- Nodes Details 끝 -->
