<%--
  Common pods (only included-usage)
  @author Hyungu Cho
  @version 1.0
  @since 2018.09.03
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1 id="workload_pod_name" class="view-title"></h1>
<script type="text/javascript">
    var G_POD_NAME = '<c:out value="${podName}" default="" />';

    // REPLACE FIRST LETTER ONLY TO UPPER-CASE ALPHABET LETTER FROM EXTERNAL STRING(OR OBJECT)
    var upperCaseFirstLetterOnly = function(obj) {
        return (obj + '').charAt(0).toUpperCase() + (obj + '').substring(1);
    };

    // SET ICON NEXT TO POD'S NAME (FOR H1 TAG)
    var setPodStatusIcon = function() {
        viewLoading('show');
        
        if ('' === nvl(G_POD_NAME)) {
            viewLoading('hide');
            alertMessage();
            return;
        }
        
        var podStatusIconHtml = '<span class="fa fa-file-alt" style="color:#2a6575;"></span> ';
        $('#workload_pod_name').html(podStatusIconHtml + ' ' + G_POD_NAME);
        
        viewLoading('hide');
    };

    // ON LOAD
    $(document.body).ready(function() {
        setPodStatusIcon();
    });
</script>