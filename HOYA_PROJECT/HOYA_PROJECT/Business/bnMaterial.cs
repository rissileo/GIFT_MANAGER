using HOYA_PROJECT.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Business
{
    public class bnMaterial
    {
        ReadXML xml = new ReadXML();
        dbConnect cn = new dbConnect();

        public string ListaMaterial()
        {
            string sql = string.Empty;

            sql = "SELECT id_material, cod_material, dc_material FROM TB_MATERIAL";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }
        public string ListaImagemMaterialPorID(int idMaterial)
        {
            string sql = string.Empty;

            sql = "SELECT pic_base64 FROM TB_MATERIAL WHERE id_material = " + idMaterial + "";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }
        public string InsereMaterialPedido(int idPedido, int idMaterial, int qtd, int idLogin)
        {
            string sql = string.Empty;
            DataTable dt = new DataTable();

            sql = "exec SP_PEDIDO_MATERIAL @IDPEDIDO = " + idPedido + ", @IDMATERIAL = " + idMaterial + ", @QTDSOLICITADA = " + qtd + ", @IDUSUARIO = " + idLogin + ";";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }
        public string ListaMaterialPorPedido(int idPedido)
        {
            string sql = string.Empty;


            sql += "SELECT id_pedido_material, A.id_material, B.dc_material,  ";
            sql += "A.qtd_solicitada, A.qtd_atendida, coalesce(sum(C.qtd_nao_atendida), 0) as qtd_nao_atendida ";
            sql += "FROM TB_PEDIDO_MATERIAL A ";
            sql += "inner join TB_MATERIAL B ON A.id_material = B.id_material ";
            sql += "left join TB_BACKLOG C ON A.id_material = C.id_material ";
            sql += "WHERE A.ID_PEDIDO = " + idPedido + " ";
            sql += "group by A.ID_PEDIDO, id_pedido_material, A.id_material,   ";
            sql += "B.dc_material, A.qtd_solicitada, A.qtd_atendida ";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }
        public DataTable ListaMaterialPorPedidoDT(int idPedido)
        {
            string sql = string.Empty;


            sql += "SELECT id_pedido_material, A.id_material, B.dc_material,  ";
            sql += "A.qtd_solicitada, A.qtd_atendida, coalesce(sum(C.qtd_nao_atendida), 0) as qtd_nao_atendida ";
            sql += "FROM TB_PEDIDO_MATERIAL A ";
            sql += "inner join TB_MATERIAL B ON A.id_material = B.id_material ";
            sql += "left join TB_BACKLOG C ON A.id_material = C.id_material ";
            sql += "WHERE A.ID_PEDIDO = " + idPedido + " ";
            sql += "group by A.ID_PEDIDO, id_pedido_material, A.id_material,   ";
            sql += "B.dc_material, A.qtd_solicitada, A.qtd_atendida ";

            return cn.SelectAccessDBSqlServer(sql);
        }
    }
}
