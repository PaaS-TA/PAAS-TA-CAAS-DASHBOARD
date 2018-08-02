<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>main</title>

    <script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>

    <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet">

    <script type="text/javascript" src="<c:url value='/resources/js/jquery.jsonPresenter.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.jsonPresenter.css' />" rel="stylesheet">

</head>
<body class="hold-transition login-page">

<div>
    <br>
        <div class="mt50 ml50">
            <img src="<c:url value='/resources/images/flower.png' />">
        </div>
    </span>
</div>

<div class="row" style="padding: 50px; width: 1000px;">
    <span>User Account Token: </span>
    <textarea id="inputToken"></textarea>
</div>

<div class="row" style="padding: 50px; width: 1000px;">
    <div class="col-md-8">
        <table style="border: 0px;" class="table">
            <tr>
                <td id="namespaces" style="cursor: hand">Get namespaces</td>
            </tr>
        </table>
    </div>
    <div class="col-md-4">
        <div id="json-container" style="height: 865px; width: 700px; margin-right: 50px;"></div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $("#namespaces").on("click", function (e) {
            getNamespaces();
        });
    });

    //
    function getNamespaces(){

        var param = {
            token : $('#inputToken').text()
            //code : $('#condition01').val()
        }
        procCallAjax("/namespaces", "GET", param , null, procCallbackGetNamespaces);
    }

    // Callback Proc
    var procCallbackGetNamespaces = function(result){
        $('#json-container').jsonPresenter({
            json: {result}  // JSON objects here
        })
    }

</script>
</body>
</html>


