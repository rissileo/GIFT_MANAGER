using Nancy.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Helper
{
    public class dbConnect
    {

        private SqlConnection sql_consqlserver;
        private SqlCommand sql_cmdsqlserver;
        ReadXML xml = new ReadXML();

        public DataTable SelectAccessDBSqlServer(string sql)
        {
            Log lg = new Log();

            try
            {
                SqlDataAdapter Adp;
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();

                string stringConnection = xml.Read("settings.xml", "settings", "stringConnection").Trim();//Pega o arquivo da Base
                sql_consqlserver = new SqlConnection(stringConnection);//Conecta a Base passando a string de Conexão

                sql_cmdsqlserver = sql_consqlserver.CreateCommand();
                Adp = new SqlDataAdapter(sql, sql_consqlserver);
                Adp.Fill(ds);
                dt = ds.Tables[0]; //Joga resultado em um DataTable para retorno
                return dt;
            }
            catch (Exception ex)
            {
                lg.GeraLog(ex.Message.ToString());
                return null;
            }
            finally
            {
                //lg.GeraLog("CONEXÃO FECHADA", 5);
                sql_consqlserver.Close();
            }
        }
        public string DataTableToJSON(DataTable table)
        {
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();

            foreach (DataRow row in table.Rows)
            {
                Dictionary<string, object> dict = new Dictionary<string, object>();

                foreach (DataColumn col in table.Columns)
                {
                    dict[col.ColumnName] = row[col];
                }
                list.Add(dict);
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            //serializer.MaxJsonLength = Int32.MaxValue;
            return serializer.Serialize(list);
        }

        private string ClearText(string value)
        {
            value = value.Replace("'", "`");
            value = value.Replace("<", "");
            return value;
        }
    }
}
