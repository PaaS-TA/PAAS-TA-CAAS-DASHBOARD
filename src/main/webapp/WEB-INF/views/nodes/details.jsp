<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <%-- NODES HEADER INCLUDE --%>
    <%@ include file="tab.jsp" %>

    <!-- Nodes Details 시작-->
    <div class="cluster_content02 row two_line two_view harf_view">
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
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td>ip-172-31-20-237</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td><span class="bg_gray">app : nginx-2</span> <span class="bg_gray">tier : node</span>
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td><span class="bg_gray">deprecated.daemonset.template.generation: 1</span> <span
                                        class="bg_blue"><a href="#" data-target="#layerpop" data-toggle="modal">kubectl.kubernetes.io/last-applied-Config</a></span>
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td>2018-07-04 20:15:30</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Addresses</th>
                                <td><span class="bg_gray">InternalIP : 172.31.22.173</span> <span class="bg_gray">Hostname : ip-172-31-22-173</span>
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Pod CIDR</th>
                                <td>10.244.1.0/24</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Unschedulable</th>
                                <td>false</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <li class="cluster_second_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>System info</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Machine ID</th>
                                <td>fd43cfb2cc92450eb65e9d24660e0bc7</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> System UUID</th>
                                <td>EC29F5E7-A61F-19FB-DABA-C4F461DDD978</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Boot ID</th>
                                <td>8bb12b22-eb47-4dbf-ba87-403a57df178c</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kernel Version</th>
                                <td>4.4.0-1062-aws</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> OS Images</th>
                                <td>Ubuntu 16.04.4 LTS</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Container Runtime Version</th>
                                <td>docker://1.13.1</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kubelet version</th>
                                <td>v1.11.0</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Kube-Proxy Version</th>
                                <td>v1.11.0</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Operation system</th>
                                <td>linux</td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Architecture</th>
                                <td>amd64</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>

    <!-- modal -->
    <div class="modal fade in" id="layerpop">
        <%-- layerpop is used nodes' detail --%>
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center nodes">
                <div class="modal-content">
                    <!-- header -->
                    <div class="modal-header">
                        <!-- 닫기(x) 버튼 -->
                        <button type="button" class="close" data-dismiss="modal">×</button>
                        <!-- header title -->
                        <h4 class="modal-title">kubectl.kubernetes.io/last-applied-configuration</h4>
                    </div>
                    <!-- body -->
                    <div class="modal-body">
                        <p>
                            {"apiVersion":"extensions/v1beta1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"hrjin-spring-music"},"name":"hrjin-spring-music","namespace":"default"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"hrjin-spring-music"}},"template":{"metadata":{"labels":{"app":"hrjin-spring-music"}},"spec":{"automountServiceAccountToken":true,"containers":[{"image":"bluedigm/hrjin-music:0.3","imagePullPolicy":"Always","name":"hrjin-spring-music-container","ports":[{"containerPort":7878}]}],"serviceAccountName":"hrjin-sa4"}}}}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var callbackGetNodeDetail = function (data) {
        // TODO :: write logic
    }

    var loadLayerpop = function () {
        // MOVE LAYERPOP UNDER BODY ELEMENT
        var layerpop = $('#layerpop');
        layerpop.parent().find(layerpop).remove();
        $('body').append(layerpop);
    };

    $(document.body).ready(function () {
       loadLayerpop();
    });
</script>
<!-- Nodes Details 끝 -->
