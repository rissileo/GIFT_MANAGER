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
    [Route("api/Cliente")]
    [ApiController]
    public class Cliente : ControllerBase
    {

        //static readonly JsonSerializer _serializer = new JsonSerializer();
        //static readonly HttpClient _client = new HttpClient();
        Log lg = new Log();
        bnCliente cli = new bnCliente();

        // GET api/values
        [HttpPost("ListaCliente")]
        //public string ListaCliente([FromBody] string value)
        public string ListaCliente()
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("ListaCliente");

                    string json = cli.ListaCliente();

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

        [HttpPost("ProcuraCliente")]
        //public string ListaCliente([FromBody] string value)
        public string ProcuraCliente([FromBody]mvChave mv)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest().StatusCode.ToString();
                }
                else
                {
                    lg.GeraLog("ProcuraCliente");

                    string json = cli.ProcuraCliente(mv.sChave);

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
