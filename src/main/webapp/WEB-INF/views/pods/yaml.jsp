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
    <jsp:include page="commonPods.jsp" flush="true"/>

    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

    <!-- Services YAML 시작-->
    <div class="cluster_content03 row two_line two_view harf_view custom_display_block">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>YAML</p>
                    </div>
                    <div id="resultYamlArea" class="paA30">
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

<jsp:include page="../common/syntaxHighlighter.jsp" flush="true"/>

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function() {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_YAML %>"
            .replace("{namespace:.+}", NAME_SPACE).replace("{podName:.+}", G_POD_NAME);
        procCallAjax(reqUrl, "GET", null, null, callbackGetPods);
    });

    var callbackGetPods = function(data) {
        viewLoading('show');

        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
            return;
        }

        $('#resultArea').html('---\n' + nvl(data.sourceTypeYaml, ''));

        viewLoading('hide');
    };
</script>
