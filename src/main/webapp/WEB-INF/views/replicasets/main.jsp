<%--
  ReplicaSet main
  @author CISS
  @version 1.0
  @since 2018.08.09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>
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
                            <tr id="resultHeaderArea" class="headerSortFalse" style="display: none;">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td>Pods</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '4')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Images</td>
                            </tr>
                            <tr id="noResultArea" style="display: none;"><td colspan='6'><p class='service_p'>실행 중인 ReplicaSet이 없습니다.</p></td></tr>
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

<script type="text/javascript">

    var G_REPLICASET_LIST; // replicaset list
    var G_POD_EVENT_LIST;  // replicaset's POD Event list

    // GET LIST
    var getList = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_REPLICASETS_LIST %>"
                .replace("{namespace:.+}", NAME_SPACE);
        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            return false;
        }

        G_REPLICASET_LIST = data;
        viewLoading('hide');

        setList();
    };

    // SET LIST
    var setList = function() {
        viewLoading('show');

        var resultArea       = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea     = $('#noResultArea');
        var resultTable      = $('#resultTable');

        var items = G_REPLICASET_LIST.items;
        var listLength = items.length;

        $.each(items, function (index, itemList) {

            var replicaSetName = itemList.metadata.name;
            var namespace = itemList.metadata.namespace;
            var labels = procSetSelector(itemList.metadata.labels);
            var creationTimestamp = itemList.metadata.creationTimestamp;
            var pods = itemList.status.availableReplicas +" / "+ itemList.spec.replicas;  // current / desired
            //var selector = procSetSelector(items[i].spec.selector);
            var images = new Array;

            var containers = itemList.spec.template.spec.containers;
            for(var i=0; i < containers.length; i++){
                images.push(containers[i].image);
            }

            //이벤트 관련 추가 START
            addPodsEvent(itemList, itemList.spec.selector.matchLabels); // 이벤트 추가 TODO :: pod 조회시에도 사용할수 있게 수정

            var statusIconHtml;
            var statusMessageHtml = [];

            if(itemList.type == 'Warning'){ // [Warning]과 [Warning] 외 두 가지 상태로 분류
                statusIconHtml    = "<span class='red2'><i class='fas fa-exclamation-circle'></i> </span>";
                $.each(itemList.message , function (index, eventMessage) {
                    statusMessageHtml += "<p class='red2 custom-content-overflow' data-toggle='tooltip' title='" + eventMessage + "'>" + eventMessage + "</p>";
                });

            }else{
                statusIconHtml    = "<span class='green2'><i class='fas fa-check-circle'></i> </span>";
            }
            //이벤트 관련 추가 END

            resultArea.append(
                    "<tr>"
                    + "<td>"+statusIconHtml
                    + "<a href='javascript:void(0);' data-toggle='tooltip' title='"+replicaSetName+"' onclick='procMovePage(\"<%= Constants.URI_CONTROLLER_REPLICASETS %>/" + replicaSetName + "\");'>" + replicaSetName + "</a>"
                    + statusMessageHtml
                    + "</td>"
                    + "<td><a href='javascript:void(0);' data-toggle='tooltip' title='"+namespace+"' onclick='procMovePage(\"<%= Constants.URI_CONTROLLER_NAMESPACE %>/" + namespace + "\");'>" + namespace + "</td>"
                    + "<td>" + createSpans(labels, "LB") + "</td>"
                    + "<td>" + pods + "</td>"
                    + "<td>" + creationTimestamp+"</td>"
                    + "<td>" + images.join("</br>") + "</td>"
                    + "</tr>");
        });

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultTable.tablesorter();
            resultTable.trigger("update");
            $('.headerSortFalse > td').unbind();
        }

        viewLoading('hide');

    };

    // TODO :: 업데이트(복수값일시 레이어 링크 제공) 및 공통화 필요
    var createSpans = function (data, type) {
        var datas = data.replace(/=/g, ':').split(',');
        var spanTemplate = "";

        if (type === "LB") { // Line Break
            $.each(datas, function (index, data) {
                if (index != 0) {
                    spanTemplate += '<br>';
                }
                spanTemplate += '<span class="bg_gray">' + data + '</span>';
            });
        } else {
            $.each(datas, function (index, data) {
                spanTemplate += '<span class="bg_gray">' + data + '</span> ';
            });
        }

        return spanTemplate;
    }

    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
