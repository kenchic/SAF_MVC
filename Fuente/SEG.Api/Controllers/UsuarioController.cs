using CoreGeneral.Modelos.SEG;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SEG.Api.Datos;
using SEG.Api.Filters;
using System;

namespace SEG.Api.Controllers
{
    [AutenticacionToken]
    [ApiController]
    [Route("api/[controller]")]
    public class UsuarioController : Controller
    {
        private readonly UsuarioDatos usuarioDatos = new UsuarioDatos();
        public UsuarioController(IConfiguration IConfiguracion)
        {
            try
            {
                usuarioDatos.Configuracion = IConfiguracion;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SesionController - Constructor");
            }
        }
        
        [HttpGet("Consultar")]
        public ActionResult Consultar(string usuarioId)
        {
            try
            {
                UsuarioModelo usuario = new UsuarioModelo
                {
                    Id = usuarioId
                };
                return Ok(usuarioDatos.Consultar(usuario));
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SesionController - Constructor");
                return BadRequest();
            }
        }

        [HttpGet("Menu")]
        public ActionResult Menu(string usuarioId)
        {
            try
            {
                UsuarioModelo usuario = new UsuarioModelo
                {
                    Id = usuarioId
                };
                return Ok(usuarioDatos.ListarMenu(usuario));
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SesionController - Constructor");
                return BadRequest();
            }
        }
    }
}
