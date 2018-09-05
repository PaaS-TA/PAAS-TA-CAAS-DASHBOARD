<%--
  PersistentVloume main
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <!-- Persistent Volumes 시작-->
    <div class="cluster_content04 row two_line two_view harf_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Persistent Volumes</p>
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
                                <col style='width:8%;'>
                                <col style='width:10%;'>
                                <col style='width:10%;'>
                                <col style='width:8%;'>
                                <col style='width:5%;'>
                                <col style='width:5%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultArea" style="display: none;"><td colspan='8'><p class='service_p'>실행 중인 Service가 없습니다.</p></td></tr>
                            <tr id="resultHeaderArea" style="display: none;">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Capacity</td>
                                <td>Access Modes</td>
                                <td>Reclaim policy</td>
                                <td>Status</td>
                                <td>Claim</td>
                                <td>Reason</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '7')"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            <tr>
                                <td colspan="8"></td>
                            </tr>
                            </tbody>
                            <!--tfoot>
                                <tr>
                                    <td colspan="6">
                                        <button class="btns2 btns2_1 colors4 event_btns">더보기</button>
                                    </td>
                                </tr>
                            </tfoot-->
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Persistent Volumes 끝 -->
</div>

<script type="text/javascript">

    var gList;

    var namespace = NAME_SPACE;

    // GET LIST
    var getList = function() {
        viewLoading('show');
        procCallAjax("<%= Constants.API_URL %>/persistentvolumes", "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            viewLoading('hide');
            return false;
        }

        gList = data;
        setList("");
    };


    // SET LIST
    var setList = function(searchKeyword) {

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');
        var resultTable = $('#resultTable');

        var items = gList.items;
        var listLength = items.length;
        var checkListCount = 0;
        var htmlString = [];

        // REF
        // service.namespace:port protocol
        // service.namespace:nodePort protocol -> service.namespace:0 protocol

        $.each(items, function (index, itemList) {

            var pvName = itemList.metadata.name;
            var capacity = JSON.stringify(itemList.spec.capacity);
            var accessModes = itemList.spec.accessModes;
            var reclaimPolicy = itemList.spec.persistentVolumeReclaimPolicy;
            var claim = "-";
            var status = itemList.status.phase;
            var reason = "-";
            var creationTimestamp = itemList.metadata.creationTimestamp;

            if ((nvl(searchKeyword) === "") || pvName.indexOf(searchKeyword) > -1) {


                htmlString.push(
                        "<tr>"
                        + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> "
                        + "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.CAAS_BASE_URL %>/clusters/persistentVolumes/" + pvName + "\");'>" + pvName + "</a>"
                        + "</td>"
                        + "<td>" + capacity + "</td>"
                        + "<td>" + accessModes + "</td>"
                        + "<td>" + reclaimPolicy + "</td>"
                        + "<td>" + status + "</td>"
                        + "<td>" + claim + "</td>"
                        + "<td>" + reason + "</td>"
                        + "<td>" + creationTimestamp + "</td>"
                        + "</tr>");

                checkListCount++;
            }
        });

        if (listLength < 1 || checkListCount < 1) {
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

        viewLoading('hide');

    };

    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>