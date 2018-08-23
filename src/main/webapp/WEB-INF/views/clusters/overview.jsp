<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%--TODO :: REMOVE--%>
<%--
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>main</title>

    <script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>

    <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet">

    <script type="text/javascript" src="<c:url value='/resources/js/jquery.jsonPresenter.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.jsonPresenter.css' />" rel="stylesheet">

</head>
<body class="hold-transition login-page">
--%>

<div class="content">
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on" onclick="procMovePage('/clusters/overview');">Overview</li>
            <li name="tab02" class="cluster_tabs_right">Namespaces</li>
            <li name="tab03" class="cluster_tabs_right">Nodes</li>
            <li name="tab04" class="cluster_tabs_right">Persistent Volumes</li>

            <%--TODO :: REMOVE--%>
            <li name="tab05" class="cluster_tabs_right" onclick="procMovePage('/clusters/namespaces');">Namespaces VIEW</li>
            <li name="tab06" class="cluster_tabs_right" onclick="procMovePage('/clusters/nodes');">Nodes VIEW</li>
            <li name="tab07" class="cluster_tabs_right" onclick="procMovePage('/clusters/persistentVolumes');">Persistent Volumes VIEW</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Overview 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
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
            <li class="cluster_second_box maB50">
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
    <!-- Overview 끝 -->
    <!-- Namespaces 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Namespaces</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style='width:20%'>
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td>default</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td><span class="bg_gray">app : nginx-2</span> <span class="bg_gray">tier.node</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td>Active</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_second_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Events</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                                <col style=".">
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Message</td>
                                <td>Source</td>
                                <td>Sub-object</td>
                                <td>Count</td>
                                <td>First seen</td>
                                <td>Last seen</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                     Back-off pulling Images "aa"
                                </td>
                                <td>
                                    kubelet ip-172-31-27-131
                                </td>
                                <td>spec.containers{aa}
                                </td>
                                <td>41192
                                </td>
                                <td>2018-07-08 18:31:01
                                </td>
                                <td>2018-07-09 18:31:01
                                </td>
                            </tr>
                            <td>
                                <span class="red2"><i class="fas fa-exclamation-circle"></i> Error: ImagesPullBackOff</span>
                            </td>
                            <td>
                                kubelet ip-172-31-27-131
                            </td>
                            <td>spec.containers{aa}
                            </td>
                            <td>41278
                            </td>
                            <td>2018-07-08 18:31:01
                            </td>
                            <td>2018-07-09 18:31:01
                            </td>
                            </tr>
                            <tr>
                                <td>
                                     Back-off pulling Images "aa"
                                </td>
                                <td>
                                    kubelet ip-172-31-27-131
                                </td>
                                <td>spec.containers{aa}
                                </td>
                                <td>129005
                                </td>
                                <td>2018-07-08 18:31:01
                                </td>
                                <td>2018-07-09 18:31:01
                                </td>
                            </tr>
                            <td>
                                <span class="red2"><i class="fas fa-exclamation-circle"></i> Error: ImagesPullBackOff</span>
                            </td>
                            <td>
                                kubelet ip-172-31-27-131
                            </td>
                            <td>spec.containers{aa}
                            </td>
                            <td>129005
                            </td>
                            <td>2018-07-08 18:31:01
                            </td>
                            <td>2018-07-09 18:31:01
                            </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Namespaces 끝 -->
    <!-- Nodes 시작-->
    <div class="cluster_content03 row two_line two_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Nodes</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" />
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
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
    <!-- Nodes 끝 -->
    <!-- Persistent Volumes 시작-->
    <div class="cluster_content04 row two_line two_view harf_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Persistent Volumes</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" />
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
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


<%--TODO :: REMOVE--%>
<div>
    <br>
        <div class="mt50 ml50">
            <img src="<c:url value='/resources_OLD/images/flower.png' />">
        </div>
    </span>
</div>
<div style="margin-left: 15px;">
    <span style="margin-top: 50px;"> ROLE-SET (RESOURCE / VERB) 별 화면 노출 테스트 화면입니다.</span></br></br></br>

    <c:choose>
        <c:when test="${!empty sessionScope.REPLICASET_VIEW}">
           <span> LIST(VIEW) 영역 입니다.</span></br>
            <c:choose>
                <c:when test="${!empty sessionScope.REPLICASET_EXECUTE}">
                    <span> 실행(EXCUTE) 영역 입니다.</span></br>
                </c:when>
                <c:when test="${!empty sessionScope.REPLICASET_DELETE}">
                    <span> 삭제(DELETE)버튼 영역 입니다.</span></br>
                </c:when>
                <c:otherwise></c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <span> REPLICASET-VIEW 항목을 세션에서 찾지 못함.</span></br>
        </c:otherwise>
    </c:choose>

    <!-- if 문법 참고용입니다.
         실제로 아래 경우에는 c:choose c:when c:otherwise 사용 권장 -->
    <c:if test="${empty sessionScope}">
        <button><a href="/accept/ruleset">Admin Session(for RuleSet) Create.</a></button></br>
    </c:if>

    <c:if test="${!empty sessionScope}">
        <button><a href="/session/invalidate">Admin Session Remove.</a></button>
    </c:if>

</div>

<script type="text/javascript">

    // JavaScript 내에서 session 참조시
    //var sApprover   = '<c:out value="${sessionScope.approver}"/>'; // session에 없는값 테스트
    var sView       = '<c:out value="${sessionScope.REPLICASET_VIEW}"/>';
    var sExecute     = '<c:out value="${sessionScope.REPLICASET_EXECUTE}"/>';
    var sDelete     = '<c:out value="${sessionScope.REPLICASET_DELETE}"/>';

    console.log("Session View:::"+sView);
    console.log("Session Execute:::"+sExecute);
    console.log("Session Delete:::"+sDelete);

    $(document).ready(function(){
//        $("#namespaces").on("click", function (e) {
//            getNamespaces();
//        });
//
//        $("#pods").on("click", function (e) {
//            getPods();
//        });

    });
</script>

<%--TODO :: REMOVE--%>
<%--</body>
</html>--%>


