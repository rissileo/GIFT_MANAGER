using HOYA_PROJECT.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Business
{
    public class bnLogin
    {
        ReadXML xml = new ReadXML();
        dbConnect cn = new dbConnect();
        StringBuilder sql = new StringBuilder();

        public string ValidaLogin(string sLogin, string sSenha)
        {
            sql.AppendFormat("EXEC SP_AUTENTICA_USUARIO @login = '{0}', @dc_senha = '{1}' ", sLogin.Trim(), sSenha.Trim());

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql.ToString()));
        }
    }
}
