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
    [Route("api/Material")]
    [ApiController]
    public class Material : ControllerBase
    {

        //static readonly JsonSerializer _serializer = new JsonSerializer();
        //static readonly HttpClient _client = new HttpClient();
        Log lg = new Log();
        bnMaterial mat = new bnMaterial();

        // GET api/values
        [HttpPost("ListaMaterial")]
        //public string ListaCliente([FromBody] string value)
        public string ListaMaterial()
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("ListaMaterial");

                    string json = mat.ListaMaterial();

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

        [HttpPost("ListaImagemMaterialPorID")]
        //public string ListaCliente([FromBody] string value)
        public string ListaImagemMaterialPorID([FromBody]mvIDMaterial mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("ListaImagemMaterialPorID");

                    string json = mat.ListaImagemMaterialPorID(mv.idMaterial);

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

        [HttpPost("InsereMaterialPedido")]
        //public string ListaCliente([FromBody] string value)
        public string InsereMaterialPedido([FromBody]mvMaterialPedido mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("ListaImagemMaterialPorID");

                    string json = mat.InsereMaterialPedido(mv.idPedido, mv.idMaterial, mv.qtd, mv.idLogin);

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

        [HttpPost("ListaMaterialPedido")]
        //public string ListaCliente([FromBody] string value)
        public string ListaMaterialPedido([FromBody]mvIDPedido mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("ListaMaterialPedido");

                    string json = mat.ListaMaterialPorPedido(mv.idPedido);

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

    }
}
