using CoreGeneral.Modelos.SEG;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Utilidades;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using SAF.Api.Filters;
using SAF.Api.Helper;
using System;
using System.Collections.Generic;
using System.Linq;

namespace SAF.Api.Controllers
{
    [AutenticacionToken]
    [ApiController]
    [Route("api/[controller]")]
    public class UsuarioController : Controller
    {
        [HttpGet("Menu")]
        public IActionResult Menu()
        {
            try
            {
                string token = Request.Headers.First(x => x.Key == "autorizacion").Value;
                string json = Codificacion.DecoficarBase64String(token);
                var autenticacion = JsonConvert.DeserializeObject<AutenticacionModelo>(json);

                var parametros = new Dictionary<string, string>();
                parametros.Add("usuarioId", autenticacion.Usuario);

                string resultado = ClienteApi.GetRecurso(Configuracion.UrlApiSEG(), "Usuario/Menu", parametros, token);

                if (!string.IsNullOrEmpty(resultado))
                {
                    var usuarioMenu = JsonConvert.DeserializeObject<List<UsuarioMenuModelo>>(resultado);
                    return Ok(usuarioMenu);
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "UsuarioController - UsuarioMenu");
                return NotFound(ex.ToString());
            }
        }
    }
}
