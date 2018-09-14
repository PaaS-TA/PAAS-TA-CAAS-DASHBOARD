<%--
  Common-pods.jsp
  @author Hyungu Cho
  @version 1.0
  @since 2018.09.03
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<h1 id="workload_pod_name" class="view-title">
    <%-- <span class="green2"><i class="fas fa-check-circle"></i></span> --%>
</h1>
<script type="text/javascript">
    var G_POD_NAME = '<c:out value="${podName}" default="" />';

    var getPodStatus = function (podStatus) {
        /*
        1. Pod's status is succeeded -> return this.
        1. count of pod's containers is less than 0 -> return pod's status
        2. else...
          2.1. all of pod's container statuses is "Running" -> return "Running"
          2.2. some of pod's container statuses isn't "Running" -> return these status, but "terminated" state is the highest order.
         */
        if (podStatus.phase.includes("Succeeded"))
            return podStatus.phase;

        // default value is empty array, callback is none.
        var containerStatuses = procIfDataIsNull(podStatus["containerStatuses"], null, []);
        if (containerStatuses instanceof Array && 0 === containerStatuses.length)
            return podStatus.phase;

        var notRunningIndex = -1;
        var notRunningState = "";
        containerStatuses.map(function (item, index) {
            var state = Object.keys(item.state)[0];
            // terminated state : highest order
            if ("running" !== state && "terminated" !== notRunningState) {
                notRunningIndex = index;
                notRunningState = state;
            }
        });

        if (-1 === notRunningIndex) {
            return "Running";
        } else {
            // ex : Waiting: ImagePullBackOff
            var statusStr = notRunningState.charAt(0).toUpperCase() + notRunningState.substring(1);
            var reason = procIfDataIsNull(containerStatuses[notRunningIndex].state[notRunningState]["reason"], null, "Unknown");
            return (statusStr + ": " + reason);
        }
    };

    var setPodStatusIcon = function() {
        var podStatusIconHtml = '<span class="fa fa-file-alt" style="color:#2a6575;"></span> ';
        $("#workload_pod_name").html( podStatusIconHtml + " " + G_POD_NAME);
    };

    $(document.body).ready(function () {
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