<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>

<div class="content">
    <%--<%@include file="tab.jsp" %>--%>
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
                                <tr>
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
                        <table class="table_event condition alignL">
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
                            <tr>
                                <td>Name<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></td>
                                <td>Ready</td>
                                <td>CPU requests</td>
                                <td>CPU limits</td>
                                <td>Memory requests</td>
                                <td>Memory limits</td>
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_nodes_view.html">ip-172-31-20-237</a></td>
                                <td>True</td>
                                <td>831 mCPU</td>
                                <td>940 mCPU</td>
                                <td>931.95 MB</td>
                                <td>2.77 GB</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_nodes_view.html">ip-172-31-20-237</a></td>
                                <td>True</td>
                                <td>831 mCPU</td>
                                <td>940 mCPU</td>
                                <td>931.95 MB</td>
                                <td>2.77 GB</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="caas_nodes_view.html">ip-172-31-20-237</a></td>
                                <td>True</td>
                                <td>831 mCPU</td>
                                <td>940 mCPU</td>
                                <td>931.95 MB</td>
                                <td>2.77 GB</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
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
        procCallAjax("/caas/clusters/namespaces/"+NAME_SPACE+"/getDetail.do", "GET", null, null, callbackGetNamespaces);
    };

    var callbackGetNamespaces = function(data) {
        if (RESULT_STATUS_FAIL === data.resultCode) return false;

        var htmlString = [];

        htmlString.push(
            "<tr>"
            + "<td><span class='green2'><i class='fas fa-check-circle'></i></span> <a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/namespaces/" + NAME_SPACE + "\");'>" + data.metadata.name + "</a></td>"
            + "<td>" + data.status.phase + "</td>"
            + "<td>" + data.metadata.creationTimestamp + "</td>"
            + "</tr>");

        var resultArea = $("#resultAreaForNameSpace");
        resultArea.html(htmlString);
    };

    $(document.body).ready(function () {
        getNamespaces();
    });

</script>