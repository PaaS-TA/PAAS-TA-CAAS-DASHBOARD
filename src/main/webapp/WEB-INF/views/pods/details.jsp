<%--
  Deployments main
  @author Hyungu Cho
  @version 1.0
  @since 2018.08.14
--%>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="content">
    <jsp:include page="common-pods.jsp" flush="true"/>

    <%-- NODES HEADER INCLUDE --%>
    <jsp:include page="../common/contents-tab.jsp" flush="true"/>

    <!-- Details 시작-->
    <div class="cluster_content01 row two_line two_view harf_view">
        <ul class="maT30">
            <%-- TODO :: CHANGE GRAPH --%>
            <%--
            <!-- 그래프 시작 -->
            <li class="cluster_first_box">
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
            </li>
            <!-- 그래프 끝 -->
            --%>
            <!-- Details 시작 -->
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
                                <td id="labels"></td>
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
                            <tbody id="resultArea">
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
            <!-- Containers 끝 -->
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
                    <h4 class="modal-title">Auto- Scaling  설정</h4>
                </div>
                <!-- body -->
                <div class="modal-body">
                    <div class="modal-bg">
                        <span>
                            앱 이름
                        </span>
                        <div class="pull-right">
                            <input id="check1" checked="checked" type="checkbox" />
                            <label for="check1">자동확장 시</label>
                            <input id="check2" type="checkbox" />
                            <label for="check2">자동축소 사용</label>
                        </div>
                    </div>
                    <div class="">
                        <table class="modal_t">
                            <colgroup>
                                <col style='width: 123px;'>
                                <col style='width:40px;'>
                                <col>
                                <col style='width:50px;'>
                                <col style='width:40px;'>
                                <col>
                                <col style='width:20px;'>
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>인스턴스 수 설정
                                </th>
                                <td>최소</td>
                                <td>
                                    <div>
                                        <input type="text" value="1" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                <td><p>개</p>
                                </td>
                                </td>
                                <td>최대</td>
                                <td>
                                    <div>
                                        <input type="text" value="10" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                </td>
                                <td><p>개</p>
                                </td>
                            </tr>
                            <tr>
                                <th>CPU 임계 값 설정
                                </th>
                                <td>최소</td>
                                <td>
                                    <div>
                                        <input type="text" value="20"/>
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                <td><p>%</p>
                                </td>
                                </td>
                                <td>최대</td>
                                <td>
                                    <div>
                                        <input type="text" value="80" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                </td>
                                <td><p>%</p>
                                </td>
                            </tr>
                            <tr>
                                <th>메모리 사이즈 설정
                                </th>
                                <td>최소</td>
                                <td>
                                    <div>
                                        <input type="text" value="256" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                <td><p>MB</p>
                                </td>
                                </td>
                                <td>최대</td>
                                <td>
                                    <div>
                                        <input type="text" value="2048" />
                                        <button><i class="fas fa-sort-up"></i>
                                        </button>
                                        <button><i class="fas fa-sort-down"></i>
                                        </button>
                                    </div>
                                </td>
                                <td><p>MB</p>
                                </td>
                            </tr>
                            <tr>
                                <th>시간 설정</th>
                                <td> </td>
                                <td>
                                    <input class="time_left" type="text" value="10" />
                                </td>
                                <td> </td>
                                <td> </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btns2 colors4 pull-left" data-dismiss="modal">삭제</button>
                    <button type="button" class="btns2 colors4" data-dismiss="modal">변경</button>
                    <button type="button" class="btns2 colors5" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%--TODO : REMOVE--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/highcharts.js"/>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/resources/js/data.js"/>'></script>--%>

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function () {
        viewLoading('show');
        getDetail();
        viewLoading('hide');
    });

    // GET DETAIL
    var getDetail = function() {
        var reqUrl = "<%= Constants.API_URL %><%= Constants.API_WORKLOAD %>/namespaces/" + NAME_SPACE + "/pods/" + G_POD_NAME;
        procCallAjax(reqUrl, "GET", null, null, callbackGetDetail);
    };

    // CALLBACK
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

        if(data.spec.nodeName == null) {
            document.getElementById("node").innerHTML =  "-";
        }

        if(data.spec.nodeName != null) {
            document.getElementById("node").innerHTML =  "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/clusters/nodes/" + data.spec.nodeName + "/summary\");'>"+
                data.spec.nodeName +
                '</a>';
        }

        document.getElementById("ip").textContent =  nvl(data.status.podIP, "-");

        if(labels.match('job-name')) {
            // jobs 기능이 구현되면 여기에 a링크 달 것
            document.getElementById("controllers").innerHTML = data.metadata.ownerReferences[0].name;
        } else {
            document.getElementById("controllers").innerHTML = "<a href='javascript:void(0);' onclick='procMovePage(\"/caas/workloads/replicaSets/" + data.metadata.ownerReferences[0].name + "\");'>"+
                data.metadata.ownerReferences[0].name +
                '</a>';
        }
        document.getElementById("volumes").textContent = data.spec.volumes[0].name;

        createContainerResultArea(data.status, data.spec.containers);

        viewLoading('hide');
    };

    var replaceLabels = function (data) {
        return JSON.stringify(data).replace(/"/g, '').replace(/=/g, '%3D').replace(/, /g, '&');
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
    
    var conditionParser = function (data) {
        var tempStr = "";
        for ( var index in data) {
            tempStr += data[index].type + ": " + data[index].status;
            if((data.length -1) == index) {
                break;
            }
            tempStr += ", ";
        }
        return tempStr;
    }

    // 좀 더 좋은 로직 있으면 수정바람...
    // statuses와 container 비교하는 구문..
    var createContainerResultArea = function (status, containers) {
        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#containersResultHeaderArea');
        var noResultArea = $('#noContainersResultArea');

        var listLength;
        var containerStatuses = status.containerStatuses;

        listLength = containers.length;

        $.each(containers, function (index, itemList) {
            var containerStatusStr = '';
            var _status = getContainerStatus(getContainer(containerStatuses, itemList.name), status.phase);
            if (_status.includes("Running")) {
                containerStatusStr += '<span class="green2"><i class="fas fa-check-circle"></i></span>';
            } else if (_status.includes("Waiting")) {
                containerStatusStr += '<span class="red2"><i class="fas fa-exclamation-triangle"></i></span>';
            } else {
                containerStatusStr += '<span><i class="fas fa-check-circle"></i></span>';
            }
            containerStatusStr += (' ' + _status);

            resultArea.append('<tr>' +
                                '<td>' +
                                    "<a href='javascript:void(0);' onclick='showHide(" + index + ");\'>"+
                                        itemList.name +
                                    '</a>' +
                                '</td>' +
                                '<td>' + containerStatusStr + '</td>' +
                                '<td>' + itemList.image + '</td>' +
                                '<td>' + nvl(getContainer(containerStatuses, itemList.name).restartCount, "-") + '</td>' +
                              '</tr>' +
                              '<tr style="display:none;" id="' + index +'">' +
                                '<td colspan="4">' +
                                    '<table class="table_detail alignL">' +
                                        '<colgroup>' +
                                            '<col style="*">' +
                                            '<col style="*">' +
                                        '</colgroup>' +
                                        '<tbody>' +
                                            '<tr>' +
                                                '<td>Name</td>' +
                                                '<td>' + itemList.name + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td>Image</td>' +
                                                '<td>' + itemList.image + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td>Environment variables</td>' +
                                                '<td>' + envParser(getContainer(containers, itemList.name)) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td>Commands</td>' +
                                                '<td>' + nvl(getContainer(containers, itemList.name).command, "-") + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td>Args</td>' +
                                                '<td>' + nvl(getContainer(containers, itemList.name).args, "-")  + '</td>' +
                                            '</tr>' +
                                            '</tbody>' +
                                    '</table>' +
                                '</td>' +
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
            resultArea.tablesorter();
            resultArea.trigger("update");
        }

    }

    var getContainer = function (containerList, conatinerName) {

        if(!containerList) {
            return "";
        }
        var containerObject;

        for(var index =0; index < containerList.length; index ++) {
            if(containerList[index].name == conatinerName) {
                containerObject = containerList[index];
                return containerObject;
            }
        }
    }

    // 줄일 수 있으면 수정바라뮤ㅠㅠ 재귀를 쓸 타이밍인가;;
    var envParser = function (container) {
        var tempStr = "";
        if(container.env == null) {
            return tempStr = "-";
        }
        var envs = container.env;

        for( var key in envs ) {
            if(key != 0 ) {
                tempStr += '<br>';
            }

            if(Object.keys(envs[key])[1] == 'valueFrom') {
                var testObject = Object.values(envs[key])[1];
                var fieldRef = Object.values(testObject)[0];
                Object.keys(fieldRef).forEach(function (key) {
                    tempStr += fieldRef[key] + " &nbsp;";
                });
            } else {
                tempStr +=  Object.values(envs[key])[0]  + ":&nbsp;" + Object.values(envs[key])[1];
            }
        }
        return tempStr;
    }

    // state를 가져오기 위함.. state정보는 statuses에 있는데.. run된 흔적이 없으면 이게 null로 들어옴...
    var getContainerStatus = function (itemList, phase) {
        var statusStr = "";
        if( !itemList ) {
            statusStr = phase;
        } else {
            statusStr = Object.keys(itemList.state)[0];
        }

        return statusStr.charAt(0).toUpperCase() + statusStr.substring(1);
    }

    var showHide = function (indexId) {
        var tr = $('#' + indexId);

        if (tr.is(":visible")) {
            tr.css('display', 'none');
        } else {
            tr.css('display', 'table-row');
        }
    }

</script>
