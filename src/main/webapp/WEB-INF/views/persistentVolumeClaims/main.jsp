<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2019-10-25
  Time: 오후 4:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.paasta.caas.dashboard.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="content">
    <div class="cluster_tabs clearfix"></div>
    <div class="cluster_content01 row two_line two_view">
        <ul>
            <li>
                <div class="sortable_wrap">
                    <div class="sortable_top">
                        <p>Volumes</p>
                        <ul class="colright_btn">
                            <li>
                                <input type="text" id="table-search-01" name="" class="table-search" placeholder="search" onkeypress="if(event.keyCode===13) {setList(this.value);}" maxlength="100" />
                                <button name="button" class="btn table-search-on" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="view_table_wrap">
                        <table class="table_event condition alignL service-lh" id="resultTable">
                            <colgroup>
                                <col style='width:auto;'>
                                <col style='width:10%;'>
                                <col style='width:35%;'>
                                <col style='width:15%;'>
                                <col style='width:20%;'>
                            </colgroup>
                            <thead>
                            <tr id="noResultArea"><td colspan='5'><p class='service_p'>생성한 Volume 이 없습니다.</p></td></tr>
                            <tr id="resultHeaderArea" class="headerSortFalse" style="display: none;">
                                <td>Name<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '0')"><i class="fas fa-caret-down"></i></button></td>
                                <td>Labels</td>
                                <td>Spec</td>
                                <td>Status</td>
                                <td>Created on<button class="sort-arrow" onclick="procSetSortList('resultTable', this, '4')"><i class="fas fa-caret-down"></i></button></td>
                            </tr>
                            </thead>
                            <tbody id="resultArea">
                            <tr>
                                <td colspan="5"> - </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>


<script type="text/javascript">

    var G_STORAGES_LIST;

    // GET LIST
    var getPersistentVolumeClaimsList = function () {
        procViewLoading('show');

        var reqUrl = "<%= Constants.API_URL %><%= Constants.URI_API_STORAGES_LIST %>"
            .replace("{namespace:.+}", NAME_SPACE);

        procCallAjax(reqUrl, "GET", null, null, callbackGetList);
    };

    // CALLBACK
    var callbackGetList = function (data) {
        if (!procCheckValidData(data)) {
            procViewLoading('hide');
            return false;
        }

        G_STORAGES_LIST = data;
        procViewLoading('hide');

        setList("");
    };

    // SET LIST
    var setList = function (searchKeyword) {
        procViewLoading('show');

        var resultArea = $('#resultArea');
        var resultHeaderArea = $('#resultHeaderArea');
        var noResultArea = $('#noResultArea');
        var resultTable = $('#resultTable');

        var itemsMetadata,
            itemsSpec,
            persistentVolumeClaimName,
            selector,
            namespace,
            specResources,
            itemStatus;

        var items = G_STORAGES_LIST.items;
        var listLength = items.length;
        var checkListCount = 0;
        var htmlString = [];

        for(var i = 0; i < listLength; i++) {
            itemsMetadata = items[i].metadata;
            itemsSpec = items[i].spec;
            persistentVolumeClaimName = itemsMetadata.name;
            itemStatus = items[i].status;

            if ((nvl(searchKeyword) === "") || persistentVolumeClaimName.indexOf(searchKeyword) > -1) {
                selector = procSetSelector(itemsSpec.selector);
                namespace = itemsMetadata.namespace;
                specResources = itemsSpec.resources;

                var capacity = "";

                if(itemStatus.capacity != null) {
                    capacity = itemStatus.capacity.storage;
                } else {
                    capacity = '-';
                }

                var specCollection = [];

                var accessModesList = [];
                for(var j = 0; j < itemsSpec.accessModes.length; j++) {
                    accessModesList.push(itemsSpec.accessModes[j]);
                }

                specCollection.push(
                    '<p> accessMode : ' + accessModesList + '</p>'
                    + '<p> capacity : ' + capacity + '</p>'
                    + '<p> volumeName : ' + nvl(itemsSpec.volumeName, '-') + '</p>'
                    + '<p> volumeMode : ' + nvl(itemsSpec.volumeMode, '-') + '</p>'
                    + '<p> storageClassName : ' + nvl(itemsSpec.storageClassName, '-') + '</p>'
                    + '<p> claimRef : ' + nvl(persistentVolumeClaimName, '-') + "(" + nvl(itemsSpec.resources.requests.storage, '-') + ")" + '</p>'
                );

                var statusIconHtml = "";

                if(itemStatus.phase === 'Bound') {
                    statusIconHtml = "<td><span class='green2'><i class='fas fa-check-circle'></i></span> ";
                } else {
                    statusIconHtml = "<td><span class='red2'><i class='fas fa-exclamation-circle'></i></span> ";
                }

                htmlString.push(
                    '<tr>'
                    + statusIconHtml
                    + '<a href="javascript:void(0);" onclick="procMovePage(\'<%= Constants.URI_STORAGES %>/' + persistentVolumeClaimName + '\');">' + persistentVolumeClaimName + '</a></td>'
                    + '<td><p>' + nvl(itemsMetadata.label, '-') + '</p></td>'
                    + '<td><p>' + nvl(specCollection, '-') + '</p></td>'
                    + '<td>' + nvl(itemStatus.phase, '-') + "</td>"
                    + '<td>' + itemsMetadata.creationTimestamp + '</td>'
                    + '</tr>');

                checkListCount++;
            }
        }


        if (listLength < 1 || checkListCount < 1) {
            resultHeaderArea.hide();
            resultArea.hide();
            noResultArea.show();
        } else {
            noResultArea.hide();
            resultHeaderArea.show();
            resultArea.html(htmlString);
            resultArea.show();

            resultTable.tablesorter({
                sortList: [[5, 1]] // 0 = ASC, 1 = DESC
            });

            resultTable.trigger("update");
            $('.headerSortFalse > td').unbind();
        }

        procSetToolTipForTableTd('resultArea');
        procViewLoading('hide');

    };


    // ON LOAD
    $(document.body).ready(function () {
        getPersistentVolumeClaimsList();
    });

</script>
