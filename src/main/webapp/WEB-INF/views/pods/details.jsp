<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="content">
    <jsp:include page="commonPods.jsp" flush="true"/>

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
            alertMessage(nvl(data.resultMessage, "Pod 정보를 가져오지 못했습니다."), false);
            return;
        }

        var labelKeys = Object.keys(data.metadata.labels);
        for (var i = 0; i < labelKeys.length; i++) {
            // convert raw character of comma and quota to html symbol
            data.metadata.labels[labelKeys[i]] =
                data.metadata.labels[labelKeys[i]].replace(/,/g, '&comma;').replace(/"/g, '&quot;')
                    .replace(/{/g, '&lbrace;').replace(/}/g, '&rbrace;').replace(/:/g, '&colon;');
        }

        var labels = procSetSelector(data.metadata.labels);
        var conditionStr = '';
        for (var i = 0; i < data.length; i++) {
            if (i > 0) {
                conditionStr += ", ";
            }
            conditionStr += (data[i].type + ": " + data[i].status);
        }

        $("#name").html(data.metadata.name);
        $("#labels").html(createSpans(labels, "NOT_LB"));
        $("#creationTime").html(data.metadata.creationTimestamp);
        $("#status").html(data.status.phase);
        $("#qosClass").html(data.status.qosClass);
        $("#conditions").html(conditionStr);

        if ('' === nvl(data.spec.nodeName)) {
            $("#node").html("-");
        }  else {
            $("#node").html("<a href='javascript:void(0);' " +
                "onclick='procMovePage(\"<%= Constants.URI_CLUSTER_NODES %>/" + data.spec.nodeName + "/summary\");'>"
                + data.spec.nodeName + '</a>');
        }

        $("#ip").html(nvl(data.status.podIP, "-"));

        if (labels.match('job-name')) {
            // A tag position for Jobs detail page
            $("#controllers").html(data.metadata.ownerReferences[0].name);
        } else {
            $("#controllers").html("<a href='javascript:void(0);' "
                + "onclick='procMovePage(\"/caas/workloads/replicaSets/" + data.metadata.ownerReferences[0].name + "\");'>"
                + data.metadata.ownerReferences[0].name + '</a>');
        }

        $("#volumes").textContent = data.spec.volumes[0].name;

        createContainerResultArea(data.status, data.spec.containers);

        viewLoading('hide');
    };

    // CREATE SPANS FOR LABELS
    var createSpans = function(data, type) {
        // After run procCreateSpans, If some of span html are JSON Object or JSON Array value,
        // it adds layer-pop action and related event.

        var defaultSpanHtml = procCreateSpans(data, type);
        if ('-' === defaultSpanHtml) {
            return '-';
        }

        var spans = defaultSpanHtml.split('</span> ');

        var spanStr,
            spanData,
            separatorIndex,
            key,
            value,
            newSpanStr;

        for (var index = 0; index < spans.length; index++) {
            spanStr = spans[index];
            spanData = spanStr.replace('<span class="bg_gray">', '');
            separatorIndex = spanData.indexOf(':');
            if ('' === spanData || '' === spanData.replace(/ /g, '') || separatorIndex < 0) {
                spans[index] += spanStr + '</span> ';
                continue;
            }

            key = spanData.substring(0, separatorIndex);
            // try to convert html symbol to raw character of comma and quota
            value = spanData.substring(separatorIndex + 1);
            try {
                var type = typeof JSON.parse($('<p>' + value + '</p>').html());
                if ('object' === type) {
                    newSpanStr = '<span class="bg_blue" onclick="setLayerpop(this)" '
                        + 'data-target="#layerpop3" data-toggle="modal" data-title="' + key
                        + '" data-content="' + spanData.substring(separatorIndex + 1) + '">'
                        + '<a>' + key + '</a></span> ';
                } else {
                    newSpanStr = spanStr + '</span> ';
                }
            } catch (e) {
                // ignore exception
                newSpanStr = spanStr + '</span> ';
            }

            spans[index] = newSpanStr;
        }

        return spans.join('');
    };

    var upperCaseFirstLetterOnly = function(obj) {
        return (obj + '').charAt(0).toUpperCase() + (obj + '').substring(1);
    };

    // CREATE CONTAINER MAP (CONTAINER INFO + CONTAINER STATUS)
    var getContainerMap = function(containers, containerStatuses, podPhase) {
        var containerMap = {};
        var tempArr;
        containers.map(function(container) {
            var name = nvl(container['name']);
            if ("" !== name) {
                containerMap[name] = container;
            }
        });
        containerStatuses.map(function(status) {
            var name = nvl(status['name']);
            if ("" === name) {
                return;
            }
            tempArr = Object.keys(status['state']);
            if (tempArr.length > 0) {
                containerMap[name]['state'] = upperCaseFirstLetterOnly(tempArr[0]);
            } else {
                containerMap[name]['state'] = upperCaseFirstLetterOnly(podPhase);
            }

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
        var title = JSON.stringify( select.data('title') ).replace(/^"|"$/g, '');
        var content = JSON.stringify( select.data('content') ).replace(/^"|"$/g, '');

        $('.modal-title').html(title);
        $('.modal-body').html('<p>' + content + '</p>');
    };
</script>
