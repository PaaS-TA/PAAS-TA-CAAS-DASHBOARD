var procCallAjax = function(reqUrl, reqMethod, param, preFunc, callback) {
    var reqData = "";
    if (param != null) {
        reqData = param;
    }
    $.ajax({
        url: reqUrl,
        method: reqMethod,
        data: reqData,
        dataType: 'json',
        async: false,
        contentType: "application/json",
        beforeSend: function(xhr){
            ///preFunc
            xhr.setRequestHeader(_csrf_header, _csrf_token);
        },
        success: function(data) {
            callback(data);
        },
        error: function(xhr, status, error) {
            //alert("api error message");
        },
        complete : function(data) {
            // SKIP
            console.log("COMPLETE :: data :: ", data);
        }
    });
};


// MOVE PAGE
var procMovePage = function (pageUrl) {
    if (pageUrl === null || pageUrl.length < 1) {
        return false;
    }

    if ((!!pageUrl && typeof pageUrl === 'number') && -1 === pageUrl) {
        history.back();
    } else {
        // pageUrl = ("/" === pageUrl) ? "" : pageUrl;
        // location.href = procGetDashboardUrl() + pageUrl;
        location.href = pageUrl;
    }

};


// SET SELECTOR
var procSetSelector = function (requestMapString) {
    if (requestMapString === null || requestMapString.length < 1) {
        return false;
    }

    return JSON.stringify(requestMapString).replace(/["{}]/g, '').replace(/:/g, '=');
};


/**
 * 문자열이 빈 문자열인지 체크하여 빈값("") 또는 기본 문자열을 반환한다.
 * @param str           : 체크할 문자열
 */
function nvl(str, defaultStr){
    if(str == "undefined" || str === undefined || str == "null" || str === null || str == ""){
        if(defaultStr === undefined){
            str = "";
        }else{
            str = defaultStr;
        }
    }
    return str;
}

// SET MENU CURSOR
var procSetMenuCursor = function () {
    var leftMenuList = ["intro", "workloads", "services", "users", "roles"];
    var headerMenuList = ["users", "roles"];
    var leftMenuListLength = leftMenuList.length;
    var calledMenu = leftMenuList[0];

    var currentUrl = location.pathname;
    var splitString = "/";
    var splits = currentUrl.split(splitString);
    var splitsLength = splits.length;

    for (var i = 0; i < leftMenuListLength; i++) {
        for (var j = 0; j < splitsLength; j++) {
            if (leftMenuList[i] === splits[j]) {
                calledMenu = leftMenuList[i];

                if (headerMenuList.includes(splits[j])) {
                    $("#header-menu-" + calledMenu).addClass('cur');
                }
            }
        }
    }

    $("#left-menu-" + calledMenu).addClass('cur');
};


// SET SORT LIST
var procSetSortList = function(resultTableString, buttonObject, key) {
    $(buttonObject).toggleClass('sort');

    var resultTable = $('#' + resultTableString);
    var orderDigit = ($(buttonObject).hasClass('sort')) ? 0 : 1; // 0 = ASC, 1 = DESC
    var sorting = [[key, orderDigit]];

    resultTable.trigger("update");
    resultTable.trigger("sorton", [sorting]);
    $('.headerSortFalse > td').unbind();
};


var procCheckValidData = function (data) {
    var ensureData;
    if ('' === nvl(data)) {
        ensureData = {};
        ensureData.resultCode = RESULT_STATUS_FAIL;
    } else {
        ensureData = data;
        if ('' === nvl(data['resultCode'])) {
            ensureData.resultCode = RESULT_STATUS_FAIL;
        }
    }

    if (RESULT_STATUS_FAIL === ensureData.resultCode) {
        return false;
    } else {
        return null != data.resultCode;
    }
};

var viewLoading = function(type) {
    var dashboardWrap = $("#dashboardWrap");
    var loader = $("#loadingSpinner");

    if (type === 'show') {
        loader.show().gSpinner();
    } else {
        dashboardWrap.show();
        setTimeout(function(){
            loader.gSpinner("hide").hide();
        }, 1000);
    }
};


var alertMessage = function (value, result) {
    var messageValue = '시스템 에러가 발생했습니다.';
    var alertLayer = $(".alertLayer");

    if (nvl(value) !== '') {
        messageValue = value;
    }

    $(".alertLayer .in").html(messageValue);
    if (result) {
        alertLayer.css('border-left', '4px solid #3d10ef');
    } else {
        alertLayer.css('border-left', '4px solid #cb3d4a');
    }

    alertLayer.addClass("moveAlert");

    setTimeout(function () {
        alertLayer.removeClass("moveAlert");
    }, 3000);
};


// SET EVENT STATUS FOR PODS
var procSetEventStatusForPods = function(podNameList) {
    viewLoading('show');

    var listLength = podNameList.length;
    var reqUrl;

    for (var i = 0; i < listLength; i++) {
        reqUrl = URI_API_EVENTS_LIST.replace("{namespace:.+}", NAME_SPACE).replace("{resourceName:.+}", podNameList[i]);
        procCallAjax(reqUrl, "GET", null, null, callbackSetEventStatusForPods);
    }
};


// CALLBACK SET EVENT(STATUS) FOR PODS AND RESOURCES RELATED PODS
var callbackSetEventStatusForPods = function(data) {
    if (!procCheckValidData(data)) {
        viewLoading('hide');
        alertMessage();
        return false;
    }

    var podName = data.resourceName;
    var items = data.items;
    var listLength = items.length;
    var itemStatusIconHtml = "<span class='failed2 tableTdToolTipFalse'><i class='fas fas fa-exclamation-circle'></i></span> ";
    var itemNameLinkHtml = "<a href='javascript:void(0);' onclick='procMovePage(\"" + URI_WORKLOADS_PODS + "/" + podName + "\");'>" + podName + "</a>" ;
    var itemMessageHtml;
    var itemMessageList = [];

    var warningCount = 0;
    for (var i = 0; i < listLength; i++) {
        if (items[i].type === 'Warning') {
            itemMessageList.push(
                $('<p class="failed2 custom-content-overflow" data-toggle="tooltip">' + items[i].message + '</p>')
                    .attr('title', items[i].message).wrapAll("<div/>").parent().html()
            );
            warningCount++;
        }
    }

    if (warningCount > 0) {
        itemMessageHtml = itemMessageList.join("");
        $('#' + podName).html(itemStatusIconHtml + ' ' + itemNameLinkHtml + itemMessageHtml);
    }

    viewLoading('hide');
};


/**
 * 해당 리소스에 이벤트 데이터를 추가한다.
 * @param targetObject   : 해당 리소스의 리스트 JSON Object
 * @param selector       : 연관된 POD를 조회하기 위한 SELECTOR
 * @description
 *    해당 리소스(replicaSet, deployment)에 연관된 POD명을 조회하여,
 *    해당 POD의 이벤트를 조회후,
 *    해당 리소스의 리스트에 이벤트 데이터를 추가 합니다.
 *
 *    targetObject : 이벤트 데이터를 추가할 대상 JSON Object 입니다.(replicaSet, deployment 리스트 데이터)
 *    selector     : replace 처리되지 않은 json Data 입니다.
 *
 *    ex) addPodsEvent(itemList, itemList.spec.selector.matchLabels); // event Data added to 'itemList'
 *
 * @author CISS
 * @since 2018.09.12
 */
var addPodsEvent = function(targetObject, selector) {

    selector = procSetSelector(selector);

    // 기존 리스트 데이터에 event.type, event.message 추가
    var eventType = 'normal';
    var eventMessage = [];

    var reqPodsUrl = URI_API_PODS_RESOURCES
        .replace("{namespace:.+}", NAME_SPACE)
        .replace("{selector:.+}", selector);
    procCallAjax(reqPodsUrl, "GET", null, null, function(podsData){
        $.each(podsData.items, function (index, itemList) {
            var podsName = itemList.metadata.name;
            var podPhase = nvl(itemList.status.phase).toLowerCase();

            // 해당조건일시 이벤트에서 제외
            if(podPhase == "running" || podPhase.includes("succeeded") || podPhase == "terminated"){
                return true;  // continue;
            }

            var reqEventsUrl = URI_API_EVENTS_LIST
                .replace("{namespace:.+}", NAME_SPACE)
                .replace("{resourceName:.+}", podsName);
            procCallAjax(reqEventsUrl, "GET", null, null, function(eventData){
                $.each(eventData.items, function (index, eData) {

                    var eType = eData.type;
                    if(eType == 'Warning'){
                        eventType = eType;
                        eventMessage.push(eData.message);
                    }
                });

            });

        }); // Event API call end
    }); //Pods API call end

    targetObject.type = eventType;
    targetObject.message = eventMessage;

};


// SET TOOL TIP FOR TABLE TD
var procSetToolTipForTableTd = function (tableObjectString) {
    if (nvl(tableObjectString) === '') {
        return false;
    }

    var tableObject = $('#' + tableObjectString + ' tr');

    tableObject.each(function () {
        var tdTags = $(this).find('td');
        var pTags,
            aTags,
            spanTags;

        if (tdTags != null) {
            pTags = $(this).find('p');
            aTags = $(this).find('a');
            spanTags = $(this).find('span');

            pTags.each(function () {
                if (nvl(pTags) !== '') {
                    procSetToolTipAttributes($(this));
                }
            });

            aTags.each(function () {
                if (nvl(aTags) !== '') {
                    procSetToolTipAttributes($(this));
                }
            });

            spanTags.each(function () {
                if (nvl(spanTags) !== '') {
                    procSetToolTipAttributes($(this));
                }
            });
        }
    });

    // TOOL TIP
    $('[data-toggle="tooltip"]').tooltip();
};


// SET TOOL TIP ATTRIBUTES
var procSetToolTipAttributes = function (tagObject) {
    var tagObjectHtml = tagObject.html();
    if (!tagObject.hasClass('tableTdToolTipFalse') && tagObjectHtml !== '' && tagObjectHtml !== '-') {
        tagObject.addClass('custom-tag-content-overflow');
        tagObject.attr('data-toggle', 'tooltip').attr('title', tagObjectHtml);
    }
};


var procCreateSpans = function (data, type) {
    if( !data || data == "null") {
        return "-";
    }
    var datas = data.replace(/=/g, ':').split(',');
    var spanTemplate = "";

    if (type === "LB") { // Line Break
        $.each(datas, function (index, data) {
            if (index != 0) {
                spanTemplate += '<br>';
            }
            spanTemplate += '<span class="bg_gray">' + data + '</span>';
        });
    } else {
        $.each(datas, function (index, data) {
            spanTemplate += '<span class="bg_gray">' + data + '</span> ';
        });
    }
    return spanTemplate;
};


// SET LAYER POPUP
var procSetLayerPopup = function (reqTitle, reqContents, reqSuccess, reqCancel, reqClose, reqSuccessCallback, reqCancelCallback, reqCloseCallback) {
    $('.modal-backdrop').remove();

    var commonLayerPopupSuccessButton = $('#commonLayerPopupSuccessButton');
    var commonLayerPopupCancelButton = $('#commonLayerPopupCancelButton');
    var commonLayerPopupCloseButton = $('#commonLayerPopupCloseButton');
    var commonLayerPopupFooterWrap = $('#commonLayerPopupFooterWrap');

    commonLayerPopupCancelButton.hide();
    commonLayerPopupCloseButton.hide();
    commonLayerPopupFooterWrap.hide();

    if (nvl(reqSuccess) !== '' || nvl(reqCancel) !== '') {
        commonLayerPopupSuccessButton.html(nvl(reqSuccess, '확인'));
        commonLayerPopupFooterWrap.show();
    }

    if (nvl(reqCancel) !== '') {
        commonLayerPopupCancelButton.html(reqCancel);
        commonLayerPopupCancelButton.show();
    }

    if (nvl(reqClose) !== '') {
        commonLayerPopupCloseButton.html(reqClose);
        commonLayerPopupCloseButton.show();
    }

    if (nvl(reqSuccessCallback) !== '') {
        commonLayerPopupSuccessButton.attr('onclick', reqSuccessCallback);
    }

    if (nvl(reqCancelCallback) !== '') {
        commonLayerPopupCancelButton.attr('onclick', reqCancelCallback);
    }

    if (nvl(reqCloseCallback) !== '') {
        commonLayerPopupCloseButton.attr('onclick', reqCloseCallback);
    }

    $('#commonLayerPopupTitle').html(nvl(reqTitle, '알림'));
    $('#commonLayerPopupContents').html(nvl(reqContents, '정상 처리되었습니다.'));

    $("#commonLayerPopup").modal("show");

};


// SET EXECUTE COMMAND COPY
var procSetExecuteCommandCopy = function (requestValue) {
    if (nvl(requestValue) === '') {
        return false;
    }

    var target = $("#out_a");
    target.val(requestValue);
    target.select();

    return document.execCommand('copy');
};
