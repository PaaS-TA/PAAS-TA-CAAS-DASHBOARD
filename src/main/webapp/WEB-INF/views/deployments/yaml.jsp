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
    <h1 class="view-title"><span class="fa fa-file-alt" style="color:#2a6575;"></span> <c:out value="${deploymentsName}"/></h1>
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

<%--SyntexHighlighter--%>
<jsp:include page="../common/syntaxHighlighter.jsp" flush="true"/>

<script type="text/javascript">
    var deployName = '<c:out value="${deploymentsName}"/>';

    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

    var getDetail = function() {
        viewLoading('show');
        var reqUrl = "<%= Constants.URI_API_DEPLOYMENTS_YAML %>".replace("{namespace:.+}", NAME_SPACE)
                                                                    .replace("{deploymentsName:.+}", deployName);

        procCallAjax(reqUrl, "GET", null, null, callbackGetDeployments);
    };

    var callbackGetDeployments = function (data) {
        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
            return false;
        }
        $('#resultArea').html('---\n' + data.sourceTypeYaml);
        viewLoading('hide');
    }

</script>
