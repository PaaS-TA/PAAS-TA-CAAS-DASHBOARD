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
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" onkeypress="if(event.keyCode===13) {setList(this.value);}" />
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:10%;'>
                                <col style='width:20%;'>
                                <col style='width:5%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultArea" style="display: none;"><td colspan='6'><p class='service_p'>실행 중인 Service가 없습니다.</p></td></tr>
                            <tr id="resultHeaderArea">
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Service Type</td>
                                <td>Cluster IP</td>
                                <td>Endpoints</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
<%--TODO--%>
<!-- modal -->


<script type="text/javascript">

    var gList;

    // TODO :: REMOVE
    var tempNamespace = "<%= Constants.NAMESPACE_NAME %>";

    // GET LIST
    var getList = function() {
        procCallAjax("<%= Constants.API_URL %>/namespaces/" + tempNamespace + "/services", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        gList = data;
        setList("");
    };


    // SET LIST
    var setList = function(searchKeyword) {
        var serviceName,
            selector,
            endpointsPreString,
            nodePort,
            specPortsList,
            specPortsListLength;

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');

        var items = gList.items;
        var listLength = items.length;
        var endpoints = "";
        var checkListCount = 0;
        var selectorList = [];
        var htmlString = [];

        // REF
        // service.namespace:port protocol
        // service.namespace:nodePort protocol -> service.namespace:0 protocol

        for (var i = 0; i < listLength; i++) {
            serviceName = items[i].metadata.name;

            if ((nvl(searchKeyword) === "") || serviceName.indexOf(searchKeyword) > -1) {
                selector = procSetSelector(items[i].spec.selector);
                endpointsPreString = serviceName + "." + items[i].metadata.namespace + ":";
                nodePort = items[i].spec.ports.nodePort;

                if (nodePort === undefined) {
                    nodePort = "0";
                }

                specPortsList = items[i].spec.ports;
                specPortsListLength = specPortsList.length;

                for (var j = 0; j < specPortsListLength; j++) {
                    endpoints += '<p>' + endpointsPreString + specPortsList[j].port + " " + specPortsList[j].protocol + '</p>'
                            + '<p>' + endpointsPreString + nodePort + " " + specPortsList[j].protocol + '</p>';
                }

                htmlString.push(
                    "<tr>"
                        + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                        + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/services/" + serviceName + "\");'>" + serviceName + "</a>"
                        + "</td>"
                        + "<td>" + items[i].spec.type + "</td>"
                        + "<td>" + items[i].spec.clusterIP + "</td>"
                        + "<td>" + endpoints + "</td>"
                        + "<td>" + "<span id='" + serviceName + "'></span></td>"
                        + "<td>" + items[i].metadata.creationTimestamp + "</td>"
                        + "</tr>");

                selectorList.push(selector + "," + serviceName);
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
            resultArea.show();
            resultArea.html(htmlString);
        }

        getDetailForPods(selectorList);
    };


    // GET DETAIL FOR PODS
    var getDetailForPods = function(selectorList) {
        var listLength = selectorList.length;
        var tempSelectorList;
        var reqUrl;

        for (var i = 0; i < listLength; i++) {
            tempSelectorList = selectorList[i].split(",");
            reqUrl = "<%= Constants.API_URL %>/workloads/namespaces/" + tempNamespace + "/pods/service/" + tempSelectorList[1] + "/" + tempSelectorList[0];

            procCallAjax(reqUrl, "GET", null, null, callbackGetDetailForPods);
        }
    };


    // CALLBACK
    var callbackGetDetailForPods = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var items = data.items;
        var listLength = items.length;
        var runningSum = 0;
        var totalSum = 0;

        for (var i = 0; i < listLength; i++) {
            if (items[i].status.phase.toLowerCase() === "running") {
                runningSum++
            }
            totalSum++;
        }

        $('#' + data.serviceName).html(runningSum + "/" + totalSum);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
