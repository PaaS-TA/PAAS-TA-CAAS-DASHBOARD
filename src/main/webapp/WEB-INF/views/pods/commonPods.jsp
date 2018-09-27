<%--
  Common-pods.jsp
  @author Hyungu Cho
  @version 1.0
  @since 2018.09.03
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<h1 id="workload_pod_name" class="view-title"></h1>
<script type="text/javascript">
    var G_POD_NAME = '<c:out value="${podName}" default="" />';

    // UPPER CASE FOR FIRST LETTER ONLY
    var upperCaseFirstLetterOnly = function(obj) {
        return (obj + '').charAt(0).toUpperCase() + (obj + '').substring(1);
    };

    // SET ICON NEXT TO POD'S NAME
    var setPodStatusIcon = function() {
        var podStatusIconHtml = '<span class="fa fa-file-alt" style="color:#2a6575;"></span> ';
        $("#workload_pod_name").html(podStatusIconHtml + " " + G_POD_NAME);
    };

    // ON LOAD
    $(document.body).ready(function() {
        viewLoading('show');
        if ("" === nvl(G_POD_NAME)) {
            viewLoading('hide');
            alert("Pod 이름을 가져올 수 없습니다.");
            return;
        }
        setPodStatusIcon();
        viewLoading('hide');
    });
</script>