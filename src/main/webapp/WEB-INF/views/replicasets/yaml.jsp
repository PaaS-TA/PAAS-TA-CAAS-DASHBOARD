<%--
  Replicaset yaml
  @author CISS
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
        var resourceName = "<c:out value='${replicaSetName}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_REPLICA_SETS_YAML %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{replicaSetName:.+}", resourceName);

        procGetCommonDetailYaml(reqUrl, resourceName);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
