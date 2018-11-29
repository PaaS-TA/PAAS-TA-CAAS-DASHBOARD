<%--
  Services main
  @author REX
  @version 1.0
  @since 2018.08.09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
        <ul>
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Services</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" onkeypress="if(event.keyCode===13) {setList(this.value);}" maxlength="100" />
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh" id="resultTable">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:10%;'>
                                <col style='width:20%;'>
                                <col style='width:5%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultArea"><td colspan='6'><p class='service_p'>실행 중인 Service가 없습니다.</p></td></tr>
                            <tr id="resultHeaderArea" class="headerSortFalse" style="display: none;">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Service Type</td>
                                <td>Cluster IP</td>
                                <td>Endpoints</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '5')"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            <tr>
                                <td colspan="6"> - </td>
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

    var G_SERVICE_LIST;

    // GET LIST
    var getList = function () {
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_SERVICES_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE);

        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function (data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            return false;
        }

        G_SERVICE_LIST = data;
        procViewLoading('hide');

        setList("");
    };


    // SET LIST
    var setList = function (searchKeyword) {
        procViewLoading('show');

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');
        var resultTable = $('#resultTable');

        var itemsMetadata,
            itemsSpec,
            serviceName,
            selector,
            namespace,
            endpointsPreString,
            nodePort,
            specPortsList,
            specPortsListLength,
            endpointWithSpecPort,
            endpointWithNodePort,
            endpointProtocol;

        var items = G_SERVICE_LIST.items;
        var listLength = items.length;
        var endpoints = "";
        var checkListCount = 0;
        var selectorList = [];
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            itemsMetadata = items[i].metadata;
            itemsSpec = items[i].spec;
            serviceName = itemsMetadata.name;

            if ((nvl(searchKeyword) === "") || serviceName.indexOf(searchKeyword) > -1) {
                selector = procSetSelector(itemsSpec.selector);
                namespace = itemsMetadata.namespace;
                endpointsPreString = (namespace === 'default') ? serviceName : serviceName + "." + namespace;
                endpointsPreString += ":";
                specPortsList = itemsSpec.ports;

                if (nvl(specPortsList) !== '') {
                    specPortsListLength = specPortsList.length;

                    for (var j = 0; j < specPortsListLength; j++) {
                        nodePort = nvl(specPortsList[j].nodePort, '0');
                        endpointProtocol = specPortsList[j].protocol;
                        endpointWithSpecPort = endpointsPreString + specPortsList[j].port + " " + endpointProtocol;
                        endpointWithNodePort = endpointsPreString + nodePort + " " + endpointProtocol;

                        endpoints += '<p>' + endpointWithSpecPort + '</p>' + '<p>' + endpointWithNodePort + '</p>';
                    }
                }

                htmlString.push(
                    "<tr>"
                    + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                    + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/services/"
                    + serviceName + "\");'>" + serviceName + "</a>"
                    + "</td>"
                    + "<td><p>" + nvl(itemsSpec.type, '-') + "</p></td>"
                    + "<td><p>" + nvl(itemsSpec.clusterIP, '-') + "</p></td>"
                    + "<td>" + nvl(endpoints, '-') + "</td>"
                    + "<td><p id='" + serviceName + "' class='tableTdToolTipFalse'>0 / 0</p></td>"
                    + "<td>" + itemsMetadata.creationTimestamp + "</td>"
                    + "</tr>");

                if (selector !== 'false') {
                    selectorList.push(selector + "||" + serviceName);
                }

                endpoints = "";
                checkListCount++;
            }
        }

        if (listLength < 1 || checkListCount < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.html(htmlString);
            resultArea.show();

            resultTable.tablesorter({
                sortList: [[5, 1]] // 0 = ASC, 1 = DESC
            });

            resultTable.trigger("update");
            $('.headerSortFalse > td').unbind();
        }

        procSetToolTipForTableTd('resultArea');
        procViewLoading('hide');
        getDetailForPods(selectorList);
    };


    // GET DETAIL FOR PODS
    var getDetailForPods = function (selectorList) {
        var listLength = selectorList.length;
        var tempSelectorList,
            reqUrl;

        for (var i = 0; i < listLength; i++) {
            procViewLoading('show');
            tempSelectorList = selectorList[i].split("||");
            reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST_BY_SELECTOR_WITH_SERVICE %>"
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{serviceName:.+}", tempSelectorList[tempSelectorList.length - 1])
                .replace("{selector:.+}", tempSelectorList[0]);

            procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPods);
        }
    };


    // CALLBACK
    var callbackGetDetailForPods = function (data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            return false;
        }

        var items = data.items;
        var listLength = items.length;
        var runningSum = 0;
        var totalSum = 0;

        for (var i = 0; i < listLength; i++) {
            if (items[i].status.phase.toLowerCase() === "running") {
                runningSum++;
            }
            totalSum++;
        }

        $('#' + data.serviceName).html(runningSum + " / " + totalSum);

        procSetToolTipForTableTd('resultArea');
        procViewLoading('hide');
    };


    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
