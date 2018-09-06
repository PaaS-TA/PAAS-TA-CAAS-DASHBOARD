<%--
  Deployment main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>

<div class="content">
    <h1 class="view-title"><span class="green2"><i class="fas fa-check-circle"></i></span> <c:out value="${deploymentsName}"/></h1>
    <div class="cluster_tabs clearfix">
        <ul>
            <li name="tab01" class="cluster_tabs_on">Details</li>
            <li name="tab02" class="cluster_tabs_right" onclick='movePage("events");'>Events</li>
            <li name="tab03" class="cluster_tabs_right yamlTab" onclick='movePage("yaml");'>YAML</li>
        </ul>
        <div class="cluster_tabs_line"></div>
    </div>
    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <!-- TODO : 그래프 구현필요 -->
            <!-- 그래프 시작 -->
            <%--<li class="cluster_first_box">
                <div class="graph-legend-wrap clearfix">
                    <ul class="graph-legend">
                        <li rel="current" class="on">현재</li>
                        <li rel="1h">1시간</li>
                        <li rel="6h">6시간</li>
                        <li rel="1d">1일</li>
                        <li rel="7d">7일</li>
                        <li rel="30d">30일</li>
                    </ul>
                </div>
                <div class="graph-nodes">
                    <div class="graph-tit-wrap">
                        <p class="graph-tit">
                            CPU<br/>
                            현재 사용량
                        </p>
                        <p class="graph-rate tit-color1">
                            <span>60</span>%
                        </p>
                    </div>
                    <div class="graph-cnt">
                        <div id="areachartcpu" style="min-width: 250px; height: 170px; margin: 0 auto"></div>
                    </div>
                </div>
                <div class="graph-nodes">
                    <div class="graph-tit-wrap">
                        <p class="graph-tit">
                            메모리<br/>
                            현재 사용량
                        </p>
                        <p class="graph-rate tit-color2">
                            <span>60</span>%
                        </p>
                    </div>
                    <div class="graph-cnt">
                        <div id="areachartmem" style="min-width: 250px; height: 170px; margin: 0 auto"></div>
                    </div>
                </div>
                <div class="graph-nodes">
                    <div class="graph-tit-wrap">
                        <p class="graph-tit">
                            디스크<br/>
                            현재 사용량
                        </p>
                        <p class="graph-rate tit-color3">
                            <span>60</span>%
                        </p>
                    </div>
                    <div class="graph-cnt">
                        <div id="areachartdisk" style="min-width: 250px; height: 170px; margin: 0 auto"></div>
                    </div>
                </div>
            </li>--%>
            <!-- 그래프 끝 -->
            <!-- Details 시작 -->
            <li class="cluster_second_box">
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
                                <th><i class="cWrapDot"></i> Namespace</th>
                                <td id="namespaceID"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Labels</th>
                                <td id="labels"></td>
                            </tr>

                            <tr>
                                <th><i class="cWrapDot"></i> Annotations</th>
                                <td id="annotations">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Creation Time</th>
                                <td id="creationTime"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Selector</th>
                                <td id="selector"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Strategy</th>
                                <td id="strategy"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Min ready seconds</th>
                                <td id="minReadySeconds"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Revision history limit</th>
                                <td id="revisionHistoryLimit"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Rolling update strategy</th>
                                <td id="rollingUpdateStrategy"></td>
                            </tr>
                            <tr>
                                <th><i class="cWrapDot"></i> Status</th>
                                <td id="status"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Details 끝 -->
            <!-- Replica Set 시작 -->
            <li class="cluster_third_box">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Replica Set</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL" id="replicasetsResultTable">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:15%;'>
                                <col style='width:5%;'>
                                <col style='width:15%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noReplicasetsResultArea" style="display: none;"><td colspan='6'><p class='service_p'>조회 된 ReplicaSets가 없습니다.</p></td></tr>
                            <tr id="replicasetsResultHeaderArea">
                                <td>Name
                                    <button sort-key="replicasets-name" class="sort-arrow sort" onclick="procSetSortList('replicasetsResultTable', this, '0')"><i class="fas fa-caret-down"></i></button>
                                </td>
                                <td>Namespace</td>
                                <td>Labels</td>
                                <td id="replicaPods">Pods</td>
                                <td id="replicaImages">Images</td>
                                <td id="replicaCreationTime">Created on
                                    <button sort-key="replica-created-on" class="sort-arrow sort" onclick="procSetSortList('replicasetsResultTable', this, '6')"><i class="fas fa-caret-down"></i></button>
                                </td>
                            </tr>
                            </thead>
                            <tbody id="replicaSetTable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Pods 시작 -->
            <li class="cluster_sixth_box maB50">
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Pods</p>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL" id="podsResultTable">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:15%;'>
                                <col style='width:15%;'>
                                <col style='width:8%;'>
                                <col style='width:8%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noPodsResultArea" style="display: none;"><td colspan='6'><p class='service_p'>조회 된 Pods가 없습니다.</p></td></tr>
                            <tr id="podsResultHeaderArea">
                                <td>Name
                                    <button class="sort-arrow"><i class="fas fa-caret-down" onclick="procSetSortList('replicasetsResultTable', this, '0')"></i></button>
                                </td>
                                <td>Namespace</td>
                                <td>Node</td>
                                <td>Status</td>
                                <td>Restarts</td>
                                <td>Created on
                                    <button class="sort-arrow"><i class="fas fa-caret-down" onclick="procSetSortList('replicasetsResultTable', this, '5')"></i></button>
                                </td>
                            </tr>
                            </thead>
                            <tbody id="podsListTable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Pods 끝 -->
        </ul>
    </div>
    <!-- Details  끝 -->
</div>
<!-- modal -->
<div class="modal fade dashboard" id="layerpop">
    <div class="vertical-alignment-helper">
        <div class="modal-dialog vertical-align-center">
            <div class="modal-content">
                <!-- header -->
                <div class="modal-header">
                    <!-- 닫기(x) 버튼 -->
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <!-- header title -->
                    <h4 class="modal-title">kubectl.kubernetes.io/last-applied-configuration</h4>
                </div>
                <!-- body -->
                <div class="modal-body">
                    <p>
                        {"apiVersion":"extensions/v1beta1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"hrjin-spring-music"},"name":"hrjin-spring-music","namespace":"default"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"hrjin-spring-music"}},"template":{"metadata":{"labels":{"app":"hrjin-spring-music"}},"spec":{"automountServiceAccountToken":true,"containers":[{"image":"bluedigm/hrjin-music:0.3","imagePullPolicy":"Always","name":"hrjin-spring-music-container","ports":[{"containerPort":7878}]}],"serviceAccountName":"hrjin-sa4"}}}}
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<%--<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>--%>

<input type="hidden" id="requestDeploymentsName" name="requestDeploymentsName" value="<c:out value='${deploymentsName}' default='' />" />

<!-- SyntexHighlighter -->
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shCore.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushCpp.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushCSharp.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/yaml/scripts/shBrushPython.js"/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shCore.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/yaml/styles/shThemeDefault.css"/>">

<script type="text/javascript">
    SyntaxHighlighter.defaults['quick-code'] = false;
    SyntaxHighlighter.all();
</script>

<style>
    .syntaxhighlighter .gutter .line {
        border-right-color: #ddd !important;
    }
</style>
<!-- SyntexHighlighter -->

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function () {
/*        createChart("current", "cpu");
        createChart("current", "mem");
        createChart("current", "disk");*/
    });
</script>

<script type="text/javascript">
    var deployName = '<c:out value="${deploymentsName}"/>';
    console.log(deployName);
    $(document.body).ready(function () {
        var URL = "/workloads/deployments/" + NAME_SPACE + "/getDeployment.do";
        console.log("window.location.href ", window.location.href);
        var param = {
            name: deployName
        }
        procCallAjax(URL, "GET", param, null, callbackGetDeployment);
    });

    var stringifyJSON = function (obj) {
        return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
    }

    var callbackGetDeployment = function (data) {
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#resultArea').html(
                "ResultStatus :: " + data.resultCode + " <br><br>"
                + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var htmlString = [];
        htmlString.push("DEPLOYMENTS LIST :: <br><br>");
        htmlString.push("ResultCode :: " + data.resultCode + " || "
            + "Message :: " + data.resultMessage + " <br><br>");

        // get data
        var _metadata = data.metadata;
        var _spec = data.spec;
        var _status = data.status;

        /* Deployment detail is under...
         * - name
         * - namespace
         * - labels
         * - annotations
         * - creation time
         * - selector
         * - strategy (Pod deploy strategy)
         * - min ready seconds
         * - revision history limit
         * - Rolling update strategy detail (maxSurge, maxUnavailable)
         * - Replica status (updated, total, available, unavailable)
         */
        var deployName = _metadata.name;
        var namespace = NAME_SPACE;
        var labels = stringifyJSON(_metadata.labels).replace(/,/g, ', ');  //.replace(/=/g, ':')
        var annotations = _metadata.annotations;
        var creationTimestamp = _metadata.creationTimestamp;

        var selector = stringifyJSON(_spec.selector).replace(/matchLabels=/g, '');;
        var strategy = _spec.strategy.type;
        var minReadySeconds = _spec.minReadySeconds;
        var revisionHistoryLimit = _spec.revisionHistoryLimit;
        var rollingUpdateStrategy =
            "Max surge: " + _spec.strategy.rollingUpdate.maxSurge + ", "
            + "Max unavailable: " + _spec.strategy.rollingUpdate.maxUnavailable;
        var images = _spec.images;

        var updatedReplicas = _status.updatedReplicas;
        var totalReplicas = _status.replicas;
        var availableReplicas = _status.availableReplicas;
        var unavailableReplicas = _status.unavailableReplicas;
        var replicaStatus = updatedReplicas + " updated, "
            + totalReplicas + " total, "
            + availableReplicas + " available, "
            + unavailableReplicas + " unavailable.";

        document.getElementById("name").textContent = deployName;
        document.getElementById("namespaceID").textContent = namespace;
        document.getElementById("labels").innerHTML = createSpans(labels, "false");
        document.getElementById("annotations").innerHTML = createAnnotations(annotations);
        document.getElementById("creationTime").textContent = creationTimestamp;
        document.getElementById("selector").innerHTML = createSpans(selector, "false");
        document.getElementById("strategy").textContent = strategy;
        document.getElementById("minReadySeconds").textContent = minReadySeconds;
        document.getElementById("revisionHistoryLimit").textContent = revisionHistoryLimit;
        document.getElementById("rollingUpdateStrategy").textContent = rollingUpdateStrategy;
        document.getElementById("status").textContent = replicaStatus;

        procCallAjax("/api/namespaces/" + NAME_SPACE + "/replicasets/resource/" + replaceLabels(labels), "GET", null, null, callbackGetReplicasetList);
        procCallAjax("/api/workloads/namespaces/" + NAME_SPACE + "/pods/resource/" + replaceLabels(labels), "GET", null, null, callbackGetPodsList);
    }


    var replaceLabels = function (data) {
        return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D');
    }

    var createSpans = function (data, type) {
        var datas = data.replace(/=/g, ':').split(',');
        var spanTemplate = "";

        if (type === "true") {
            $.each(datas, function (index, data) {
                spanTemplate += '<span class="bg_gray">' + data + '</span>';
                if (datas.length > 1) {
                    spanTemplate += '<br>';
                }
            });
        } else {
            $.each(datas, function (index, data) {
                spanTemplate += '<span class="bg_gray">' + data + '</span> ';
            });
        }

        return spanTemplate;
    }


    // CALLBACK
    var callbackGetReplicasetList = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var resultArea = $('#replicaSetTable');
        var resultHeaderArea = $('#replicasetsResultHeaderArea');
        var noResultArea = $('#noReplicasetsResultArea');
        var resultTable = $('#replicasetsResultTable');

        var listLength = data.items.length;

        //-- Replica Set List
        //items
        //metadata.name
        //metadata.namespace
        //metadata.labels
        //status.replicas
        //metadata.creationTimestamp
        //spec.containers.image

        $.each(data.items, function (index, itemList) {

            var replicasetName = itemList.metadata.name;
            var namespace = NAME_SPACE;
            var labels = JSON.stringify(itemList.metadata.labels).replace(/["{}]/g, '').replace(/:/g, '=');
            var creationTimestamp = itemList.metadata.creationTimestamp;
            var replicas = itemList.status.replicas;   //  TOBE ::  current / desired
            var availableReplicas;
            if ( !itemList.status.availableReplicas ) {
                availableReplicas = 0;
            } else {
                availableReplicas = itemList.status.availableReplicas;
            }

            var images = new Array;

            var containers = itemList.spec.template.spec.containers;
            for (var i = 0; i < containers.length; i++) {
                images.push(containers[i].image);
            }

            resultArea.append('<tr>' +
                                    '<td>' +
                                        "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/workloads/replicasets/" + replicasetName + "\");'>"+
                                            '<span class="green2"><i class="fas fa-check-circle"></i></span> ' + replicasetName +
                                        '</a>' +
                                    '</td>' +
                                    '<td>' + namespace + '</td>' +
                                    '<td>' + createSpans(labels, "true") + '</td>' +
                                    '<td>' + availableReplicas + " / " + replicas + '</td>' +
                                    '<td>' + images + '</td>' +
                                    '<td>' + creationTimestamp + '</td>' +
                                '</tr>' );



        });

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultTable.tablesorter();
            resultTable.trigger("update");
        }

    };


    var callbackGetPodsList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultCode) {
            $('#podsListTable').html(
                "ResultStatus :: " + data.resultCode + " <br><br>"
                + "ResultMessage :: " + data.resultMessage + " <br><br>");
            return false;
        }

        console.log("CONSOLE DEBUG PRINT :: " + data);

        var resultArea = $('#podsListTable');
        var resultHeaderArea = $('#podsResultHeaderArea');
        var noResultArea = $('#noPodsResultArea');
        var resultTable = $('#podsResultTable');
        var listLength = data.items.length;

        $.each(data.items, function (index, itemList) {
            // get data
            var _metadata = itemList.metadata;
            var _spec = itemList.spec;
            var _status = itemList.status;

            // required : name, namespace, node, status, restart(count), created on, pod error message(when it exists)
            var podName = _metadata.name;
            var namespace = NAME_SPACE;
            var nodeName = _spec.nodeName;
            var podStatus = _status.phase;
            var restartCount = procIfDataIsNull(_status.containerStatuses,
                function (data) {
                    return data.reduce(function (a, b) {
                        return {restartCount: a.restartCount + b.restartCount};
                    }, {restartCount: 0}).restartCount;
                }, 0);
            //var restartCount = _status.containerStatuses
            //  .map(function(datum) { return datum.restartCount; })
            //  .reduce(function(a, b) { return a + b; }, 0 );

            var creationTimestamp = _metadata.creationTimestamp;
            // error message will be filtering from namespace's event. a variable value is like...
            //var errorMessage = _status.error.message;
            var errorMessage = "";

            resultArea.append('<tr>' +
                                '<td>' + podName + '</td>' +
                                '<td>' + namespace + '</td>' +
                                '<td>' + nodeName + '</td>' +
                                '<td>' + podStatus + '</td>' +
                                '<td>' + restartCount + '</td>' +
                                '<td>' + creationTimestamp + '</td>' +
                            '</tr>');

        });

        if (listLength < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.show();
            resultTable.tablesorter();
            resultTable.trigger("update");
        }

    };

    //3개 일때는 동작하지 않는드아!
    var createAnnotations = function (annotations) {
        var tempStr = "";
        var index = 0;
        Object.keys(annotations).forEach(function (key) {
            console.log("하이~ 콘니치와!! ", key);
            console.log("하이~ 콘니치와!!난데? ", index);
            if(index == 0) {
                console.log("와라에루 요나 ", key);
                tempStr += createSpans(key + ":"+ annotations[key]);
            } else {
                tempStr += '<span class="bg_blue"><a href="#" data-target="#layerpop" data-toggle="modal">' + key + '</a></span>';
                $("#modal-body").innerHTML = '<p>' + annotations[key] + '</p> ';
            }
            console.log("소레오 코에루!", tempStr);
            index ++;
        });
        return tempStr;
    };


    // BIND
    $("#btnReset").on("click", function () {
        $('#resultArea').html("");
    });

    // ALREADY READY STATE
    $(document).ready(function () {
        $("#btnSearch").on("click", function (e) {
            getDeployments();
        });
    });

    // ON LOAD
    $(document.body).ready(function () {
        // getAllDeployments();
    });

    // MOVE PAGE
    var movePage = function(requestPage) {
        var reqUrl = '<%= Constants.CAAS_BASE_URL %><%= Constants.API_WORKLOAD %>/deployments/' + document.getElementById('requestDeploymentsName').value;
        if (requestPage.indexOf('detail') < 0) {
            reqUrl += '/' + requestPage;
        }

        procMovePage(reqUrl);
    };
</script>
