<%--
  Created by IntelliJ IDEA.
  User: hgcho
  Date: 2018-08-27
  Time: 오후 5:26
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Nodes 시작-->
<script>var nodeScriptTest = 1234;</script>
<div class="cluster_content03 row two_line two_view">
    <ul class="maT30">
        <li>
            <div class="sortable_wrap">
                <div class="sortable_top">
                    <p>Nodes</p>
                    <ul class="colright_btn">
                        <li>
                            <input type="text" id="table-search-01" name="" class="table-search" placeholder="search"/>
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
                            <td>Name
                                <button class="sort-arrow"><i class="fas fa-caret-down"></i></button>
                            </td>
                            <td>Ready</td>
                            <td>CPU requests</td>
                            <td>CPU limits</td>
                            <td>Memory requests</td>
                            <td>Memory limits</td>
                            <td>Created on
                                <button class="sort-arrow"><i class="fas fa-caret-down"></i></button>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_nodes_view.html">ip-172-31-20-237</a></td>
                            <td>True</td>
                            <td>831 mCPU</td>
                            <td>940 mCPU</td>
                            <td>931.95 MB</td>
                            <td>2.77 GB</td>
                            <td>2018-07-09 18:31:01</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_nodes_view.html">ip-172-31-20-237</a></td>
                            <td>True</td>
                            <td>831 mCPU</td>
                            <td>940 mCPU</td>
                            <td>931.95 MB</td>
                            <td>2.77 GB</td>
                            <td>2018-07-09 18:31:01</td>
                        </tr>
                        <tr>
                            <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                    href="caas_nodes_view.html">ip-172-31-20-237</a></td>
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
<script>var nodeScriptTest2 = 5678;</script>
<!-- Nodes 끝 -->