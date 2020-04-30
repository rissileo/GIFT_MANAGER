using HOYA_PROJECT.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Business
{
    public class bnMaterial
    {
        ReadXML xml = new ReadXML();
        dbConnect cn = new dbConnect();
        StringBuilder sql = new StringBuilder();

        public string ListaMaterial()
        {
            sql.Append("SELECT id_material, cod_material, dc_material FROM TB_MATERIAL");

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql.ToString()));
        }
        public string ListaImagemMaterialPorID(int idMaterial)
        {
            sql.AppendFormat("SELECT pic_base64 FROM TB_MATERIAL WHERE id_material = {0}", idMaterial);

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql.ToString()));
        }
        public string InsereMaterialPedido(int idPedido, int idMaterial, int qtd, int idLogin)
        {
            DataTable dt = new DataTable();

            sql.AppendFormat("exec SP_PEDIDO_MATERIAL @IDPEDIDO = {0}, @IDMATERIAL = {1}, @QTDSOLICITADA = {2}, @IDUSUARIO = {3};", idPedido, idMaterial, qtd, idLogin);

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql.ToString()));
        }
        public string ListaMaterialPorPedido(int idPedido)
        {
            sql.Append("SELECT id_pedido_material, A.id_material, B.dc_material,  ");
            sql.Append("A.qtd_solicitada, A.qtd_atendida, coalesce(sum(C.qtd_nao_atendida), 0) as qtd_nao_atendida ");
            sql.Append("FROM TB_PEDIDO_MATERIAL A ");
            sql.Append("inner join TB_MATERIAL B ON A.id_material = B.id_material ");
            sql.Append("left join TB_BACKLOG C ON A.id_material = C.id_material ");
            sql.AppendFormat("WHERE A.ID_PEDIDO = {0} ", idPedido);
            sql.Append("group by A.ID_PEDIDO, id_pedido_material, A.id_material, ");
            sql.Append("B.dc_material, A.qtd_solicitada, A.qtd_atendida ");

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql.ToString()));
        }
        public DataTable ListaMaterialPorPedidoDT(int idPedido)
        {
            sql.Append("SELECT id_pedido_material, A.id_material, B.dc_material, ");
            sql.Append("A.qtd_solicitada, A.qtd_atendida, coalesce(sum(C.qtd_nao_atendida), 0) as qtd_nao_atendida ");
            sql.Append("FROM TB_PEDIDO_MATERIAL A ");
            sql.Append("inner join TB_MATERIAL B ON A.id_material = B.id_material ");
            sql.Append("left join TB_BACKLOG C ON A.id_material = C.id_material ");
            sql.AppendFormat("WHERE A.ID_PEDIDO = {0}  ", idPedido);
            sql.Append("group by A.ID_PEDIDO, id_pedido_material, A.id_material,  ");
            sql.Append("B.dc_material, A.qtd_solicitada, A.qtd_atendida  ");

            return cn.SelectAccessDBSqlServer(sql.ToString());
        }
    }
}
