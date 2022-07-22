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
    public class LoginController : Controller
    {
        [HttpGet("Ingresar")]
        public IActionResult Login()
        {
            try
            {
                string token = Request.Headers.First(x => x.Key == "autorizacion").Value;
                string json = Codificacion.DecoficarBase64String(token);
                var autenticacion = JsonConvert.DeserializeObject<AutenticacionModelo>(json);

                var parametros = new Dictionary<string, string>();
                parametros.Add("usuarioId", autenticacion.Usuario);

                string resultado = ClienteApi.GetRecurso(Configuracion.UrlApiSEG(), "Usuario/Consultar", parametros, token);

                if (!string.IsNullOrEmpty(resultado))
                {
                    var usuario = JsonConvert.DeserializeObject<UsuarioModelo>(resultado);
                    SesionModelo sesion = new SesionModelo
                    {
                        Usuario = usuario,
                        Token = token
                    };

                    ClienteApi.PostRecursoAsync(Configuracion.UrlApiSEG(), "Sesion/Insertar", sesion, token);
                    return Ok(usuario);
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "LoginController - Login");
                return NotFound(ex.ToString());
            }
        }
    }
}
