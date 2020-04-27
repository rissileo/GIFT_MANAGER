using HOYA_PROJECT.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Business
{
    public class bnPedido
    {
        ReadXML xml = new ReadXML();
        dbConnect cn = new dbConnect();
        SendMail sm = new SendMail();
        bnMaterial mat = new bnMaterial();

        public string InserePedido(int idCliente, int idLogin)
        {
            string sql = string.Empty;

            sql = "exec SP_PEDIDO @IDCLIENTE = " + idCliente + ", @IDUSUARIO = " + idLogin + ";";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }

        public string ListaPedidosEfetuados(int idLogin)
        {
            string sql = string.Empty;

            sql += "SELECT A.id_pedido, A.cod_pedido, CONVERT(VARCHAR(10), A.dt_insert, 103) AS datapedido, ";
            sql += "B.razao_social, CASE WHEN COUNT(C.ID_PEDIDO_FINALIZADO) > 0 THEN 'SIM' ELSE 'NAO' END AS pedido_finalizado ";
            sql += "FROM TB_PEDIDO A INNER JOIN TB_CLIENTE B ON A.ID_CLIENTE = B.ID_CLIENTE ";
            sql += "LEFT JOIN TB_PEDIDO_FINALIZADO C ON C.ID_PEDIDO = A.ID_PEDIDO ";
            sql += "WHERE A.id_user_insert = " + idLogin + "";
            sql += "GROUP BY A.id_pedido, A.cod_pedido, CONVERT(VARCHAR(10), A.dt_insert, 103), B.razao_social ";
            //sql += "order by A.dt_insert desc ";

            return cn.DataTableToJSON(cn.SelectAccessDBSqlServer(sql));
        }

        public bool FinalizarPedido(int idPedido)
        {
            DataTable dt = new DataTable();

            string sql = "exec sp_finaliza_pedido @idpedido= " + idPedido + ";";

            dt = cn.SelectAccessDBSqlServer(sql);

            if (dt.Rows.Count > 0)
            {
                if (int.Parse(dt.Rows[0]["retorno"].ToString()) == 100)
                {
                    string mailuser = dt.Rows[0]["mailuser"].ToString();
                    string mailTeam = dt.Rows[0]["mailequipe"].ToString();

                    if (!string.IsNullOrEmpty(mailuser))
                    {
                        string body = MAIL_ListaHTMLConfirmacaoPedido(idPedido);

                        if (sm.Enviar(mailuser, "CONFIRMACAO DE PEDIDO - USUARIO", body))
                        {
                            if (sm.Enviar(mailTeam, "CONFIRMACAO DE PEDIDO - EQUIPE", body))
                            {
                                return true;
                            }
                            else
                            {
                                return false;
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else

                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public bool CancelarPedido(int idPedido)
        {
            string sql = string.Empty;
            DataTable dt = new DataTable();

            sql = "exec sp_cancela_pedido @idpedido = " + idPedido + ";";

            dt = cn.SelectAccessDBSqlServer(sql);

            if (dt.Rows.Count > 0)
            {
                if (int.Parse(dt.Rows[0]["retorno"].ToString()) == 100)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public string MAIL_ListaHTMLConfirmacaoPedido(int idPedido)
        {
            DataTable dt = new DataTable();
            string html = string.Empty;

            html += "<html>";
            html += "<head>";
            html += "</head>";
            html += "<body>";
            html += "<br>";
            html += "<span>SEU PEDIDO FOI CONFIRMADO!</span>";
            html += "<br>";
            html += "<br>";
            html += "<span>VEJA O STATUS ABAIXO:</span>";
            html += "<br>";
            html += "<br>";

            dt = mat.ListaMaterialPorPedidoDT(idPedido);

            if (dt.Rows.Count > 0)
            {
                html += "<table>";
                html += "<thead>";
                html += "<th>MATERIAL</th>";
                html += "<th style='text-align: center;'>QUANTIDADE SOLICITADA</th>";
                html += "<th style='text-align: center;'>QUANTIDADE ATENDIDA</th>";
                html += "<th style='text-align: center;'>QUANTIDADE NAO ATENDIDA</th>";
                html += "</thead>";

                foreach (DataRow row in dt.Rows)
                {
                    string IDPEDIDOMATERIAL = row["id_pedido_material"].ToString();
                    string MATERIAL = row["dc_material"].ToString();
                    string QUANTIDADESOLICITADA = row["qtd_solicitada"].ToString();
                    string QUANTIDADEATENDIDA = row["qtd_atendida"].ToString();
                    string QUANTIDADENAOATENDIDA = row["qtd_nao_atendida"].ToString();

                    html += "<tr>";
                    html += "<td>" + MATERIAL + "</td>";
                    html += "<td style='text-align: center;'>" + QUANTIDADESOLICITADA + "</td>";
                    html += "<td style='text-align: center;'>" + QUANTIDADEATENDIDA + "</td>";
                    html += "<td style='text-align: center;'>" + QUANTIDADENAOATENDIDA + "</td>";
                    html += "</tr>";
                }

                html += "</table>";
            }
            else
            {
                html += "<span>NÃO HÁ PRODUTOS NO PEDIDO INFORMADO</span>";
            }

            html += "</body>";
            html += "</html>";

            return html;
        }
    }
}
