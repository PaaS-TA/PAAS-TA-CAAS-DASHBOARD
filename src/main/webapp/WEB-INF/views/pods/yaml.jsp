<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="content">
    <jsp:include page="common-pods.jsp" flush="true"/>

    <%-- NODES HEADER INCLUDE --%>
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

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
                        </pre>
                        </div>
                    </div>
            </li>
        </ul>
    </div>
    <!-- Services YAML 끝 -->
</div>

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
        viewLoading('show');

        var URL = "<%= Constants.API_URL %><%= Constants.API_WORKLOAD %>/namespaces/" + NAME_SPACE + "/pods/" + G_POD_NAME;
        procCallAjax(URL, "GET", null, null, callbackGetPods);

        viewLoading('hide');
    });

    var callbackGetPods = function (data) {
        viewLoading('show');

        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Pod 정보를 가져오지 못했습니다.", false);
            return;
        }

        $('#resultArea').html('---\n' + data.sourceTypeYaml);

        viewLoading('hide');
    }
</script>
