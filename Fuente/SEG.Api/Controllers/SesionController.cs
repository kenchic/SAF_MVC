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
    public class SesionController : Controller
    {
        private readonly SesionDatos sesionDatos = new SesionDatos();
        public SesionController(IConfiguration IConfiguracion)
        {
            try
            {
                sesionDatos.Configuracion = IConfiguracion;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SesionController - Constructor");
            }
        }

        [AutenticacionToken]
        [HttpPost("Insertar")]
        public ActionResult Insertar(SesionModelo sesion)
        {
            try
            {
                sesion.FechaInicio = DateTime.Now;
                sesionDatos.Insertar(sesion);
                return Ok();
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SesionController - Constructor");
                return BadRequest();
            }
        }
    }
}
