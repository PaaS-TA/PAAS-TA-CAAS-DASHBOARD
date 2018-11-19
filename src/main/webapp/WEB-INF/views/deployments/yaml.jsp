<%--
  Deployment main
  @author PHR
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonYaml.jsp"/>


<script type="text/javascript">

    // GET DETAIL
    var getDetail = function () {
        var resourceName = "<c:out value='${deploymentName}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_DEPLOYMENTS_YAML %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{deploymentName:.+}", resourceName);

        procGetCommonDetailYaml(reqUrl, resourceName);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>