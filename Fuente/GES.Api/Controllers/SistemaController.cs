using System;
using Microsoft.AspNetCore.Mvc;
using CoreGeneral.Recursos;
using CoreGeneral.Negocios;
using CoreGeneral.Modelos.GES;
using GES.Api.Datos;
using Microsoft.Extensions.Configuration;

namespace GES.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SistemaController : Controller
    {
        private readonly SistemaDatos sistemaDato = new SistemaDatos();

        public SistemaController(IConfiguration IConfiguracion)
        {
            try
            {
                sistemaDato.Configuracion = IConfiguracion;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SistemaController - Constructor");
            }
        }

        [HttpGet("Version")]
        public IActionResult Version(string sistema)
        {
            try
            {                
                var objSistema = sistemaDato.Consultar(new SistemaModelo { Id = sistema });
                if (objSistema != null)
                { 
                    return Ok(objSistema); 
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SistemaController - Version HttpGet");
                ViewBag.Notificacion = MensajeNegocio.CrearNotificacion(Constantes.MensajeError, ex.Message);
                return NotFound(ex.ToString());
            }
        }
    }
}