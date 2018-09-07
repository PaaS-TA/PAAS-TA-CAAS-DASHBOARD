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
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <div class="cluster_content02 row two_line two_view harf_view" style="display: block;">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
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
        viewLoading('show');

        if (false == procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Node의 Pod 목록을 가져오지 못했습니다.", false);
            $('#noResultArea > td > p').html("Node의 Pod 목록을 가져오지 못했습니다.");
            $('#noResultArea').show();
            $('#resultArea').hide();
            $('#resultHeaderArea').hide();
            return;
        }

        gList = data;
        setList();

        viewLoading('hide');
    };

    // SET LIST
    var setList = function() {

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');
        var resultTable = $('#resultTable');

        // constant value
        var errorMsgPhase = ["Pending", "Failed", "Unknown"];

        var items = gList.items;
        var listLength = items.length;
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            var podsName = items[i].metadata.name;
            var nodeName = nvl2(items[i].spec.nodeName, "-");

            var podErrorMsg = null;
            if (errorMsgPhase.indexOf(items[i].status.phase) > -1) {
                var findConditions = items[i].status.conditions.filter(function (item) { return item.reason != null && item.message != null});
                if (findConditions.length > 0)
                    podErrorMsg = findConditions[0].reason + " (" + findConditions[0].message + ")";
            }

            var nameClassSet;
            switch (items[i].status.phase) {
                case "Running":
                    nameClassSet = {span: "running2", i: "fas fa-check-circle"}; break;
                case "Succeeded":
                    nameClassSet = {span: "succeeded2", i: "fas fa-check-circle"}; break;
                case "Pending":
                    nameClassSet = {span: "pending2", i: "fas fa-exclamation-triangle"}; break;
                case "Failed":
                    nameClassSet = {span: "failed2", i: "fas fa-exclamation-circle"}; break;
                case "Unknown":
                    nameClassSet = {span: "unknown2", i: "fas fa-exclamation-triangle"}; break;
                default:
                    break;
            }

            var containerStatuses;
            if(items[i].status.containerStatuses == null) {
                containerStatuses = "-";
            } else {
                containerStatuses = items[i].status.containerStatuses[0].restartCount;
            }

            var podNameHtml = "<span class='" + nameClassSet.span + "'><i class='" + nameClassSet.i + "'></i></span> "
                + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_WORKLOAD_PODS %>/" + podsName + "\");'>" + podsName + "</a>";
            if (podErrorMsg != null && podErrorMsg != "")
                podNameHtml += '<br><span class="' + nameClassSet.span + '">' + podErrorMsg + '</span>';

            var nodeNameHtml;
            if (nodeName !== "-")
                nodeNameHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NODES %>/" + nodeName + "/summary\");'>" + nodeName + "</a>";
            else
                nodeNameHtml = "-";

            htmlString.push(
                "<tr>"
                + "<td>" + podNameHtml + "</td>"
                + "<td>" + items[i].metadata.namespace + "</td>"
                + "<td>" + nodeNameHtml + "</td>"
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
        viewLoading('show');
        getList();
        viewLoading('hide');
    });

</script>
