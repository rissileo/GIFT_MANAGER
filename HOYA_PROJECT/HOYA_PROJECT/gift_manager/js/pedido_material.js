$(document).ready(function () {

    if (isNaN(sessionStorage.getItem("IDLOGIN")) && parseInt(sessionStorage.getItem("IDLOGIN")) <= 0) {
        window.location.href = "login.html";
    }
    else {

        var idPedido = parseInt(gup("id"));
        sessionStorage.setItem("IDPEDIDOESCOLHIDO", idPedido);

        PreencheSelectMaterial();
        ListaMateriaisPorPedido(idPedido);

        $("#spLOGIN").html("LOGIN: " + sessionStorage.getItem("DCLOGIN"));
        $("#spPEDIDO").html("PEDIDO SELECIONADO: " + sessionStorage.getItem("CODPEDIDOESCOLHIDO"));

        if (sessionStorage.getItem("PEDFINALIZADO") === 'SIM') {
            $("#btnFinalizarPedido").prop('disabled', true);
        }
        else {
            $("#btnFinalizarPedido").prop('disabled', false);
        }

    }
});
function gup(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(window.location.href);
    if (results === null)
        return "";
    else
        return results[1];
}
function ListaMateriaisPorPedido(idPedido) {

    var html = "";

    var datarequest = '{"idPedido":"' + idPedido + '"}';
    let ret = "";
    ret = callWebService("Material/ListaMaterialPedido", datarequest);

    if (ret.length > 0) {
        //html += "<button class='btn btn-primary' onclick='AbrePopUpAdicionaTMED();'>ADICIONAR TMED</button>";
        html += "<br>";
        html += "<br>";
        html += "<table cellpadding='0' cellspacing='0' width='100%' class='table dtable lcnp' id='palco'>";
        html += "<thead>";
        html += "<tr>";
        html += "<th>MATERIAL</th>";
        html += "<th style='text-align: center;'>QUANTIDADE SOLICITADA</th>";
        html += "<th style='text-align: center;'>QUANTIDADE ATENDIDA</th>";
        html += "<th style='text-align: center;'>QUANTIDADE NAO ATENDIDA</th>";
        html += "<th></th>";
        html += "</tr>";
        html += "</thead>";
        html += "<tbody>";

        for (i = 0; i <= ret.length - 1; i++) {
            let IDPEDIDOMATERIAL = ret[i].id_pedido_material;
            let MATERIAL = ret[i].dc_material;
            let QUANTIDADESOLICITADA = ret[i].qtd_solicitada;
            let QUANTIDADEATENDIDA = ret[i].qtd_atendida;
            let QUANTIDADENAOATENDIDA = ret[i].qtd_nao_atendida;

            html += "<tr>";
            html += "<td>" + MATERIAL + "</td>";
            html += "<td style='text-align: center;'>" + QUANTIDADESOLICITADA + "</td>";
            html += "<td style='text-align: center;'>" + QUANTIDADEATENDIDA + "</td>";
            html += "<td style='text-align: center;'>" + QUANTIDADENAOATENDIDA + "</td>";
            html += "</tr>";
        }
        html += "</tbody>";
        html += "</table>";

        $("#tbPEDIDOMATERIAL").html(html);
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
function AdicionarMaterialPedido() {
    try {

        debugger;
        let idPedido = sessionStorage.getItem("IDPEDIDOESCOLHIDO");
        let idMaterial = $("#sltrMaterial").val();
        let qtdPedido = $("#txtQuantidade").val();
        let idLogin = sessionStorage.getItem("IDLOGIN");

        if (qtdPedido.toString() === "" && !isNaN(qtdPedido)) {
            throw new Error("QUANTIDADE INVALIDA.");
        }
        else {
            if (parseInt(qtdPedido) < 0 || parseInt(qtdPedido) > 99) {
                throw new Error("QUANTIDADE INVALIDA.");
            }
        }

        if (parseInt(idMaterial) > 0) {

            let dr = "{'idPedido':'" + idPedido + "','idMaterial':'" + idMaterial + "','qtd':'" + qtdPedido + "','idLogin':'" + idLogin + "'}";
            let ret = callWebService("Material/InsereMaterialPedido", dr);

            if (ret.length > 0) {
                let retCode = ret[0].retorno;

                if (parseInt(retCode) === 100) {
                    alert(ret[0].retornomsg)
                }
                else {
                    alert(ret[0].retornomsg);
                }
                ListaMateriaisPorPedido(idPedido);
                $("#sltrMaterial").select2("val", "0");
                $("#txtQuantidade").val("");
            }
            else {
                alert("ERRO AO CRIAR O PEDIDO. CONTACTE O ADMINISTRADOR.");
            }
        }
        else {
            alert("ANTES, ECOLHA UM MATERIAL.");
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
        html += "<th>DATA PEDIDO</th>";
        html += "<th></th>";
        html += "</tr>";
        html += "</thead>";
        html += "<tbody>";

        for (i = 0; i <= ret.length - 1; i++) {
            let IDPEDIDO = ret[i].id_pedido;
            let CODPEDIDO = ret[i].cod_pedido;
            let DATAPEDIDO = ret[i].datapedido;

            html += "<tr>";
            html += "<td><a href='#' onclick='AbrePopUpAddMaterial(" + IDPEDIDO + ");'>" + CODPEDIDO + "</a></td>";
            html += "<td>" + DATAPEDIDO + "</td>";
            html += "</td></tr>";
            html += "</td></tr>";
        }
        html += "</tbody>";
        html += "</table>";

        $("#tbPEDIDO").html(html);
    }
}
function AbrePopUpAddMaterial(idPedido) {

    debugger;

    $("#quickLaunchModal").text("");

    var html = "";

    html = "<div class='modal-dialog'> ";
    html += "<div class='modal-content'> ";
    html += "<div class='modal-header'> ";
    html += "<caption>ADICIONAR MATERIAL NO PEDIDO</caption>";
    html += "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button> ";
    html += "</div> ";
    html += "<div class='modal-body'> ";
    //html += "<div class='col-md-6'> ";
    html += "<input type='number' id='txtQuantidade' min='1' max='99' class='form-control' placeholder='QUANTIDADE' /> ";
    //html += "</div> ";
    html += "<br> ";
    //html += "<div class='col-md-6'> ";
    html += "<select id='sltrMaterial' class='form-control'></select> ";
    //html += "</div> ";
    html += "<br> ";
    //html += "<div class='col-md-6'> ";
    html += "<div id='divIMAGE'></div> ";
    //html += "</div> ";

    html += "<br>";
    html += "<button class='btn btn-primary' onclick='AdicionaMaterialPedido(" + idPedido + ");'>SALVAR</button>";
    html += "</div> ";
    html += "</div> ";
    html += "</div> ";

    $("#quickLaunchModal").append(html);

    $('#quickLaunchModal').modal({ show: true });
}
function AdicionaMaterialPedido(idPedido) {
    try {

        debugger;
        let idMaterial = $("#sltrMaterial").val();
        let idLogin = sessionStorage.getItem("IDLOGIN");

        let dr = "{'idCliente':'" + idCliente + "','idLogin':'" + idLogin + "'}";
        let ret = callWebService("Pedido/InsereMaterialPedido", dr);

        if (ret.length > 0) {
            let retCode = ret[0].retorno;

            if (parseInt(retCode) === 100) {
                alert("PEDIDO CRIADO COM SUCESSO.")
            }
            else {
                alert(retCode.retornomsg);
            }
        }
        else {
            alert("ERRO AO CRIAR O PEDIDO. CONTACTE O ADMINISTRADOR.");
        }
    }
    catch (ex) {
        alert(ex.message.toString());
    }
}
function CancelarPedido() {

    debugger;

    var r = confirm("DESEJA REALMENTE CANCELAR O PEDIDO [" + sessionStorage.getItem("CODPEDIDOESCOLHIDO") + "]?");

    if (r) {

        let idPedido = sessionStorage.getItem("IDPEDIDOESCOLHIDO");
        let idLogin = sessionStorage.getItem("IDLOGIN");

        let dr = "{'idPedido':'" + idPedido + "'}";
        let ret = callWebService("Pedido/CancelaPedido", dr);

        if (ret) {
            alert("PEDIDO CANCELADO COM SUCESSO!")
            window.location.href = "pedidos.html";
        }
        else {
            alert("NAO FOI POSSIVEL CANCELAR O PEDIDO. VERIFIQUE SE O MESMO JA ESTA FINALIZADO.")
        }
    }
}
function FinalizarPedido() {

    debugger;

    var r = confirm("DESEJA REALMENTE FINALIZAR O PEDIDO [" + sessionStorage.getItem("CODPEDIDOESCOLHIDO") + "]?");

    if (r) {

        let idPedido = sessionStorage.getItem("IDPEDIDOESCOLHIDO");
        let idLogin = sessionStorage.getItem("IDLOGIN");

        let dr = "{'idPedido':'" + idPedido + "'}";
        let ret = callWebService("Pedido/FinalizaPedido", dr);

        if (ret) {
            alert("PEDIDO FINALIZADO COM SUCESSO!")
            window.location.href = "pedidos.html";
        }
    }
}