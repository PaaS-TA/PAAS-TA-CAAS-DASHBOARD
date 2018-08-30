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
                                <td>Created on<button class="sort-arrow"><i class="fas fa-caret-down"></i></button></
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="/caas/clusters/persistentVolumes/aaa">oracle-test-pv</a></td>
                                <td>100Mi</td>
                                <td>ReadWriteOnce</td>
                                <td>Recycle</td>
                                <td>Available</td>
                                <td>-</td>
                                <td>-</td>
                                <td>2015-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="/caas/clusters/persistentVolumes/aaa">oracle-test-pv</a></td>
                                <td>100Mi</td>
                                <td>ReadOnlyMany</td>
                                <td>Recycle</td>
                                <td>Available</td>
                                <td>-</td>
                                <td>-</td>
                                <td>2015-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a href="/caas/clusters/persistentVolumes/aaa">oracle-test-pv</a></td>
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
