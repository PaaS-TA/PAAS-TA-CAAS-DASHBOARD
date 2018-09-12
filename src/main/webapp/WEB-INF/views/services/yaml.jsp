<%--
  Services yaml
  @author REX
  @version 1.0
  @since 2018.08.28
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <span class="resultServiceName"><c:out value='${serviceName}' default='' /></span></h1>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>
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
                            <pre class="brush: yaml" id="resultArea"> -
                            </pre>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Services YAML 끝 -->
</div>
<div id="hiddenResultArea" style="display: none;"></div>
<input type="hidden" id="requestServiceName" name="requestServiceName" value="<c:out value='${serviceName}' default='' />" />


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

    // GET DETAIL
    var getDetail = function() {
        viewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_SERVICES_YAML %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{serviceName:.+}", document.getElementById('requestServiceName').value);
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };


    // CALLBACK
    var callbackGetDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        $('#resultArea').html('---\n' + data.sourceTypeYaml);

        viewLoading('hide');
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
