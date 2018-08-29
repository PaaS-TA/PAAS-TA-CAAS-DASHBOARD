<%@ page import="org.paasta.caas.dashboard.common.Constants" %><%--
  Created by IntelliJ IDEA.
  User: hgcho
  Date: 2018-08-27
  Time: 오후 5:26
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <%@include file="tab.jsp" %>
    <!-- Nodes 시작 -->
    <div class="cluster_content03 row two_line two_view">
        <ul class="maT30">
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Nodes</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search"
                                       placeholder="search"/>
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="view_table_wrap">
                        <table id="clusters_nodes_table" class="table_event condition alignL">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:5%;'>
                                <col style='width:10%;'>
                                <col style='width:10%;'>
                                <col style='width:12%;'>
                                <col style='width:12%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr>
                                <td>Name
                                    <button sort-key="node-name" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>
                                </td>
                                <td>Ready</td>
                                <td>CPU requests</td>
                                <td>CPU limits</td>
                                <td>Memory requests</td>
                                <td>Memory limits</td>
                                <td>Created on
                                    <button sort-key="created-on" class="sort-arrow sort"><i class="fas fa-caret-down"></i></button>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- nodes contents start -->
                            <!-- TODO :: REMOVE EXAMPLE -->
                            <tr node-name="ip-172-31-20-237" created-on="2018-07-09 18:31:01">
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                        href="caas_nodes_view.html">ip-172-31-20-237</a></td>
                                <td>True</td>
                                <td>831 mCPU</td>
                                <td>940 mCPU</td>
                                <td>931.95 MB</td>
                                <td>2.77 GB</td>
                                <td>2018-07-09 18:31:01</td>
                            </tr>
                            <tr node-name="ip-172-31-21-17" created-on="2018-07-10 05:31:01">
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                        href="caas_nodes_view.html">ip-172-31-21-17</a></td>
                                <td>True</td>
                                <td>831 mCPU</td>
                                <td>940 mCPU</td>
                                <td>931.95 MB</td>
                                <td>2.77 GB</td>
                                <td>2018-07-10 05:31:01</td>
                            </tr>
                            <tr node-name="ip-172-31-11-184" created-on="2018-07-10 05:31:17">
                                <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
                                        href="caas_nodes_view.html">ip-172-31-11-184</a></td>
                                <td>True</td>
                                <td>831 mCPU</td>
                                <td>940 mCPU</td>
                                <td>931.95 MB</td>
                                <td>2.77 GB</td>
                                <td>2018-07-10 05:31:17</td>
                            </tr>
                            <!-- nodes contents end -->
                            </tbody>
                            <!--tfoot>
                            <tr>
                            <td colspan="6">
                                    <button class="btns2 btns2_1 colors4 event_btns">더보기</button>
                                    </td>
                                    </tr>
                                    </tfoot-->
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Nodes 끝 -->
</div>
<script type="text/javascript">
    function getNodes() {
        var reqUrl = "<%= Constants.API_URL %>/nodes"
        procCallAjax(reqUrl, "GET", null, null, callbackGetListNodes);
    }

    // CALLBACK
    var callbackGetListNodes = function(data) {
        if (false == checkValidData(data)) {
            alert("Cannot load nodes data");
            return;
        }

        /*
<tr>
    <td><span class="green2"><i class="fas fa-check-circle"></i></span> <a
            href="caas_nodes_view.html">ip-172-31-20-237</a></td>
    <td>True</td>
    <td>831 mCPU</td>
    <td>940 mCPU</td>
    <td>931.95 MB</td>
    <td>2.77 GB</td>
    <td>2018-07-09 18:31:01</td>
</tr>
     */
        var contents = [];
        $.each(data.items, function (index, nodeItem) {
            let _metadata = itemList.metadata;
            let _status = itemList.status;

            let name = _metadata.name;
            let ready = _status.conditions.filter(function(condition) {
                return condition.type === "Ready";
            })[0].status;
            let limitCPU = _status.capacity.cpu;
            let requestCPU = limitCPU - _status.allocatable.cpu;
            let limitMemory = convertByte(_status.capacity.memory);
            let requestMemory = limitMemory - convertByte(_status.allocatable.memory);
            let creationTimestamp = _metadata.creationTimestamp;

            // TODO
            let nameHtml = '<span class=';
        });

        // get data
        $.each(data.items, function(index, itemList) {


            // htmlString push
            htmlString.push("Name :: " + name + " || "
                + "Ready :: " + ready + " || "
                + "Request CPU :: " + requestCPU + " || "
                + "Limit CPU :: " + limitCPU + " || "
                + "Request Memory :: " + formatCapacity(requestMemory, "Mi") + " || "
                + "Limit Memory :: " + formatCapacity(limitMemory, "Mi") + " || "
                + "CreationTimestamp :: " + creationTimestamp + "<br><br>" );
        });

        // finally
        $('#resultArea').html(htmlString);
    }

    $(document.body).ready(function(){
        // default sort : node name
        sortTable("clusters_nodes_table", "node-name", true);
    });
</script>
<!-- Nodes 끝 -->