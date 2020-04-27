using HOYA_PROJECT.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Business
{
    public class bnLogin
    {
        ReadXML xml = new ReadXML();
        dbConnect cn = new dbConnect();

        public string ValidaLogin(string sLogin, string sSenha)
        {
            string sql = string.Empty;

            sql = "EXEC SP_AUTENTICA_USUARIO @login = '"+ sLogin.Trim() + "', @dc_senha = '"+ sSenha + "' ";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }
    }
}
