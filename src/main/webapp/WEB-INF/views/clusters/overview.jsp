created-on<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="content">
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <!-- Overview 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Namespaces</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:20%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                                <tr id="noResultHeaderAreaForNameSpace" style="display: none;"><td colspan='3'><p class='service_p'>조회 된 NameSpace가 없습니다.</p></td></tr>
                                <tr id="resultHeaderAreaForNameSpace" style="display: none;">
                                    <td>Name</td>
                                    <td>Status</td>
                                    <td>Created on</td>
                                </tr>
                            </thead>
                            <tbody id="resultAreaForNameSpace">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_second_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Nodes</p>
                    </div>
                    <div class="view_table_wrap">
                        <table id="clusters_nodes_table" class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:5%;'>
                                <col style='width:10%;'>
                                <col style='width:10%;'>
                                <col style='width:12%;'>
                                <col style='width:12%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                                <tr id="noResultHeaderAreaForNodes" style="display: none;"><td colspan='3'><p class='service_p'>조회 된 Nodes가 없습니다.</p></td></tr>
                                <tr id="resultHeaderAreaForNodes" style="display: none;">
                                    <td>Name <button data-sort-key="node-name" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button></td>
                                    <td>Ready</td>
                                    <td>CPU requests</td>
                                    <td>CPU limits</td>
                                    <td>Memory requests</td>
                                    <td>Memory limits</td>
                                    <td>Created on <button data-sort-key="created-on" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>
                                </tr>
                            </thead>
                            <tbody id="resultAreaForNodes">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_third_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Persistent Volumes</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
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
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Capacity</td>
                                <td>Access Modes</td>
                                <td>Reclaim policy</td>
                                <td>Status</td>
                                <td>Claim</td>
                                <td>Reason</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_persistent_view.html">oracle-test-pv</a></td>
                                    <td>100Mi</td>
                                    <td>ReadWriteOnce</td>
                                    <td>Recycle</td>
                                    <td>Available</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>2015-07-04 20:15:30</td>
                                </tr>
                                <tr>
                                    <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_persistent_view.html">oracle-test-pv</a></td>
                                    <td>100Mi</td>
                                    <td>ReadOnlyMany</td>
                                    <td>Recycle</td>
                                    <td>Available</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>2015-07-04 20:15:30</td>
                                </tr>
                                <tr>
                                    <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_persistent_view.html">oracle-test-pv</a></td>
                                    <td>100Mi</td>
                                    <td>ReadWriteMany</td>
                                    <td>Recycle</td>
                                    <td>Available</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>2015-07-04 20:15:30</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Overview 끝 -->
</div>

<script type="text/javascript">

    var getNamespaces = function() {
        viewLoading('show');

        procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail.do", "GET", null, null, callbackGetNamespaces);
    };

    var callbackGetNamespaces = function(data) {
        var resultAreaForNameSpace = $("#resultAreaForNameSpace");
        var noResultHeaderAreaForNameSpace = $("#noResultHeaderAreaForNameSpace");
        var resultHeaderAreaForNameSpace = $("#resultHeaderAreaForNameSpace");

        // if (RESULT_STATUS_FAIL === data.resultCode) return false;
        if (data.resultCode == "500") {
            noResultHeaderAreaForNameSpace.show();
            viewLoading('hide');
            alertMessage('Get NameSpaces Fail~', false);

            return false;
        }

        var htmlString = [];

        htmlString.push(
            "<tr>"
            + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> <a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + data.metadata.name + "</a></td>"
            + "<td>" + data.status.phase + "</td>"
            + "<td>" + data.metadata.creationTimestamp + "</td>"
            + "</tr>");

        resultAreaForNameSpace.html(htmlString);
        noResultHeaderAreaForNameSpace.hide();
        resultHeaderAreaForNameSpace.show();

        viewLoading('hide');
    };

    var getNodes = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %>/nodes"
        procCallAjax(reqUrl, "GET", null, null, callbackGetListNodes);
    }

    var callbackGetListNodes = function(data) {
        var resultAreaForNodes = $("#resultAreaForNodes");
        var noResultHeaderAreaForNodes = $("#noResultHeaderAreaForNodes");
        var resultHeaderAreaForNodes = $("#resultHeaderAreaForNodes");

        if (data.resultCode == "500") {
            noResultHeaderAreaForNodes.show();
            viewLoading('hide');
            alertMessage('Get Nodes Fail~', false);

            return false;
        }

        var contents = [];
        $.each(data.items, function (index, nodeItem) {
            var _metadata = nodeItem.metadata;
            var _status = nodeItem.status;

            var name = _metadata.name;
            var ready = _status.conditions.filter(function(condition) {
                return condition.type === "Ready";
            })[0].status;
            var limitCPU = _status.capacity.cpu;
            var requestCPU = limitCPU - _status.allocatable.cpu;
            var limitMemory = convertByte(_status.capacity.memory);
            var requestMemory = limitMemory - convertByte(_status.allocatable.memory);
            var creationTimestamp = _metadata.creationTimestamp;

            // TODO
            var nameHtml = '<a href="./nodes/' + name + '/summary"> ' + name + '</a>';
            if (ready == "True")
                nameHtml = '<span class="green2"><i class="fas fa-check-circle"></i></span>' + nameHtml;
            else
                nameHtml = '<span class="red2"><i class="fas fa-exclamation-circle"></i></span>' + nameHtml;

            contents.push('<tr data-node-name="' + name + '" data-created-on="' + creationTimestamp + '">'
                + '<td>' + nameHtml + '</td>'
                + '<td>' + ready + '</td>'
                + '<td>' + requestCPU + '</td>'
                + '<td>' + limitCPU + '</td>'
                + '<td>' + formatCapacity(requestMemory, "Mi") + '</td>'
                + '<td>' + formatCapacity(limitMemory, "Mi") + '</td>'
                + '<td>' + creationTimestamp + '</td></tr>'
            );
        });

        resultAreaForNodes.html(contents);
        noResultHeaderAreaForNodes.hide();
        resultHeaderAreaForNodes.show();

        sortTable("clusters_nodes_table", "node-name");

        viewLoading('hide');
    }

    $(document.body).ready(function () {
        getNamespaces();

        $(".sort-arrow").on("click", function(event) {
            var tableId = "clusters_nodes_table";
            var sortKey = $(event.currentTarget).data('sort-key');
            var isAscending = $(event.currentTarget).hasClass('sort')? true : false;
            sortTable(tableId, sortKey, isAscending);
        });

        getNodes();
    });

</script>