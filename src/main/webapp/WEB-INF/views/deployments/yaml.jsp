<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <span class="resultServiceName"><c:out value="${deploymentsName}"/></span></h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_left" onclick='movePage("detail");'>Details</li>
            <li name="tab02" class="cluster_tabs_left" onclick='movePage("events");'>Events</li>
            <li name="tab03" class="cluster_tabs_on" style="cursor: default;">YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Services YAML 시작-->
    <div class="cluster_content03 row two_line two_view harf_view custom_display_block">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>YAML</p>
                    </div>
                    <div class="paA30">
                        <div class="yaml">
                        <pre class="brush: yaml" id="resultArea">
                                    <%--<pre class="brush: cpp" id="resultArea">--%>
                                    <%--</pre>--%>
                        </pre>
                        <!--button class="btns colors4">Save</button>
                        <button class="btns colors5">Cancel</button>
                        <button class="btns colors9 pull-right maL05">copy</button>
                        <button class="btns colors9 pull-right">Download</button>
                        <div class="yamlArea">
                            <div class="number">1<br/>2<br/>3<br/>4<br/>5</div>
                            <div class="text">fff<br/>ddd<br/>dfff<br/>dddd<br/>ddd<br/>dfff<br/>dddd</div>
                            <div style="clear:both;"></div>
                        </div>
                        <button class="btns colors4">Save</button>
                        <button class="btns colors5">Cancel</button-->
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Services YAML 끝 -->
</div>
<%--TODO--%>
<!-- modal -->


<input type="hidden" id="requestDeploymentsName" name="requestDeploymentsName" value="<c:out value='${deploymentsName}' default='' />" />


<%--TODO : REMOVE--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>--%>

<!-- SyntexHighlighter -->
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shCore.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushYaml.js"/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shCore.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shThemeDefault.css"/>">

<script type="text/javascript">
    SyntaxHighlighter.defaults['quick-code'] = false;
    SyntaxHighlighter.all();
</script>

<style>
    .syntaxhighlighter .gutter .line{border-right-color:#ddd !important;}
</style>
<!-- SyntexHighlighter -->

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function () {
        var deployName = '<c:out value="${deploymentsName}"/>';
        var URL = "/workloads/deployments/" + NAME_SPACE + "/getDeployment.do";
        console.log("window.location.href ", window.location.href);
        var param = {
            name: deployName
        }
        procCallAjax(URL, "GET", param, null, callbackGetDeployment);

    });
</script>


<script type="text/javascript">

    var callbackGetDeployment = function (data) {
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(
                "ResultStatus :: " + data.resultCode + " <br><br>"
                + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var htmlString = [];


        //$('#resultArea').JSONView(data.source);
        $('#resultArea').html('---\n' + data.sourceTypeYaml);
    }

    var movePage = function(requestPage) {
        var reqUrl = '<%= Constants.CAAS_BASE_URL %><%= Constants.API_WORKLOAD %>/deployments/' + document.getElementById('requestDeploymentsName').value;
        if (requestPage.indexOf('detail') < 0) {
            reqUrl += '/' + requestPage;
        }

        procMovePage(reqUrl);
    };

</script>
