using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Modelos.SEG;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using SEG.Api.Datos;
using SEG.Api.Filters;
using SEG.Api.Modelos;

namespace SEG.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AutenticacionController : Controller
    {
        private readonly UsuarioDatos usuarioDato = new UsuarioDatos();
        private readonly AutenticacionDatos autenticacionDato = new AutenticacionDatos();

        public AutenticacionController(IConfiguration IConfiguracion)
        {
            try
            {
                usuarioDato.Configuracion = IConfiguracion;
                autenticacionDato.Configuracion = IConfiguracion;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AutenticacionController - Constructor");
            }
        }

        [HttpPost("Autenticar")]
        public IActionResult Autenticar(Credencial credencial)
        {
            try
            {                
                var usuario = new UsuarioModelo { 
                    Usuario = credencial.Usuario,
                    Clave = credencial.Clave
                };

                if (usuarioDato.Autenticar(ref usuario))
                {
                    string token = autenticacionDato.CrearToken(usuario);
                    return Ok(token);
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AutenticacionController - Autenticacion");
                return NotFound(ex.ToString());
            }
        }

        [AutenticacionToken]
        [HttpGet("VerificarToken")]
        public IActionResult VerificarToken()
        {
            try
            {
                if (ControllerContext.ModelState.IsValid)
                {
                    return Ok();
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AutenticacionController - ValidarAutenticacion");
                return NotFound(ex.ToString());
            }
        }
    }
}
