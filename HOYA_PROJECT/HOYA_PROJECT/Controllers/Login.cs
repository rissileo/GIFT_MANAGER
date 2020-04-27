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
    [Route("api/Login")]
    [ApiController]
    public class Login : ControllerBase
    {

        //static readonly JsonSerializer _serializer = new JsonSerializer();
        //static readonly HttpClient _client = new HttpClient();
        Log lg = new Log();
        bnLogin log = new bnLogin();

        // GET api/values
        [HttpPost("ValidaLogin")]
        //public string ListaCliente([FromBody] string value)
        public string ValidaLogin([FromBody]mvLogin mv)
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

                    string json = log.ValidaLogin(mv.sLogin, mv.sSenha);

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
