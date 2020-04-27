
var responseData = "";

function callWebService(metodoWs, datarequest) {

    var pURL = GetApplicationPath() + '/api/' + metodoWs;

    $.ajax({
        type: 'POST',
        //url: '../wsYNEXTPREMIUM.asmx/' + metodoWs + '',
        url: pURL,
        //url: DecideOrigem() + '/wsYNEXTPREMIUM.asmx/' + metodoWs + '',
        data: datarequest,
        async: false,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (data) {
            responseData = data;
            //callback(data.d);
        },
        error: function Erro(x, e) {
            if (x.status === 0) {
                alert(0);
            } else if (x.status === 404) {
                alert(404);
            } else if (x.status === 500) {
                alert(500);
            } else {
                alert("ERRO DESCONHECIDO");
            }
        },
    });
    return responseData;
    //return callback;
}

function GetApplicationPath() {
    return window.location.protocol + "//" + window.location.hostname + ":" + window.location.port;
}

function isEmpty(obj) {
    for (var prop in obj) {
        if (obj.hasOwnProperty(prop)) {
            return false;
        }
    }

    return JSON.stringify(obj) === JSON.stringify({});
}
//function ArrayToJsonObject(arr) {

//    if (arr.typeOf("Array")) {
//        arr = JSON.stringify(arr)
//        arr = $.parseJSON(arr)
//    }
//    else {
//        arr = $.parseJSON(arr);
//    }

//    return arr;
//}