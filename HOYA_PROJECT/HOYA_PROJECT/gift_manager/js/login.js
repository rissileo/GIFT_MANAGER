$(document).ready(function () {
    sessionStorage.setItem("IDLOGIN", "");
});
function CheckLogin() {

    let login = $("#txtLogin").val();
    let senha = $("#txtSenha").val();

    let dr = "{'sLogin':'" + login + "','sSenha':'" + senha + "'}";
    let ret = callWebService("Login/ValidaLogin", dr);

    if (ret.length > 0) {
        let retCode = ret[0].retorno;

        if (parseInt(retCode) === 100) {
            let idLogin = ret[0].idlogin;
            let dcLogin = ret[0].dclogin;
            sessionStorage.setItem("IDLOGIN", idLogin);
            sessionStorage.setItem("DCLOGIN", dcLogin);
            window.location.href = "pedidos.html";
        }
        else {
            alert("USUARIO/SENHA NAO CONFEREM");
        }
    }
    else {
        alert("USUARIO/SENHA NAO CONFEREM");
    }
}




