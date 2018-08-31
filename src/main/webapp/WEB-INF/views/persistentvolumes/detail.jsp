<%--
  PersistentVloume main
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> oracle-test-pv (Volumes_sample)</h1>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
    <!-- Details 시작 -->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Details</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style="*">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td>kube-flannel-ds</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td><span class="bg_gray">type : oracle-test</span></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td>Available</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Claim</th>
                                <td>-</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Reclaim policy</th>
                                <td>Recycle</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Access modes</th>
                                <td>ReadWriteOnce</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Reason</th>
                                <td>-</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Message</th>
                                <td>-</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_second_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Source</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style="*">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Path</th>
                                <td>/home/rex/hyerin</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_third_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Capacity</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style="width:50%;">
                                <col style="width:50%;">
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Resource name</th>
                                <td>Quantity</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Storage</td>
                                <td>100 Mi</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Details 끝 -->
</div>
