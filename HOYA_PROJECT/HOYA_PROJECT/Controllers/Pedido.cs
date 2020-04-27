using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using HOYA_PROJECT.Business;
using HOYA_PROJECT.Helper;
using HOYA_PROJECT.ModelView;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace HOYA_PROJECT.Controllers
{
    [Route("api/Pedido")]
    [ApiController]
    public class Pedido : ControllerBase
    {

        //static readonly JsonSerializer _serializer = new JsonSerializer();
        //static readonly HttpClient _client = new HttpClient();
        Log lg = new Log();
        bnPedido pd = new bnPedido();

        // GET api/values
        [HttpPost("InserePedido")]
        //public string ListaCliente([FromBody] string value)
        public string InserePedido([FromBody]mvPedido mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("InserePedido");

                    string json = pd.InserePedido(mv.idCliente, mv.idLogin);

                    lg.GeraLog("json ---> " + json);

                    return json;
                }
            }
            catch (Exception ex)
            {
                //return StatusCode(404);

                return ex.Message.ToString();
            }
        }

        [HttpPost("ListaPedidosEfetuados")]
        //public string ListaCliente([FromBody] string value)
        public string ListaPedidosEfetuados([FromBody]mvIDLogin mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("ListaPedidosEfetuados");

                    string json = pd.ListaPedidosEfetuados(mv.idLogin);

                    lg.GeraLog("json ---> " + json);

                    return json;
                }
            }
            catch (Exception ex)
            {
                //return StatusCode(404);

                return ex.Message.ToString();
            }
        }

        [HttpPost("FinalizaPedido")]
        //public string ListaCliente([FromBody] string value)
        public bool FinalizaPedido([FromBody]mvIDPedido mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return false;
                }
                else
                {
                    lg.GeraLog("InserePedido");

                    return pd.FinalizarPedido(mv.idPedido);

                }
            }
            catch (Exception ex)
            {
                //return StatusCode(404);

                return false;
            }
        }

        [HttpPost("CancelaPedido")]
        //public string ListaCliente([FromBody] string value)
        public bool CancelaPedido([FromBody]mvIDPedido mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return false;
                }
                else
                {
                    lg.GeraLog("InserePedido");

                    return pd.CancelarPedido(mv.idPedido);
                }
            }
            catch (Exception ex)
            {
                //return StatusCode(404);

                return false;
            }
        }
    }
}
