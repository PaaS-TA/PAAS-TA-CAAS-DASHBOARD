<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="content">
    <jsp:include page="commonPods.jsp"/>

    <%-- TAB INCLUDE --%>
    <jsp:include page="../common/contentsTab.jsp" flush="true"/>

    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <li class="cluster_first_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Details</p>
                    </div>
                    <div class="account_table view">
                        <table>
                            <colgroup>
                                <col style="width:20%">
                                <col style=".">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th><i class="cWrapDot"></i> Name</th>
                                <td id="name"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td id="labels" class="labels_wrap"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="creationTime"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td id="status"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> QoS Class</th>
                                <td id="qosClass"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Node</th>
                                <td id="node"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> IP</th>
                                <td id="ip"></td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Conditions</th>
                                <td id="conditions"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Controllers</th>
                                <%--<td>Replica Set : <a href="http://caas_replica_view.html">spring-cloud-web-user-d7c647b44</a></td>--%>
                                <td id="controllers"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Volumes</th>
                                <td id="volumes"></td>
                                <%--<td><a href="#">default-token-9vmgs</a></td>--%>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Containers 시작 -->
            <li class="cluster_third_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Containers</p>
                    </div>
                    <div class="view_table_wrap toggle">
                        <table class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:15%;'>
                                <col style='width:25%;'>
                                <col style='width:15%;'>
                            </colgroup>
                            <tr id="noContainersResultArea" style="display: none;"><td colspan='6'><p class='service_p'>조회 된 Pods가 없습니다.</p></td></tr>
                            <thead id="containersResultHeaderArea">
                            <tr>
                                <td>Name</td>
                                <td>Status</td>
                                <td>Images</td>
                                <td>Restart count</td>
                            </tr>
                            </thead>
                            <tbody id="containersResultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Containers 끝 -->
        </ul>
    </div>
    <!-- Details  끝 -->
    <%-- Container 정보에 대한 Table Form 시작 --%>
    <table id="containerForm" class="table_detail alignL">
        <colgroup>
            <col style="*">
            <col style="*">
        </colgroup>
        <tbody>
        <tr>
            <td>Name</td>
            <td name="cName"></td>
        </tr>
        <tr>
            <td>Image</td>
            <td name="cImage"></td>
        </tr>
        <tr>
            <td>Environment variables</td>
            <td name="cEnv"></td>
        </tr>
        <tr>
            <td>Commands</td>
            <td name="cCmd"></td>
        </tr>
        <tr>
            <td>Args</td>
            <td name="cArgs"></td>
        </tr>
        </tbody>
    </table>
    <%-- Container 정보에 대한 Table Form 끝 --%>
</div>
<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function() {
        viewLoading('show');
        getDetail();
        viewLoading('hide');
    });

    // GET POD'S DETAIL
    var getDetail = function() {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_PODS_DETAIL %>"
            .replace("{namespace:.+}", NAME_SPACE).replace("{podName:.+}", G_POD_NAME);
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };

    // CALLBACK GET POD'S DETAIL
    var callbackGetDetail = function(data) {
        viewLoading('show');

        if (false === procCheckValidData(data)) {
            viewLoading('hide');
            alertMessage("Node 정보를 가져오지 못했습니다.", false);
            return;
        }

        var labels = stringifyJSON(data.metadata.labels).replace(/,/g, ', ');
        // var selector = stringifyJSON(data.spec.selector).replace(/matchLabels=/g, '');

        document.getElementById("name").textContent = data.metadata.name;
        document.getElementById("labels").innerHTML = createSpans(labels, "false");
        document.getElementById("creationTime").textContent = data.metadata.creationTimestamp;
        document.getElementById("status").innerHTML = data.status.phase;
        document.getElementById("qosClass").textContent = data.status.qosClass; //qosClass
        document.getElementById("conditions").textContent = conditionParser(data.status.conditions);

        if (data.spec.nodeName == null) {
            document.getElementById("node").innerHTML = "-";
        }

        if (data.spec.nodeName != null) {
            document.getElementById("node").innerHTML = "<a href='javascript:void(0);' onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NODES %>/" + data.spec.nodeName + "/summary\");'>" +
                data.spec.nodeName +
                '</a>';
        }

        document.getElementById("ip").textContent = nvl(data.status.podIP, "-");

        if (labels.match('job-name')) {
            // A tag position for Jobs detail page
            document.getElementById("controllers").innerHTML = data.metadata.ownerReferences[0].name;
        } else {
            document.getElementById("controllers").innerHTML = "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/workloads/replicaSets/" + data.metadata.ownerReferences[0].name + "\");'>" +
                data.metadata.ownerReferences[0].name +
                '</a>';
        }
        document.getElementById("volumes").textContent = data.spec.volumes[0].name;

        createContainerResultArea(data.status, data.spec.containers);

        viewLoading('hide');
    };

    // CREATE SPANS FOR LABELS
    var createSpans = function(inputData, type) {
        var data = inputData.replace(/=/g, ':').split(/,\s/);
        var spanHtml = "";

        $.each(data, function(index, item) {
            if (type === "true" && index > 0)
                spanHtml += '<br>';

            var htmlString = null;
            var separatorIndex = item.indexOf(": ");
            if (separatorIndex > 0) {
                var title = item.substring(0, separatorIndex);
                var content = item.substring(separatorIndex + 2);
                try {
                    var test = JSON.parse(content);    // JSON object test only
                    if (test instanceof Object || test instanceof Array) {
                        htmlString = $('<span class="bg_blue" onclick="setLayerpop(this)" data-target="#layerpop3" data-toggle="modal" '
                            + 'data-title="' + title + '"><a>' + title + '</a></span> ')
                            .attr('data-content', content).wrapAll("<div/>").parent().html();
                    }
                } catch (e) {
                }
            }

            if (null == htmlString)
                htmlString = '<span class="bg_gray">' + item.replace(": ", ":") + '</span>';

            spanHtml += (htmlString + ' ');
        });

        return spanHtml;
    };

    // PARSER OF POD'S CONDITIONS
    var conditionParser = function(data) {
        var tempStr = "";

        for (var i = 0; i < data.length; i++) {
            if (i > 0) {
                tempStr += ", ";
            }

            tempStr += (data[i].type + ": " + data[i].status);
        }
        return tempStr;
    };

    // CREATE CONTAINER MAP (CONTAINER INFO + CONTAINER STATUS)
    var getContainerMap = function(containers, containerStatuses, podPhase) {
        var containerMap = {};
        var tempArr;
        containers.map(function(container) {
            var name = nvl(container['name']);
            if ("" !== name)
                containerMap[name] = container;
        });
        containerStatuses.map(function(status) {
            var name = nvl(status['name']);
            if ("" === name) {
                return;
            }
            tempArr = Object.keys(status['state']);
            if (tempArr.length > 0)
                containerMap[name]['state'] = tempArr[0].charAt(0).toUpperCase() + tempArr[0].substring(1);
            else
                containerMap[name]['state'] = podPhase.charAt(0).toUpperCase() + podPhase.substring(1);

            containerMap[name]['restartCount'] = status.restartCount;
            containerMap[name]['ready'] = status.ready;
        });

        return containerMap;
    };

    // CREATE CONTAINERS RESULT AREA CONTENT
    var createContainerResultArea = function(status, containers) {
        var resultArea = $('#containersResultArea');
        var resultHeaderArea = $('#containersResultHeaderArea');
        var noResultArea = $('#noContainersResultArea');

        var containerMap = getContainerMap(containers, status.containerStatuses, status.phase);
        var listLength = containers.length;

        var detailForm = $('#containerForm').clone().removeAttr('id');
        $('#containerForm').remove();

        $.each(Object.keys(containerMap), function(index, item) {
            var container = containerMap[item];

            var detailTable = detailForm.clone().wrapAll("<div/>");
            detailTable.find('[name=cName]').html(container.name);
            detailTable.find('[name=cImage]').html(container.image);
            detailTable.find('[name=cEnv]').html(envParser(container));
            detailTable.find('[name=cCmd]').html(nvl(container.command, "-"));
            detailTable.find('[name=cArgs]').html(nvl(container.args, "-"));

            resultArea.append(
                // container short-info
                '<tr>'
                + '<td><a href="javascript:void(0);" onclick="showHide(\'container-' + index + '\');">' + container.name + '</a></td>'
                + '<td><span>' + nvl(container.state, "Unknown") + '</span></td>'
                + '<td><span>' + nvl(container.image, "-") + '</span></td>'
                + '<td>' + nvl(container.restartCount, "-") + '</td>'
                + '</tr>'
                // container detail info
                + '<tr style="display:none;" id="container-' + index + '"><td colspan="4">'
                + detailTable.parent().html()
                + '</td></tr>');
        });

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
        }

        // TOOL TIP
        procSetToolTipForTableTd('containersResultArea');
        $('[data-toggle="tooltip"]').tooltip();
    };

    // CONTAINER ENVIRONMENT VARIABLE PARSER
    var envParser = function(container) {
        if (container.env == null) {
            return "-";
        }

        var envs = container.env;
        var tempStr = "";

        for (var i = 0; i < envs.length; i++) {
            if ("" !== tempStr) {
                tempStr += '<br>';
            }

            if (Object.keys(envs[i]).indexOf('valueFrom') > -1) {
                var valueFrom = envs[i]['valueFrom'];
                if (null == valueFrom['fieldRef']) {
                    tempStr += (Object.values(envs[i])[0] + ":&nbsp;" + JSON.stringify(valueFrom));
                } else {
                    tempStr += (Object.values(envs[i])[0] + ":&nbsp;" + JSON.stringify(valueFrom['fieldRef']));
                }
            } else {
                tempStr += (Object.values(envs[i])[0] + ":&nbsp;" + Object.values(envs[i])[1]);
            }
        }

        return tempStr;
    };

    // SHOW/HIDE ACTION FOR CONTAINER TABLE
    var showHide = function(indexId) {
        var tr = $('#' + indexId);

        if (tr.is(":visible")) {
            tr.css('display', 'none');
        } else {
            tr.css('display', 'table-row');
        }
    };

    // CONTENT SETTING FOR POP-UP MODAL
    var setLayerpop = function(eventElement) {
        var select = $(eventElement);
        var title = select.data('title');
        if (title instanceof Object) {
            title = JSON.stringify(title);
        }

        var content = select.data('content');
        if (content instanceof Object) {
            content = '<p>' + JSON.stringify(content) + '</p>';
        } else {
            content = '<p>' + content + '</p>';
        }

        $('.modal-title').html(title);
        $('.modal-body').html(content);
    };
</script>
