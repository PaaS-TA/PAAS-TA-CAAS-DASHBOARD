<%--
  This file must include </views/common/commonLibs.jsp> file in the file that you want to include this file.
  How to use : Use jsp:include tag under like " ul[class="maT30"] > li " element.
  User: Hyungu Cho
  Date: 2018-09-10
  Time: 오전 09:05
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<div class="sortable_wrap">
    <div class="sortable_top">
        <p>Pods</p>
        <ul id="pod-list-search-form" class="colright_btn">
            <li>
                <input type="text" id="table-search-01" name="table-search" class="table-search" placeholder="Pod name" onkeypress="if (event.keyCode === 13) { setPodsListWithFilter(this.value); }"/>
                <button name="button" class="btn table-search-on" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </li>
        </ul>
    </div>
    <div class="view_table_wrap">
        <table class="table_event condition alignL service-lh" id="resultTableForPod">
            <colgroup>
                <col style='width:auto;'>
                <col style='width:10%;'>
                <col style='width:10%;'>
                <col style='width:20%;'>
                <col style='width:5%;'>
                <col style='width:20%;'>
            </colgroup>
            <thead>
            <tr id="noResultArea" style="display: none;">
                <td colspan='6'><p class='service_p'>실행 중인 Pods가 없습니다.</p></td>
            </tr>
            <tr id="resultHeaderArea" class="headerSortFalse">
                <td>Name
                    <button class="sort-arrow" onclick="procSetSortList('resultTableForPod', this, '0')">
                        <i class="fas fa-caret-down"></i></button>
                </td>
                <td>Namespace</td>
                <td>Node</td>
                <td>Status</td>
                <td>Restarts</td>
                <td>Created on
                    <button class="sort-arrow" onclick="procSetSortList('resultTableForPod', this, '5')">
                        <i class="fas fa-caret-down"></i></button>
                </td>
            </tr>
            </thead>
            <tbody id="resultArea">
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
    var getPodListUsingRequestURL = function (reqUrl) {
        procCallAjax(reqUrl, "GET", null, null, callbackGetPodList);
    };

    var disableSearchPodList = function () {
        $('#pod-list-search-form').remove();
    }

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

    var getPodErrorMessage = function (namespace, podName) {
        var reqUrl = "<%= Constants.URI_API_EVENTS_LIST %>"
            .replace('{namespace:.+}', namespace).replace('{resourceName:.+}', podName);
        procCallAjax(reqUrl, "GET", null, null, function (data) {

        });
    };

    var getPod = function (podItem) {
        // required : name, namespace, node, status, restart(count), created on
        var _metadata = podItem.metadata;
        var _spec = podItem.spec;
        var _containerStatuses = podItem.status.containerStatuses;

        var status = getPodStatus(podItem.status);
        var errorMsg;
        if (status !== "Running" && status !== "Succeeded") {
            var findConditions = podItem.status.conditions.filter(function (item) {
                return item.reason != null && item.message != null
            });
            if (findConditions.length > 0)
                errorMsg = findConditions[0].reason + " (" + findConditions[0].message + ")";
            else
                errorMsg = "Unknown Error";
        }

        // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
        return {
            name: _metadata.name,
            namespace: _metadata.namespace,
            nodeName: nvl(_spec.nodeName, "-"),
            podStatus: status,
            podErrorMsg: errorMsg,
            restartCount: procIfDataIsNull(
                _containerStatuses, function (data) {
                    return data.reduce(function (a, b) {
                        return {restartCount: a.restartCount + b.restartCount};
                    }, {restartCount: 0}).restartCount;
                }, 0),
            creationTimestamp: _metadata.creationTimestamp
        };
    };

    var getPodStatusStyleClass = function (statusString) {
        var styleClassSet;
        if (statusString.includes("Pending")) {
            styleClassSet = {span: "pending2", i: "fas fa-exclamation-triangle"};
        } else if (statusString.includes("Running")) {
            styleClassSet = {span: "running2", i: "fas fa-check-circle"};
        } else if (statusString.includes("Succeeded")) {
            styleClassSet = {span: "succeeded2", i: "fas fa-check-circle"};
        } else if (statusString.includes("Terminiated")) {
            styleClassSet = {span: "failed2", i: "fas fa-exclamation-circle"};
        } else if (statusString.includes("Waiting")) {
            styleClassSet = {span: "waiting2", i: "fas fa-exclamation-triangle"};
        } else {
            // included "Unknown" status
            styleClassSet = {span: "unknown2", i: "fas fa-exclamation-triangle"};
        }

        return styleClassSet;
    };

    var createAnchorTag = function (movePageUrl, content, isTooltip) {
        var anchorTag = "<a href='javascript:void(0);' onclick='procMovePage(\"" + movePageUrl + "\");'>" + content + "</a>"
        if (isTooltip)
            return $(anchorTag).attr('data-toggle', 'tooltip').attr('title', content)[0].outerHTML;
        else
            return anchorTag;
    };

    var setPodTable = function (podList) {
        var listLength = podList.length;
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            var pod = podList[i];
            var styleClassSet = getPodStatusStyleClass(pod.podStatus);

            var podNameHtml = "<span class='" + styleClassSet.span + "'><i class='" + styleClassSet.i + "'></i></span> "
                //+ "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_WORKLOAD_PODS %>/" + pod.name + "\");'>" + pod.name + "</a>";
                + createAnchorTag("<%= Constants.URI_WORKLOAD_PODS %>/" + pod.name, pod.name, true);
            if (null != pod.podErrorMsg && "" !== pod.podErrorMsg) {
                podNameHtml += $("<br><span class='red2 custom-content-overflow' data-toggle='tooltip'>" + pod.podErrorMsg + "</span>").attr('title', pod.podErrorMsg)[0].outerHTML;
            }

            var nodeNameHtml;
            if (pod.nodeName !== "-")
            //nodeNameHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NODES %>/" + pod.nodeName + "/summary\");'>" + pod.nodeName + "</a>";
                nodeNameHtml = createAnchorTag("<%= Constants.URI_CLUSTER_NODES %>/" + pod.nodeName + "/summary", pod.nodeName, true);
            else
                nodeNameHtml = "-";

            //var namespaceHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NAMESPACES %>/" + pod.namespace + "\");'>" + pod.namespace + "</a>";
            var namespaceHtml = createAnchorTag("<%= Constants.URI_CLUSTER_NAMESPACES %>/" + pod.namespace, pod.namespace, true);

            htmlString.push("<tr name='podRow' id='row-" + pod.name + "'>"
                + "<td id='" + pod.name + "'>" + podNameHtml + "</td>"
                + "<td>" + namespaceHtml + "</td>"
                + "<td>" + nodeNameHtml + "</td>"
                + "<td>" + pod.podStatus + "</td>"
                + "<td>" + pod.restartCount + "</td>"
                + "<td>" + pod.creationTimestamp + "</td>"
                + "</tr>");
        }

        // set data into a table
        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');
        var resultTable = $('#resultTable');

        if (htmlString.length < 1) {
            noResultArea.show();
            resultHeaderArea.hide();
            resultArea.hide();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultArea.html(htmlString);
            resultTable.tablesorter();
            resultTable.trigger("update");
            $('.headerSortFalse > td').unbind();
        }
    };

    // filter pod list by pod name
    var setPodsListWithFilter = function (findValue) {
        viewLoading('show');

        var podsTableHeader = $("#resultHeaderArea");
        var podNotFound = $("#noResultArea");
        var podRows = $("tr[name=podRow]");

        if (podRows.length > 0) {
            if (nvl(findValue) === "") {
                // If input element's value is empty, show all rows.
                podNotFound.hide();
                podsTableHeader.show();
                podRows.show();
            } else {
                var showCount = 0;
                $.each(podRows, function (index, row) {
                    var row = $(row);
                    if (row.attr("id").includes(findValue)) {
                        row.show();
                        showCount++;
                    } else {
                        row.hide();
                    }
                });

                if (showCount <= 0) {
                    // html into tr > td > p
                    podNotFound.children().children().html("Pod 이름으로 찾지 못했습니다.");
                    podNotFound.show();
                    podsTableHeader.hide();
                } else {
                    podNotFound.hide();
                    podsTableHeader.show();
                }
            }
        }

        viewLoading('hide');
    };

    var getPodStatuses = function() {
        // 기본값 추가
        return {
            name: "INVALID_NAME",
            status: "INVALID_STATUS"
        };
    };

    // CALLBACK POD LIST
    var callbackGetPodList = function (data) {
        viewLoading('show');

        if (false == procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Node의 Pod 목록을 가져오지 못했습니다.", false);
            $('#noResultArea > td > p').html("Node의 Pod 목록을 가져오지 못했습니다.");
            $('#noResultArea').show();
            $('#resultArea').hide();
            $('#resultHeaderArea').hide();
            return;
        }

        var podList = [];
        var podStatusList = [];
        var podNameList = [];
        $.each(data.items, function (index, item) {
            var _pod = getPod(item);
            var _status;
            switch (_pod.podStatus) {
                case "Pending":
                case "Running":
                case "Succeeded":
                    _status = _pod.podStatus;
                    break;
                default:
                    _status = "Failed";
                    break;
            }

            podList.push(_pod);
            podStatusList.push({ name: _pod.name, status: _status });
            podNameList.push(_pod.name);
        });

        getPodStatuses = function() {
            return podStatusList;
        }

        setPodTable(podList);
        procSetEventStatusForPods(podNameList);

        viewLoading('hide');
    };
</script>
