<%--
  Nodes detail
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
    // SET CONTENT TO LAYER POP MODAL
    var setLayerpop = function(eventElement) {
        var select = $(eventElement);
        var title = JSON.stringify(select.data('title')).replace(/^"|"$/g, '');
        var content = JSON.stringify(select.data('content')).replace(/^"|"$/g, '');

        procSetLayerPopup(title, content, null, null, 'x', null, null, null);
    };

    // DO TRY TO CONVERT HTML SYMBOL TO RAW CHARACTER OF COMMA AND QUOTA
    var convertToHTMLSymbol = function(externalObj) {
        var objKeys = Object.keys(externalObj);
        for (var i = 0; i < objKeys.length; i++) {
            // convert raw character of comma and quota to html symbol
            externalObj[objKeys[i]] =
                externalObj[objKeys[i]].replace(/,/g, '&comma;').replace(/"/g, '&quot;')
                    .replace(/{/g, '&lbrace;').replace(/}/g, '&rbrace;').replace(/:/g, '&colon;');
        }

        return externalObj;
    };

    // REPLACE FIRST LETTER ONLY TO UPPER-CASE ALPHABET LETTER FROM EXTERNAL STRING(OR OBJECT)
    var upperCaseFirstLetterOnly = function(obj) {
        return (obj + '').charAt(0).toUpperCase() + (obj + '').substring(1);
    };

    // CREATE SPANS FUNCTION FOR LABEL, ANNOTATION, ADDRESSES
    var createSpans = function(data, type) {
        // After run procCreateSpans, If some of span html are JSON Object or JSON Array value,
        // it adds layer-pop action and related event.
        var defaultSpanHtml = procCreateSpans(data, type);
        if ('-' === defaultSpanHtml) {
            return '-';
        }

        var spans = defaultSpanHtml.split('</span> ');

        var spanStr,
            spanData,
            separatorIndex,
            key,
            value,
            newSpanStr;

        for (var index = 0; index < spans.length; index++) {
            spanStr = spans[index];
            spanData = spanStr.replace('<span class="bg_gray">', '');
            separatorIndex = spanData.indexOf(':');
            if ('' === spanData || '' === spanData.replace(/ /g, '') || separatorIndex < 0) {
                spans[index] += spanStr + '</span> ';
                continue;
            }

            key = spanData.substring(0, separatorIndex);
            // try to convert html symbol to raw character of comma and quota
            value = spanData.substring(separatorIndex + 1);
            try {
                var type = typeof JSON.parse($('<p>' + value + '</p>').html());
                if ('object' === type) {
                    newSpanStr = '<span class="bg_blue" onclick="setLayerpop(this)" '
                        + 'data-title="' + key + '" data-content="' + spanData.substring(separatorIndex + 1) + '">'
                        + '<a>' + key + '</a></span> ';
                } else {
                    newSpanStr = spanStr + '</span> ';
                }
            } catch (e) {
                // ignore exception
                newSpanStr = spanStr + '</span> ';
            }

            spans[index] = newSpanStr;
        }

        return spans.join('');
    };

    // CALLBACK GET NODE DETAIL
    var callbackGetNodeDetail = function(data) {
        viewLoading('show');

        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
            return;
        }

        var metadata = data.metadata;
        var spec = data.spec;
        var status = data.status;

        var labels = procSetSelector(convertToHTMLSymbol(metadata.labels));
        var annotations = procSetSelector(convertToHTMLSymbol(metadata.annotations));
        var addressesObj = {};
        for (var i = 0; i < status.addresses.length; i++) {
            addressesObj[status.addresses[i]['type']] = status.addresses[i]['address'];
        }

        var addresses = procSetSelector(convertToHTMLSymbol(addressesObj));
        var unschedulable = false;
        if (null != spec.taints && spec.taints instanceof Array) {
            for (var i = 0; i < spec.taints.length; i++) {
                if (spec.taints[i].key === 'node-role.kubernetes.io/master' && spec.taints[i].effect !== 'NoSchedule') {
                    unschedulable = true;
                    break;
                }
            }
        }

        var nodeInfo = status.nodeInfo;

        $('#node_name').html(metadata.name);
        $('#node_labels').html(createSpans(labels, "NOT_LB"));
        $('#node_annotations').html(createSpans(annotations, "NOT_LB"));
        $('#node_created_at').html(metadata.creationTimestamp);
        $('#node_addresses').html(createSpans(addresses, "NOT_LB"));
        $('#node_pod_cidr').html(spec.podCIDR);
        $('#node_unschedulable').html(upperCaseFirstLetterOnly(unschedulable));

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
