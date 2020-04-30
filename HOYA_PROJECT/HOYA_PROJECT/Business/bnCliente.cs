using HOYA_PROJECT.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Business
{
    public class bnCliente
    {
        ReadXML xml = new ReadXML();
        dbConnect cn = new dbConnect();

        StringBuilder sql = new StringBuilder();

        public string ListaCliente()
        {
            sql.Append("SELECT * FROM TB_CLIENTE");

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql.ToString()));
        }

        public string ProcuraCliente(string sChave)
        {
            sql.AppendFormat("SELECT * FROM TB_CLIENTE WHERE COD_CLIENTE LIKE '%{0}%' OR RAZAO_SOCIAL LIKE '%{0}%'", sChave.Trim());

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql.ToString()));
        }
    }
}
