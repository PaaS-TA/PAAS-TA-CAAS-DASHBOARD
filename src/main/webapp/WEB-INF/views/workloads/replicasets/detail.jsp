<%--
  Replicaset main
  @author CISS
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span>kube-flannel-ds</h1>
    <jsp:include page="../../common/contents-tab.jsp" flush="true"/>
        <!-- Details 시작-->
        <div class="cluster_content01 row two_line two_view harf_view">
            <ul class="maT30">
                <!-- Details 시작 -->
                <li class="cluster_second_box">
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
                                    <th><i class="cWrapDot"></i> Namespace</th>
                                    <td>default</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Labels</th>
                                    <td><span class="bg_gray">app : nginx-2</span> <span class="bg_gray">tier: node</span></td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Annotations</th>
                                    <td>
                                        <span class="bg_gray">deprecated.daemonset.template.generation: 1</span>
                                        <span class="bg_blue"><a href="#" target="_blank">kubectl.kubernetes.io/last-applied-Config</a></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Creation Time</th>
                                    <td>2018-07-04 20:15:30</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Selector</th>
                                    <td><span class="bg_gray">app : nginx-2</span></td>
                                </tr>

                                <tr>
                                    <th><i class="cWrapDot"></i> Image</th>
                                    <td>bluedigm/hyerin:portalapi</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Pods</th>
                                    <td>3 running</td>
                                </tr>
                                <tr>
                                    <th><i class="cWrapDot"></i> Managing deployment</th>
                                    <td><a href="#">heapster-v1.5.2</a></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </li>
                <!-- Details 끝 -->
            </ul>
        </div>
</div>