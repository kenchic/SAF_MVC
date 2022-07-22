using CoreGeneral.Modelos.GES;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Utilidades;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using SAF.Api.Helper;
using System;
using System.Collections.Generic;

namespace SAF.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SistemaController : Controller
    {
        [HttpGet("Version")]
        public IActionResult Version()
        {
            try
            {
                var parametros = new Dictionary<string, string>();
                parametros.Add("Sistema", "SAF");
                string resultado = ClienteApi.GetRecurso(Configuracion.UrlApiGES(), "Sistema/Version", parametros);
                if (!string.IsNullOrEmpty(resultado))
                {
                    var sistema = JsonConvert.DeserializeObject<SistemaModelo>(resultado);
                    return Ok(sistema);
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SistemaController - Version");
                return NotFound(ex.ToString());
            }
        }
    }
}
