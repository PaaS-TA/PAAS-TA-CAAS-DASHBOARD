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
    <jsp:include page="common-nodes.jsp"/>

    <%-- NODES HEADER INCLUDE --%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <!-- NodeEvents 시작-->
    <div class="cluster_content03 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
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
                                <td>Back-off pulling Images "aa"</td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{aa}</td>
                                <td>41923</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td><span class="red2"><i
                                        class="fas fa-exclamation-circle"></i> Error: ImagesPullBackOff</span></td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{aa}</td>
                                <td>41278</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td>Back-off pulling Images "bb"</td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{bb}</td>
                                <td>129005</td>
                                <td>2018-07-08 18:31:01</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr>
                                <td><span class="red2"><i
                                        class="fas fa-exclamation-circle"></i> Error: ImagesPullBackOff</span></td>
                                <td>kubelet ip-172-31-27-131</td>
                                <td>spec.containers{bb}</td>
                                <td>129005</td>
                                <td>2018-07-08 18:31:01</td>
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
</div>
<script>
    var callbackGetNodeEvent = function (data) {
        // TODO :: write logic
    }

    $(document.body).ready(function () {
        // empty
    });
</script>
<!-- NodeEvents 끝 -->
