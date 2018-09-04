<%--
  Created by IntelliJ IDEA.
  User: PHR
  Date: 2018-09-04
  Time: 오전 11:21
  To change this template use File | Settings | File Templates.
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
                            <tr id="noResultArea" style="display: none;"><td colspan='6'><p class='service_p'>실행 중인 Pods가 없습니다.</p></td></tr>
                            <tr id="resultHeaderArea">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '5')"><i class="fas fa-caret-down"></i></button></td>
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

    // GET LIST
    var getList = function() {
        procCallAjax("<%= Constants.API_URL %>/workloads/namespaces/" + NAME_SPACE + "/pods", "GET", null, null, callbackGetList);
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
        var listLength = items.length;
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            var podsName = items[i].metadata.name;
            var containerStatuses;
            if(items[i].status.containerStatuses == null) {
                containerStatuses = "None";
            } else {
                containerStatuses = items[i].status.containerStatuses[0].restartCount;
            }

           htmlString.push(
                "<tr>"
                + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %><%= Constants.API_WORKLOAD %>/pods/" + podsName + "\");'>" + podsName + "</a>"
                + "</td>"
                + "<td>" + items[i].metadata.namespace + "</td>"
                + "<td>" + nvl2(items[i].spec.nodeName, "None") + "</td>"
                + "<td>" + items[i].status.phase + "</td>"
                + "<td>" + containerStatuses + "</td>"
                + "<td>" + items[i].metadata.creationTimestamp + "</td>"
                + "</tr>");

        }

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            console.log("아주 심기를 준비하자 ");
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
            resultTable.tablesorter();
            resultTable.trigger("update");
        }

    };

    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
