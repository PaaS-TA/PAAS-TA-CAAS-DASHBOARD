<%--
  ReplicaSet main
  @author CISS
  @version 1.0
  @since 2018.08.09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <jsp:include page="../../common/contents-tab.jsp" flush="true"/>
    <div class="cluster_content01 row two_line two_view">
        <ul>
            <!-- Replica Sets 시작 -->
            <li class="cluster_fourth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Replica Sets</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">spring-cloud-web-user</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                </td>
                                <td>1 / 1
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:config-1.5<br/>
                                    bluedigm/hyerin:registration-1.5<br/>
                                    bluedigm/hyerin:gateway-1.0<br/>
                                    bluedigm/hyerin:infra-admin<br/>
                                    bluedigm/hyerin:common-api<br/>
                                    bluedigm/hyerin:portalapi<br/>
                                    cissc2/paas-ta-portal-webadmin:0.6<br/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_replica_view.html">portal-api-deployment</a>
                                </td>
                                <td>
                                    kube-system
                                </td>
                                <td><span class="bg_gray">app : nginx-2</span><br/>
                                    <span class="bg_gray">pod-template-hash : 26832</span>
                                </td>
                                <td>3 / 3
                                </td>
                                <td>2018-07-04 20:15:30
                                </td>
                                <td>bluedigm/hyerin:portalapi
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Replica Sets 끝 -->
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
        procCallAjax("<%= Constants.API_URL %>/namespaces/" + tempNamespace + "/replicasets", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        gList = data;
        setList();
    };


    // SET LIST
    var setList = function() {
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
    };


    // ON LOAD
    $(document.body).ready(function () {
        //getList();
    });

</script>
