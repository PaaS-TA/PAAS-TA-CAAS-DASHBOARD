<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2019-10-28
  Time: 오후 4:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/commonYaml.jsp"/>

<script type="text/javascript">

    // GET DETAIL
    var getDetail = function () {
        var resourceName = "<c:out value='${persistentVolumeClaimName}' default='' />";

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_STORAGES_YAML %>"
            .replace("{namespace:.+}", NAME_SPACE)
            .replace("{persistentVolumeClaimName:.+}", resourceName);

        procGetCommonDetailYaml(reqUrl, resourceName);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getDetail();
    });

</script>
