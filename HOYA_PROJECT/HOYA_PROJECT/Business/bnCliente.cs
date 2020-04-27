using HOYA_PROJECT.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Business
{
    public class bnCliente
    {
        ReadXML xml = new ReadXML();
        dbConnect cn = new dbConnect();

        public string ListaCliente()
        {
            string sql = string.Empty;

            sql = "SELECT * FROM TB_CLIENTE";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }

        public string ProcuraCliente(string sChave)
        {
            string sql = string.Empty;

            sql = "SELECT * FROM TB_CLIENTE WHERE COD_CLIENTE LIKE '%"+ sChave + "%' OR RAZAO_SOCIAL LIKE '%"+ sChave + "%'";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }
    }
}
