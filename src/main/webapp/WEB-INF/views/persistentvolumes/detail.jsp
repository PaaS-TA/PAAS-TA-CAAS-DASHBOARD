<%--TODO :: REMOVE--%>
<%--&lt;%&ndash;--%>
  <%--PersistentVloume main--%>
  <%--@author CISS--%>
  <%--@version 1.0--%>
  <%--@since 2018.08.14--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
<%--<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>--%>
<%--<%@ page import="org.paasta.caas.dashboard.common.Constants" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<%--<div class="content">--%>
    <%--<h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> oracle-test-pv (Volumes_sample)</h1>--%>
    <%--<jsp:include page="../common/contents-tab.jsp" flush="true"/>--%>
    <%--<!-- Details 시작 -->--%>
    <%--<div class="cluster_content01 row two_line two_view harf_view">--%>
        <%--<ul class="maT30">--%>
            <%--<li class="cluster_first_box">--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Details</p>--%>
                    <%--</div>--%>
                    <%--<div class="account_table view">--%>
                        <%--<table>--%>
                            <%--<colgroup>--%>
                                <%--<col style="width:20%">--%>
                                <%--<col style=".">--%>
                            <%--</colgroup>--%>
                            <%--<tbody>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Name</th>--%>
                                <%--<td id="resultName"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Labels</th>--%>
                                <%--<td id="resultLabel"><span class="bg_gray">type : oracle-test</span></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Creation Time</th>--%>
                                <%--<td id="resultCreationTime"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Status</th>--%>
                                <%--<td id="resultStatus">Available</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Claim</th>--%>
                                <%--<td id="resultClaim"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Reclaim policy</th>--%>
                                <%--<td id="resultReclaimPolicy"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Access modes</th>--%>
                                <%--<td id="resultAccessMode"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Reason</th>--%>
                                <%--<td id="resultReason"></td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th><i class="cWrapDot"></i> Message</th>--%>
                                <%--<td id="resultMessage"></td>--%>
                            <%--</tr>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li class="cluster_second_box">--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Source</p>--%>
                    <%--</div>--%>
                    <%--<div class="account_table view">--%>
                        <%--<table>--%>
                            <%--<colgroup>--%>
                                <%--<col style="width:20%">--%>
                                <%--<col style=".">--%>
                            <%--</colgroup>--%>
                            <%--<tbody id="resultAreaForSource">--%>
                            <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<th><i class="cWrapDot"></i> Path</th>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>/home/rex/hyerin</td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li class="cluster_third_box maB50">--%>
                <%--<div class="sortable_wrap">--%>
                    <%--<div class="sortable_top">--%>
                        <%--<p>Capacity</p>--%>
                    <%--</div>--%>
                    <%--<div class="view_table_wrap">--%>
                        <%--<table class="table_event condition alignL">--%>
                            <%--<colgroup>--%>
                                <%--<col style="width:50%;">--%>
                                <%--<col style="width:50%;">--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--<tr>--%>
                                <%--<td>Resource name</th>--%>
                                <%--<td>Quantity</th>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody id="resultAreaForCapacity">--%>
                            <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>Storage</td>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<td>100 Mi</td>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
        <%--</ul>--%>
    <%--</div>--%>
    <%--<!-- Details 끝 -->--%>
<%--</div>--%>

<%--<script type="text/javascript">--%>

    <%--var pvName = '<c:out value="${pvName}"/>';--%>

    <%--// GET DETAIL--%>
    <%--var getDetail = function() {--%>
        <%--var reqUrl = "<%= Constants.API_URL %>/persistentvolumes/" + pvName;--%>
        <%--procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);--%>
    <%--};--%>


    <%--// CALLBACK--%>
    <%--var callbackGetDetail = function(data) {--%>
        <%--if (RESULT_STATUS_FAIL === data.resultStatus) return false;--%>

        <%--var pvName = data.metadata.name;--%>
        <%--var labels = JSON.stringify(data.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');--%>
        <%--var creationTimestamp = data.metadata.creationTimestamp;--%>
        <%--var status = data.status.phase;--%>
        <%--var claim = "-";--%>
        <%--var reclaimPolicy   = nvl(data.spec.persistentVolumeReclaimPolicy);--%>
        <%--var accessModes     = nvl(data.spec.accessModes);--%>
        <%--var reason = "-";--%>
        <%--var message = "-";--%>
        <%--var hostPath = nvl2(data.spec.hostPath.path,"-");--%>
        <%--var storage = nvl2(data.spec.capacity.storage,"-");--%>

        <%--$('#resultName').html(pvName);--%>
        <%--$('#resultLabel').html(createSpans(labels));--%>
        <%--$('#resultCreationTime').html(creationTimestamp);--%>
        <%--$('#resultStatus').html(status);--%>
        <%--$('#resultClaim').html(claim);--%>
        <%--$('#resultReclaimPolicy').html(reclaimPolicy);--%>
        <%--$('#resultAccessMode').html(accessModes);--%>
        <%--$('#resultReason').html(reason);--%>
        <%--$('#resultMessage').html(message);--%>

        <%--$('#resultAreaForSource').append(--%>
                <%--"<tr>"--%>
                <%--+"<th><i class='cWrapDot'></i> Path</th>"--%>
                <%--+"<td>"+ hostPath +"</td>"--%>
                <%--+"</tr>"--%>
        <%--);--%>

        <%--$('#resultAreaForCapacity').append(--%>
                <%--"<tr>"--%>
                <%--+"<td>Storage</td>"--%>
                <%--+"<td>"+ storage +"</td>"--%>
                <%--+"</tr>"--%>
        <%--);--%>
    <%--};--%>


    <%--var createSpans = function (data, type) {--%>
        <%--var datas = data.replace(/=/g, ':').split(',');--%>
        <%--var spanTemplate = "";--%>

        <%--if (type === "LB") { // Line Break--%>
            <%--$.each(datas, function (index, data) {--%>
                <%--if (index != 0) {--%>
                    <%--spanTemplate += '<br>';--%>
                <%--}--%>
                <%--spanTemplate += '<span class="bg_gray">' + data + '</span>';--%>
            <%--});--%>
        <%--} else {--%>
            <%--$.each(datas, function (index, data) {--%>
                <%--spanTemplate += '<span class="bg_gray">' + data + '</span> ';--%>
            <%--});--%>
        <%--}--%>

        <%--return spanTemplate;--%>
    <%--}--%>

    <%--// ON LOAD--%>
    <%--$(document.body).ready(function () {--%>
        <%--getDetail();--%>
    <%--});--%>

<%--</script>--%>