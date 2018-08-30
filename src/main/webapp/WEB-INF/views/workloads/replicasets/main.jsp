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
                        <table class="table_event condition alignL" id="resultTable">
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
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '4')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
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

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');
        var resultTable = $('#resultTable');

        var items = gList.items;

        //var selector = procSetSelector(items[i].spec.selector);

        $.each(gList.items, function (index, itemList) {

            var replicasetName = itemList.metadata.name;
            var namespace = itemList.metadata.namespace;
            var labels = procSetSelector(itemList.metadata.labels);
            var creationTimestamp = itemList.metadata.creationTimestamp;
            var replicas = itemList.status.replicas;   //  TOBE ::  current / desired
            var images = new Array;

            var containers = itemList.spec.template.spec.containers;
            for(var i=0; i < containers.length; i++){
                images.push(containers[i].image);
            }

            resultArea.append(
                    "<tr>"
                    + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                    + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/workloads/replicasets/" + replicasetName + "\");'>" + replicasetName + "</a>"
                    + "</td>"
                    + "<td>" + namespace + "</td>"
                    + "<td>" + labels + "</td>"
                    + "<td>" + replicas/replicas + "</td>"
                    + "<td>" + creationTimestamp+"</td>"
                    + "<td>" + images.join("</br>") + "</td>"
                    + "</tr>");

        });

        resultTable.tablesorter();
        resultTable.trigger("update");

    };


    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
