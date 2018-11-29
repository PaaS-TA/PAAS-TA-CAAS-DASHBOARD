<%--
  Services detail
  @author REX
  @version 1.0
  @since 2018.08.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="detail_icon"><i class="fas fa-file-alt"></i></span> <c:out value="${serviceName}"/></h1>
    <jsp:include page="../common/contentsTab.jsp"/>
    <!-- Services Details 시작 -->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT10">
            <li class="cluster_second_box">
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
                                <td><span class="resultServiceName"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td><span id="resultNamespace"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td><span id="resultCreationTimestamp"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Label Selector</th>
                                <td><span class="bg_gray" id="resultLabelSelector"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Type</th>
                                <td><span id="resultType"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Session Affinity</th>
                                <td><span id="resultSessionAffinity"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Cluster IP</th>
                                <td><span id="resultClusterIp"> - </span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Internal endpoints</th>
                                <td id="resultInternalEndpointsArea"> - </td>
                            </tr>
                            <tr id="nodePortUrlLinkWrap" style="display: none;">
                                <th><i class="cWrapDot"></i> URL</th>
                                <td>
                                    <button id="nodePortUrlLinkButton" class="btns4 colors4" data-toggle='tooltip' title="-">URL Link</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_third_box">
                <jsp:include page="../pods/list.jsp"/>
            </li>
            <li class="cluster_fourth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Endpoints</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr id="noResultAreaForEndpoints"><td colspan='4'><p class='service_p'>조회 된 Endpoint가 없습니다.</p></td></tr>
                            <tr id="resultHeaderAreaForEndpoints" style="display: none;">
                                <td>Host</td>
                                <td>Ports (Name, Port, Protocol)</td>
                                <td>Node</td>
                                <td>Ready</td>
                            </tr>
                            </thead>
                            <tbody id="resultAreaForEndpoints" style="display: none;">
                            <tr>
                                <td colspan="4"> - </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Services Details 끝 -->
</div>
<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />
<input type="hidden" id="hiddenMasterUrl" name="hiddenMasterUrl" value="" />
<input type="hidden" id="hiddenNodePortUrl" name="hiddenNodePortUrl" value="" />

<script type="text/javascript">

    // GET DETAIL
    var getUserDetail = function () {
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_COMMON_API_USERS_DETAIL %>"
            .replace("{serviceInstanceId:.+}", SERVICE_INSTANCE_ID)
            .replace("{organizationGuid:.+}", ORGANIZATION_GUID)
            .replace("{userId:.+}", USER_ID);

        procCallAjax(reqUrl, "GET", null, null, callbackGetUserDetail);
    };

    // CALLBACK
    var callbackGetUserDetail = function (data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        $('#hiddenMasterUrl').val(data.caasUrl);
        getDetail();
    };

    // GET DETAIL
    var getDetail = function() {
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_SERVICES_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{serviceName:.+}", document.getElementById('requestServiceName').value);

        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            procAlertMessage();
            return false;
        }

        var selector,
            endpointsPreString,
            selectorString,
            nodePort,
            specPortsListLength;

        var dataMetadata = data.metadata;
        var serviceName = dataMetadata.name;
        var namespace = dataMetadata.namespace;
        var dataSpec = data.spec;
        var namespaceHtml = "<a href='javascript:void(0); 'data-toggle='tooltip' title='"
            + namespace + "' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NAMESPACES %>/"
            + namespace + "\");'>" + namespace + "</a>";
        var endpoints = "";
        var labelSelectorObject = $('#resultLabelSelector');
        var specPortsList = dataSpec.ports;
        var specType = nvl(dataSpec.type, '-');

        // SET ENDPOINTS
        if (nvl(specPortsList) !== '') {
            specPortsListLength = specPortsList.length;

            for (var i = 0; i < specPortsListLength; i++) {
                nodePort = nvl(specPortsList[i].nodePort, '0');
                endpointsPreString = (namespace === 'default') ? serviceName : serviceName + "." + namespace;
                endpointsPreString += ":";

                endpoints += '<p>' + endpointsPreString + specPortsList[i].port + " " + specPortsList[i].protocol + '</p>'
                    + '<p>' + endpointsPreString + nodePort + " " + specPortsList[i].protocol + '</p>';
            }
        }

        // SET SELECTOR
        selector = procSetSelector(dataSpec.selector);
        selectorString = selector;

        if (selector === false) {
            selectorString = '-';
            labelSelectorObject.removeClass('bg_gray');
        } else {
            selectorString = selector.replace(/=/g, ':')
        }

        // SET VIEW FOR TOP DETAIL AREA
        $('.resultServiceName').html(serviceName);
        $('#resultNamespace').html(namespaceHtml);
        $('#resultCreationTimestamp').html(dataMetadata.creationTimestamp);
        labelSelectorObject.html(selectorString);
        $('#resultType').html(specType);
        $('#resultSessionAffinity').html(nvl(dataSpec.sessionAffinity, '-'));
        $('#resultClusterIp').html(nvl(dataSpec.clusterIP, '-'));
        $('#resultInternalEndpointsArea').html(nvl(endpoints, '-'));

        var checkHttpString = 'http://';

        // SET URL LINK
        if (specType === 'NodePort') {
            var masterUrl = nvl($('#hiddenMasterUrl').val(), '-').replace('https://', '').replace(checkHttpString, '');

            if (masterUrl !== '') {
                var masterUrlArray = masterUrl.split(':');
                var nodePortUrl = checkHttpString + masterUrlArray[0] + ':' + nodePort;

                $('#hiddenNodePortUrl').val(nodePortUrl);
                $('#nodePortUrlLinkButton').attr('title', nodePortUrl);
                $('#nodePortUrlLinkWrap').show();
            }
        }

        procViewLoading('hide');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{serviceName:.+}", "_all")
            .replace("{selector:.+}", selector);

        getPodListUsingRequestURL(reqUrl);
        getDetailForEndpoints();
    };


    // GET DETAIL FOR ENDPOINTS
    var getDetailForEndpoints = function() {
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_ENDPOINTS_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{serviceName:.+}", document.getElementById('requestServiceName').value);

        procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForEndpoints);
    };


    // CALLBACK
    var callbackGetDetailForEndpoints = function(data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            return false;
        }

        var resultArea = $('#resultAreaForEndpoints');
        var resultHeaderArea = $('#resultHeaderAreaForEndpoints');
        var noResultArea = $('#noResultAreaForEndpoints');

        var endpointsList,
            ports,
            endpointsListLength,
            portsListLength,
            nodeName;

        var dataSubsets = data.subsets;
        var subsetsListLength = 0;
        var portsString = '';
        var separatorString = ", ";
        var checkCount = 0;
        var nodeNameHtml = '-';
        var nodeNameList = [];
        var htmlString = [];

        if (dataSubsets === null) {
            checkCount++;
        } else {
            subsetsListLength = dataSubsets.length;
        }

        // SET ENDPOINTS LIST
        for (var i = 0; i < subsetsListLength; i++) {
            endpointsList = dataSubsets[i].addresses;
            ports = dataSubsets[i].ports;

            if (endpointsList === null) {
                endpointsList = dataSubsets[i].notReadyAddresses;
            }

            if (ports === null) {
                checkCount++;
            } else {
                endpointsListLength = endpointsList.length;
                portsListLength = ports.length;

                for (var j = 0; j < endpointsListLength; j++) {
                    nodeName = nvl(endpointsList[j].nodeName, '-');

                    for (var k = 0; k < portsListLength; k++) {
                        var portName =  ports[k].name;
                        var portNameString =  "[-]";

                        if (portName !== null) {
                            portNameString = portName;
                        }

                        portsString += '<p>' + portNameString + separatorString + ports[k].port + separatorString + ports[k].protocol + '</p>';
                    }

                    if (nodeName !== '-') {
                        nodeNameHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NODES %>/"
                            + nodeName + "/summary\");'>" + nodeName + "</a>";
                        nodeNameList.push(nodeName);
                    }

                    htmlString.push(
                        "<tr>"
                        + "<td><p>" + endpointsList[j].ip + "</p></td>"
                        + "<td>" + portsString + "</td>"
                        + "<td>" + nodeNameHtml + "</td>"
                        + "<td><p class='tableTdToolTipFalse " + nodeName + "'>true</p></td>"
                        + "</tr>");

                    portsString = '';
                }
            }
        }

        if (subsetsListLength < 1 || checkCount > 0) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
            getDetailForNodes(nodeNameList);
        }

        procSetToolTipForTableTd('resultAreaForEndpoints');
        procViewLoading('hide');
    };


    // GET DETAIL FOR NODES
    var getDetailForNodes = function(nodeNameList) {
        var listLength = nodeNameList.length;
        var reqUrl;

        for (var i = 0; i < listLength; i++) {
            if (nodeNameList[i] !== '-') {
                procViewLoading('show');

                reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_NODES_LIST %>"
                    .replace('{nodeName:.+}', nodeNameList[i]);

                procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForNodes);
            }
        }
    };


    // CALLBACK
    var callbackGetDetailForNodes = function(data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            return false;
        }

        var items = data.status.conditions;
        var conditionsListLength = items.length;

        for (var i = 0; i < conditionsListLength; i++) {
            if (items[i].type === "Ready") {
                $('.' + data.metadata.name).text(items[i].status);
            }
        }

        procSetToolTipForTableTd('resultAreaForEndpoints');
        procViewLoading('hide');
    };


    // BIND
    $("#nodePortUrlLinkButton").on("click", function () {
        window.open($('#hiddenNodePortUrl').val(), '_blank');
    });


    // ON LOAD
    $(document.body).ready(function () {
        getUserDetail();
    });

</script>
