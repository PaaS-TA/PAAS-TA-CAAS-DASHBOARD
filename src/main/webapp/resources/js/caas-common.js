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
        beforeSend: function(){
            ///preFunc
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


// GET DASHBOARD URL
var procGetDashboardUrl = function () {
    var currentUrl = location.pathname;
    var splitString = "/";
    var splits = currentUrl.split(splitString);

    return splitString + splits[1] + splitString + splits[2];
};


// SET SELECTOR
var procSetSelector = function (requestMapString) {
    if (requestMapString === null || requestMapString.length < 1) {
        return false;
    }

    return JSON.stringify(requestMapString).replace(/["{}]/g, '').replace(/:/g, '=');
};


/**
 * 문자열이 빈 문자열인지 체크하여 빈값("")으로 한다.
 * @param str           : 체크할 문자열
 */
function nvl(str){
    if(typeof str === "undefined" || str == null || str === "null" || str === ""){
        str = "";
    }
    return str;
}

/**
 * 문자열이 빈 문자열인지 체크하여 기본 문자열로 리턴한다.
 * @param str           : 체크할 문자열
 * @param defaultStr    : 문자열이 비어있을경우 리턴할 기본 문자열
 */
function nvl2(str, defaultStr){
    if(typeof str === "undefined" || str == null || str === "null" || str === "")
        str = defaultStr ;
    return str ;
}


// SET MENU CURSOR
var procSetMenuCursor = function () {
    var leftMenuList = ["clusters", "workloads", "services", "accessInfo", "users", "roles"];
    var headerMenuList = ["accessInfo", "users", "roles"];
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

var checkValidData = function (data) {
    if (RESULT_STATUS_FAIL === data.resultCode) {
        console.log("ResultStatus :: " + data.resultCode + " / " + "ResultMessage :: " + data.resultMessage);
        return false;
    } else {
        return true;
    }
}

var processIfDataIsNull = function (data, procCallback, defaultValue) {
    if (data == null)
        return defaultValue;
    else {
        if (procCallback == null)
            return defaultValue;
        else
            return procCallback(data);
    }
}

var sortTable = function (tableId, sortKey, isAscending=true) {
    let tbody = $('#' + tableId + ' > tbody');
    let rows = tbody.children('tr');
    rows.sort(function (rowA, rowB) {
        let reverseNumber = (isAscending)? 1 : -1;
        let compareA = $(rowA).attr(sortKey);
        let compareB = $(rowB).attr(sortKey);
        if (compareA == compareB)
            return 0;
        else {
            if (compareA == null)
                return -1 * reverseNumber;
            else if (compareB == null)
                return 1 * reverseNumber;
            else if (compareA > compareB)
                return 1 * reverseNumber;
            else
                return -1 * reverseNumber;
        }
    });
    tbody.html(rows);
}

var convertByte = function(capacity) {
    var multipleSize;
    if (capacity.match("Ki").index != -1) {
        multipleSize = 1024;
    } else if (capacity.match("Mi").index != -1) {
        multipleSize = 1024 * 1024;
    } else if (capacity.match("Gi").index != -1) {
        multipleSize = 1024 * 1024 * 1024;
    } else {
        multipleSize = 1;
    }

    return capacity.substring(0, capacity.length - 2) * multipleSize;
}

var formatCapacity = function(capacity, unit) {
    var unitSize;
    if (unit == null || "" == unit)
        unitSize = 1;
    else {
        if (unit === "Ki")    unitSize = 1024
        if (unit === "Mi")    unitSize = Math.pow(1024, 2);
        if (unit === "Gi")    unitSize = Math.pow(1024, 3);
    }

    return ((capacity / unitSize).toFixed(2) + ' ' + unit);
}

/*
var stringifyJSON = function (obj) {
    return JSON.stringify(obj).replace(/["{}]/g, '').replace(/:/g, '=');
}
*/
