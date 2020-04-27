$(document).ready(function () {

    if (isNaN(sessionStorage.getItem("IDLOGIN")) && parseInt(sessionStorage.getItem("IDLOGIN")) <= 0) {
        window.location.href = "login.html";
    }
    else {
        PreencheSelectCliente();
        //PreencheSelectMaterial();
        ListaPedidosLogin();
        sessionStorage.setItem("IDPEDIDOESCOLHIDO", "");
        sessionStorage.setItem("CODPEDIDOESCOLHIDO", "");
    }
});
function PreencheSelectCliente() {
    try {

        let html = "";

        let dr = "{}";
        let ret = callWebService("Cliente/ListaCliente", dr);
        if (ret.length > 0) {

            //html += "<option value='0'>::SELECIONE::</option>"; 
            html += "<option value='0'>::SELECIONE O CLIENTE::</option>";

            for (let i = 0; i <= ret.length - 1; i++) {
                let idCliente = ret[i].id_cliente;
                let codCliente = ret[i].cod_cliente;
                let razaoSocial = ret[i].razao_social;

                html += "<option value='" + idCliente + "'>" + codCliente + " - " + razaoSocial + "</option>";
            }
            $("#sltrCliente").html(html);
            $("#sltrCliente").select2();
        }
    }
    catch (e) {
        alert(e.message.toString().toUpper());
    }
}
function PreencheSelectMaterial() {
    try {

        let html = "";

        let dr = "{}";
        let ret = callWebService("Material/ListaMaterial", dr);
        if (ret.length > 0) {

            //html += "<option value='0'>::SELECIONE::</option>"; 
            html += "<option value='0'>::SELECIONE O MATERIAL::</option>";

            for (let i = 0; i <= ret.length - 1; i++) {
                let idMaterial = ret[i].id_material;
                let codMaterial = ret[i].cod_material;
                let dcMaterial = ret[i].dc_material;

                html += "<option value='" + idMaterial + "'>" + codMaterial + " - " + dcMaterial + "</option>";
            }
            $("#sltrMaterial").html(html);
            $("#sltrMaterial").select2();
            $('#sltrMaterial').on('select2:selecting', function (e) {
                //console.log('Selecting: ', e.params.args.data);
                let selectedData = e.params.args.data;
                //console.log(selectedData.id);
                ListaMaterialFotoPorId(selectedData.id)
            });
        }
    }
    catch (e) {
        alert(e.message.toString().toUpper());
    }
}
function ListaMaterialFotoPorId(idMaterial) {
    let html = "";

    let dr = "{'idMaterial':'" + idMaterial + "'}";
    let ret = callWebService("Material/ListaImagemMaterialPorID", dr);
    if (ret.length > 0) {
        let image = ret[0].pic_base64;

        if (image === null || image === "null" || image === "" || image === undefined || isEmpty(image)) {
            html += "<img src='images/no_image.png' style='width: 100px; heigth: 100px;'/>";
            $("#divIMAGE").html(html);
        }
        else {
            html += "<img src='" + image + "' style='width: 100px; heigth: 100px;'/>";
            $("#divIMAGE").html(html);
        }
    }
    else {
        html += "<img src='images/no_image.png' style='width: 100px; heigth: 100px;'/>";
        $("#divIMAGE").html("");
    }
}
function CriarPedido() {
    try {

        debugger;
        let idCliente = $("#sltrCliente").val();
        let idLogin = sessionStorage.getItem("IDLOGIN");

        if (parseInt(idCliente) > 0) {
            let dr = "{'idCliente':'" + idCliente + "','idLogin':'" + idLogin + "'}";
            let ret = callWebService("Pedido/InserePedido", dr);

            if (ret.length > 0) {
                let retCode = ret[0].retorno;

                if (parseInt(retCode) === 100) {
                    alert(ret[0].retornomsg);
                    ListaPedidosLogin();
                }
                else {
                    alert(ret[0].retornomsg);
                }
            }
            else {
                alert("ERRO AO CRIAR O PEDIDO. CONTACTE O ADMINISTRADOR.");
            }
        }
        else {
            alert("ANTES, ESCOLHA UM CLIENTE.");
        }
    }
    catch (ex) {
        alert(ex.message.toString());
    }
}
function ListaPedidosLogin() {

    var html = "";
    let idLogin = sessionStorage.getItem("IDLOGIN");

    var datarequest = '{"idLogin":"' + idLogin + '"}';
    let ret = "";
    ret = callWebService("Pedido/ListaPedidosEfetuados", datarequest);

    if (ret.length > 0) {
        //html += "<button class='btn btn-primary' onclick='AbrePopUpAdicionaTMED();'>ADICIONAR TMED</button>";
        html += "<br>";
        html += "<br>";
        html += "<table cellpadding='0' cellspacing='0' width='100%' class='table dtable lcnp' id='palco'>";
        html += "<thead>";
        html += "<tr>";
        html += "<th>COD PEDIDO</th>";
        html += "<th>CLIENTE</th>";
        html += "<th>DATA PEDIDO</th>";
        html += "<th>FINALIZADO</th>";
        html += "<th></th>";
        html += "</tr>";
        html += "</thead>";
        html += "<tbody>";

        for (i = 0; i <= ret.length - 1; i++) {
            let IDPEDIDO = ret[i].id_pedido;
            let CODPEDIDO = ret[i].cod_pedido;
            let DATAPEDIDO = ret[i].datapedido;
            let CLIENTE = ret[i].razao_social;
            let PEDFINALIZADO = ret[i].pedido_finalizado;

            html += "<tr>";
            html += "<td><a href='#' onclick='ClickPedido(" + IDPEDIDO + ",\"" + CODPEDIDO + "\",\"" + PEDFINALIZADO + "\")'>" + CODPEDIDO + "</a></td>";
            html += "<td>" + CLIENTE + "</td>";
            html += "<td>" + DATAPEDIDO + "</td>";
            html += "<td>" + PEDFINALIZADO + "</td>";
            html += "</td></tr>";
            html += "</td></tr>";
        }
        html += "</tbody>";
        html += "</table>";

        $("#tbPEDIDO").html(html);
    }
}

function ClickPedido(IDPEDIDO, CODPEDIDO, PEDFINALIZADO) {

    debugger;
    sessionStorage.setItem("IDPEDIDOESCOLHIDO", IDPEDIDO);
    sessionStorage.setItem("CODPEDIDOESCOLHIDO", CODPEDIDO);
    sessionStorage.setItem("PEDFINALIZADO", PEDFINALIZADO);

    window.location.href = "pedido_material.html?id=" + IDPEDIDO + "";
}

//function ListaFormasPagamento() {

//    var html = "";

//    var datarequest = '{}';
//    var sRetorno = "";
//    sRetorno = callWebService("ListaFormasPagamento", datarequest);

//    if (sRetorno.length > 0) {
//        sRetorno = $.parseJSON(sRetorno);

//        html += "<button class='btn btn-primary' onclick='AbrePopUpAdicionaTMED();'>ADICIONAR TMED</button>";
//        html += "<br>";
//        html += "<br>";
//        html += "<table cellpadding='0' cellspacing='0' width='100%' class='table dtable lcnp' id='palco'>";
//        html += "<thead>";
//        html += "<tr>";
//        html += "<th>ID TMED</th>";
//        html += "<th>ID TMED MICROS</th>";
//        html += "<th>ID TMED OOBJ</th>";
//        html += "<th>ID TMED CIELO</th>";
//        html += "<th>DC TMED</th>";
//        html += "<th></th>";
//        html += "</tr>";
//        html += "</thead>";
//        html += "<tbody>";

//        for (i = 0; i <= sRetorno.length - 1; i++) {
//            var IDTMED = sRetorno[i].id_tinc_tmed;
//            var IDTMEDMICROS = sRetorno[i].id_tmed_micros;
//            var IDTMEDOOBJ = sRetorno[i].id_tmed_oobj;
//            var IDTMEDCIELO = sRetorno[i].id_tmed_cielo;
//            var DCTMED = sRetorno[i].dc_tmed;

//            html += "<tr>";
//            html += "<td>" + IDTMED + "</td>";
//            html += "<td><a href='#' onclick='AbrePopUpAlteraValor(" + IDTMED + ", 1, \"" + IDTMEDMICROS.toString() + "\")'>" + IDTMEDMICROS + "</a></td>";
//            html += "<td><a href='#' onclick='AbrePopUpAlteraValor(" + IDTMED + ", 2, \"" + IDTMEDOOBJ.toString() + "\")'>" + IDTMEDOOBJ + "</a></td>";
//            html += "<td><a href='#' onclick='AbrePopUpAlteraValor(" + IDTMED + ", 3, \"" + IDTMEDCIELO.toString() + "\")'>" + IDTMEDCIELO + "</a></td>";
//            html += "<td><a href='#' onclick='AbrePopUpAlteraValor(" + IDTMED + ", 4, \"" + DCTMED + "\")'>" + DCTMED + "</a></td>";
//            html += "<td><a href='#' onclick='RemoveTMED(" + IDTMED + ", \"" + DCTMED + "\")'>Remover</a></td>";
//            html += "</td></tr>";
//            html += "</td></tr>";
//        }
//        html += "</tbody>";
//        html += "</table>";

//        $("#tbTMED").html(html);
//    }
//}

//function AbrePopUpAlteraValor(IDTEMD, CAMPO, VALOR) {
//    $("#quickLaunchModal").text("");

//    debugger;

//    var html = "";

//    html = "<div class='modal-dialog'> ";
//    html += "<div class='modal-content'> ";


//    switch (CAMPO) {
//        case 1:
//            html += "<div class='modal-header'> ";
//            html += "<caption>ALTERA COD. TMED MICROS</caption>";
//            html += "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button> ";
//            html += "</div> ";
//            html += "<div class='modal-body'> ";
//            html += "<input type='text' id='txtValor' min='1' max='999' class='form-control' value = '" + VALOR + "'/>";
//            break;
//        case 2:
//            html += "<div class='modal-header'> ";
//            html += "<caption>ALTERA COD. TMED OOBJ</caption>";
//            html += "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button> ";
//            html += "</div> ";
//            html += "<div class='modal-body'> ";
//            html += "<input type='text' id='txtValor' min='1' max='99' class='form-control' value = '" + VALOR + "'/>";
//            break;
//        case 3:
//            html += "<div class='modal-header'> ";
//            html += "<caption>ALTERA COD. TMED SITEF/CIELO</caption>";
//            html += "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button> ";
//            html += "</div> ";
//            html += "<div class='modal-body'> ";
//            html += "<input type='text' id='txtValor' min='1' max='99999' class='form-control' value = '" + VALOR + "'/>";
//            break;
//        case 4:
//            html += "<div class='modal-header'> ";
//            html += "<caption>ALTERA DESCRICAO DO TENDER MEDIA</caption>";
//            html += "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button> ";
//            html += "</div> ";
//            html += "<div class='modal-body'> ";
//            html += "<input type='text' id='txtValor' class='form-control' value = '" + VALOR + "'/>";
//            break;
//    }


//    html += "<br>";
//    html += "<button class='btn btn-primary' onclick='AlteraValorTMED(" + IDTEMD + "," + CAMPO + ");'>SALVAR</button>";
//    html += "</div> ";
//    html += "</div> ";
//    html += "</div> ";

//    $("#quickLaunchModal").append(html);

//    $('#quickLaunchModal').modal({ show: true });
//}

//function AlteraValorTMED(IDTMED, CAMPO) {

//    var sValor = $("#txtValor").val();

//    var datarequest = '{"iTMED":"' + IDTMED + '","iCampo":"' + CAMPO + '","sValor":"' + sValor + '"}';
//    var sRetorno = "";
//    sRetorno = callWebService("AlteraFormasPagamento", datarequest);

//    if (sRetorno) {
//        ListaFormasPagamento();
//        $('#quickLaunchModal').modal('hide');
//    }
//    else {
//        alert("NÃO FOI POSSÍVEL REALIZAR A ALTERAÇÃO.")
//    }

//}

//function RemoveTMED(IDTEMD, DCTMED) {
//    var confirmValue = confirm("DESEJA REALMENTE EXCLUIR A FORMA DE PAGAMENTO [" + DCTMED + "]?");
//    if (confirmValue) {
//        var datarequest = '{"iTMED":"' + IDTEMD + '"}';
//        var sRetorno = "";
//        sRetorno = callWebService("RemoveFormaPagamento", datarequest);

//        if (sRetorno) {
//            ListaFormasPagamento();
//            $('#quickLaunchModal').modal('hide');
//        }
//        else {
//            alert("NÃO FOI POSSÍVEL EXCLUIR A FORMA DE PAGAMENTO.")
//        }
//    }
//}

//function AbrePopUpAdicionaTMED() {
//    $("#quickLaunchModal").text("");

//    var html = "";

//    html = "<div class='modal-dialog'> ";
//    html += "<div class='modal-content'> ";
//    html += "<div class='modal-header'> ";
//    html += "<caption>ADICIONA FORMA DE PAGAMENTO</caption>";
//    html += "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button> ";
//    html += "</div> ";
//    html += "<div class='modal-body'> ";

//    html += "<span>ID TMED MICROS</span>"
//    html += "<br>"
//    html += "<input type='text' id='txtTMEDMICROS' class='form-control' value = ''/>";

//    html += "<br>"
//    html += "<span>ID TMED OOBJ</span>"
//    html += "<br>"
//    html += "<input type='text' id='txtTMEDOOBJ' class='form-control' value = ''/>";

//    html += "<br>"
//    html += "<span>ID TMED SITEF/CIELO</span>"
//    html += "<br>"
//    html += "<input type='text' id='txtTMEDCIELO' class='form-control' value = ''/>";

//    html += "<br>"
//    html += "<span>DESCRICAO TMED</span>"
//    html += "<br>"
//    html += "<input type='text' id='txtDCTMED' class='form-control' value = ''/>";

//    html += "<br>";
//    html += "<button class='btn btn-primary' onclick='AdicionaTMED();'>SALVAR</button>";
//    html += "</div> ";
//    html += "</div> ";
//    html += "</div> ";

//    $("#quickLaunchModal").append(html);

//    $('#quickLaunchModal').modal({ show: true });
//}

//function AdicionaTMED() {
//    debugger;
//    var idTMEDMICROS = $("#txtTMEDMICROS").val();
//    var idTMEDOOBJ = $("#txtTMEDOOBJ").val();
//    var idTMEDCIELO = $("#txtTMEDCIELO").val();
//    var dcTMED = $("#txtDCTMED").val();

//    var datarequest = '{"idMEDMICROS":"' + idTMEDMICROS + '", "idTMEDOOBJ": "' + idTMEDOOBJ + '", "idTMEDCIELO":"' + idTMEDCIELO + '", "idDCTMED":"' + dcTMED + '"}';
//    var sRetorno = "";
//    sRetorno = callWebService("InsereFormaPagamento", datarequest);

//    if (sRetorno) {
//        ListaFormasPagamento();
//        $('#quickLaunchModal').modal('hide');
//    }
//    else {
//        alert("NÃO FOI POSSÍVEL EXCLUIR A FORMA DE PAGAMENTO.")
//    }
//}



