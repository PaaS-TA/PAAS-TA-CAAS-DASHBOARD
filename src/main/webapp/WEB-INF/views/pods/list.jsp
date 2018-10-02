<%--
  Pods list (only included-usage)
  @author Hyungu Cho
  @version 1.0
  @since 2018.09.10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<div class="sortable_wrap">
    <div class="sortable_top">
        <p>Pods</p>
        <ul id="pod-list-search-form" class="colright_btn">
            <li>
                <input type="text" id="table-search-01" name="table-search" class="table-search" placeholder="search"
                       onkeypress="if (event.keyCode === 13) { setPodsListWithFilter(this.value); }"/>
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
                <col style='width:10%;'>
                <col style='width:5%;'>
                <col style='width:10%;'>
                <col style='width:10%;'>
                <col style='width:10%;'>
            </colgroup>
            <thead>
            <tr id="noPodListResultArea" style="display: none;">
                <td colspan='8'><p class='service_p'>실행 중인 Pod가 없습니다.</p></td>
            </tr>
            <tr id="podListResultHeaderArea" class="headerSortFalse">
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
                <td>CPU (cores)</td>
                <td>Memory (bytes)</td>
            </tr>
            </thead>
            <tbody id="podListResultArea">
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
    var G_PODS_CHART_RUNNING_CNT = 0;
    var G_PODS_CHART_FAILED_CNT = 0;
    var G_PODS_CHART_PENDING_CNT = 0;
    var G_PODS_CHART_SUCCEEDED_CNT = 0;
    var G_PODS_LIST_LENGTH = 0;

    // CALLBACK POD LIST
    var callbackGetPodList = function(data) {
        viewLoading('show');

        $('#noPodListResultArea').show();
        $('#podListResultArea').hide();
        $('#podListResultHeaderArea').hide();

        if (!procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage();
            return;
        }

        var pod;
        var podList = [];
        var podNameList = [];
        $.each(data.items, function(index, item) {
            pod = getPod(item);
            podList.push(pod);
            podNameList.push(pod.name);

            switch (pod.podStatus) {
                case 'Pending':
                    G_PODS_CHART_PENDING_CNT++;
                    break;
                case 'Running':
                    G_PODS_CHART_RUNNING_CNT++;
                    break;
                case 'Succeeded':
                    G_PODS_CHART_SUCCEEDED_CNT++;
                    break;
                default:
                    G_PODS_CHART_FAILED_CNT++;
                    break;
            }
            G_PODS_LIST_LENGTH++;
        });

        setPodTable(podList);
        procSetEventStatusForPods(podNameList);

        procSetToolTipForTableTd('podListResultArea');
        $('[data-toggle="tooltip"]').tooltip();

        viewLoading('hide');
    };

    // GET POD STATUS FROM POD'S STATUS DATA
    var getPodStatus = function(podStatus) {
        var podStatusStr = nvl(podStatus.phase, 'Unknown');
        if (podStatusStr.includes('Succeeded')) {
            return podStatusStr;
        }

        // default value is empty array, callback is none.
        var containerStatuses = [];
        if ('' !== nvl(podStatus['containerStatuses'])) {
            containerStatuses = podStatus['containerStatuses']
        }

        if (containerStatuses instanceof Array && 0 === containerStatuses.length) {
            return podStatusStr;
        }

        var notRunningIndex = -1;
        var notRunningState = podStatusStr.toLowerCase();
        containerStatuses.map(function(item, index) {
            var state = Object.keys(item.state)[0];
            // terminated state : highest order
            if ('running' !== state && 'terminated' !== notRunningState) {
                notRunningIndex = index;
                notRunningState = state;
            }
        });

        if (-1 === notRunningIndex) {
            return 'Running';
        } else {
            var statusStr = notRunningState.charAt(0).toUpperCase() + notRunningState.substring(1);
            var reason = nvl(containerStatuses[notRunningIndex].state[notRunningState]['reason'], 'Unknown');
            return (statusStr + ': ' + reason);
        }
    };

    // GET POD DATA
    var getPod = function(podItem) {
        var metadata = podItem.metadata;
        var spec = podItem.spec;
        var status = getPodStatus(podItem.status);
        var errorMsg;
        if (status !== 'Running' && status !== 'Succeeded') {
            errorMsg = 'Unknown Error';
            if ('' !== nvl(podItem.status.conditions)) {
                var findConditions = podItem.status.conditions.filter(function(item) {
                    return item.reason != null && item.message != null
                });
                if (findConditions.length > 0) {
                    errorMsg = findConditions[0].reason;
                    if ('' !== nvl(findConditions[0].message)) {
                        errorMsg += ' (' + findConditions[0].message + ')';
                    }
                }
            }
        } else {
            errorMsg = '';
        }

        var containerStatuses = [];
        if ('' !== nvl(podItem.status.containerStatuses)) {
            containerStatuses = podItem.status.containerStatuses;
        }
        var restartCountSum = 0;
        for (var i = 0; i < containerStatuses.length; i++) {
            if ('' !== nvl(containerStatuses.restartCount)) {
                restartCountSum += containerStatuses.restartCount;
            }
        }

        var cpuSum = 0;
        var memorySum = 0;
        var hasResources = false;
        if ('' != nvl(spec.containers)) {
            try {
                $.each(spec.containers, function(index, container) {
                    if ('' === nvl(container.resources))
                        return;
                    var resource = {};
                    if ('' !== nvl(container.resources.limits)) {
                        resource = container.resources.limits;
                    } else if ('' !== nvl(container.resources.requests)) {
                        resource = container.resources.requests;
                    } else {
                        return;
                    }
                    hasResources = true;

                    if (resource.cpu.indexOf('m') > 0) {
                        cpuSum += Number(resource.cpu.substring(0, resource.cpu.length - 1));
                    } else {
                        cpuSum += Number(resource.cpu) * 1000;
                    }

                    var multiple = 1;
                    if (resource.memory.toLowerCase().indexOf('gi') > 0) {
                        multiple = 1024;
                    }

                    memorySum += (multiple * Number(resource.memory.substring(0, resource.memory.length - 2)));
                });
            } catch (e) {
                cpuSum = memorySum = -1;
            }
        }

        if (!hasResources) {
            cpuSum = memorySum = -1;
        }

        if (cpuSum <= -1) {
            cpuSum = '-';
        } else if (cpuSum > 1000) {
            var cpuFloat = Number.parseFloat(cpuSum / 1000).toFixed(3);
            var cpuInt = Number.parseInt(cpuSum / 1000);
            if (Math.abs(cpuFloat - cpuInt) === 0) {
                cpuSum = cpuInt;
            } else {
                cpuSum = cpuFloat;
            }
        } else {
            cpuSum += 'm';
        }

        if (memorySum <= -1) {
            memorySum = '-';
        } else if (memorySum > 102400) {
            var memoryFloat = Number.parseFloat(memorySum / 1024).toFixed(3);
            var memoryInt = Number.parseInt(memorySum / 1024);
            if (Math.abs(memoryFloat - memoryInt) === 0) {
                memorySum = memoryInt + 'Gi';
            } else {
                memorySum = memoryFloat + 'Gi';
            }
        } else {
            memorySum += 'Mi';
        }

        return {
            name: metadata.name,
            namespace: metadata.namespace,
            nodeName: nvl(spec.nodeName, '-'),
            podStatus: status,
            podErrorMsg: errorMsg,
            restartCount: restartCountSum,
            creationTimestamp: metadata.creationTimestamp,
            usageCPU: cpuSum,
            usageMemory: memorySum
        };
    };

    // CREATE ANCHOR TAG FUNCTION
    var createMovePageAnchorTag = function(movePageUrl, content) {
        var anchorTag = '<a href="javascript:void(0);" onclick="procMovePage(\'' + movePageUrl + '\');">' + content + '</a>';
        return anchorTag;
    };

    // SET POD LIST TABLE
    var setPodTable = function(podList) {
        var resultArea = $('#podListResultArea');
        var resultHeaderArea = $('#podListResultHeaderArea');
        var noResultArea = $('#noPodListResultArea');

        noResultArea.show();
        resultHeaderArea.hide();
        resultArea.hide();

        var listLength = podList.length;
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            var pod = podList[i];

            var podNameHtml = '<span class="running2 tableTdToolTipFalse"><i class="fas fa-check-circle"></i></span> '
                + createMovePageAnchorTag('<%= Constants.URI_WORKLOAD_PODS %>/' + pod.name, pod.name);

            var nodeNameHtml;
            if (pod.nodeName !== '-') {
                nodeNameHtml = createMovePageAnchorTag('<%= Constants.URI_CLUSTER_NODES %>/' + pod.nodeName + '/summary', pod.nodeName);
            } else {
                nodeNameHtml = '-';
            }

            var namespaceHtml = createMovePageAnchorTag('<%= Constants.URI_CLUSTER_NAMESPACES %>/' + pod.namespace, pod.namespace);

            htmlString.push('<tr name="podRow" data-search-key="' + pod.name + '">'
                + '<td id="' + pod.name + '">' + podNameHtml + '</td>'
                + '<td>' + namespaceHtml + '</td>'
                + '<td>' + nodeNameHtml + '</td>'
                + '<td><span>' + pod.podStatus + '</span></td>'
                + '<td>' + pod.restartCount + '</td>'
                + '<td>' + pod.creationTimestamp + '</td>'
                + '<td><span>' + pod.usageCPU + '</span></td>'
                + '<td><span>' + pod.usageMemory + '</span></td>'
                + '</tr>');
        }

        if (htmlString.length > 0) {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();

            resultArea.html(htmlString);

            var resultTable = $('#resultTableForPod');
            resultTable.tablesorter({
                sortList: [[5, 1]] // 0 = ASC, 1 = DESC
            });
            resultTable.trigger('update');
            $('.headerSortFalse > td').unbind();
        }
    };

    // FILTER POD LIST BY POD NAME
    var setPodsListWithFilter = function(findValue) {
        viewLoading('show');

        var podsTableHeader = $('#podListResultHeaderArea');
        var podNotFound = $('#noPodListResultArea');
        var podRows = $('tr[name=podRow]');

        if (podRows.length > 0) {
            if ('' === nvl(findValue)) {
                podNotFound.hide();
                podsTableHeader.show();
                podRows.show();
            } else {
                var showCount = 0;
                $.each(podRows, function(index, podRow) {
                    var rowElement = $(podRow);
                    if (rowElement.data('searchKey').includes(findValue)) {
                        rowElement.show();
                        showCount++;
                    } else {
                        rowElement.hide();
                    }
                });

                if (showCount <= 0) {
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

    // GET PODS' LIST USING REQUEST URL
    var getPodListUsingRequestURL = function(reqUrl) {
        procCallAjax(reqUrl, 'GET', null, null, callbackGetPodList);
    }

    // GET PODS' LIST
    var getPodsList = function() {
        var reqUrl = '<%= Constants.API_URL %><%= Constants.URI_API_PODS_LIST %>'.replace('{namespace:.+}', NAME_SPACE);
        getPodListUsingRequestURL(reqUrl);
    };
</script>
