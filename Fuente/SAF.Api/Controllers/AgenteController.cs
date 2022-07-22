using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SAF.Api.Datos;
using SAF.Api.Filters;
using System;

namespace SAF.Api.Controllers
{
    [AutenticacionToken]
    [ApiController]
    [Route("api/[controller]")]
    public class AgenteController : Controller
    {
        private readonly AgenteDatos agenteDatos = new AgenteDatos();
        public AgenteController(IConfiguration IConfiguracion)
        {
            try
            {
                agenteDatos.Configuracion = IConfiguracion;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SesionController - Constructor");
            }
        }

        [HttpGet("ListarTodos")]
        public IActionResult ListarTodos()
        {
            var listaAgente = agenteDatos.ListarTodos();
            if (listaAgente != null && listaAgente.Count > 0 )
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("ListarActivos")]
        public IActionResult ListarActivos()
        {
            var listaAgente = agenteDatos.ListarActivos();
            if (listaAgente != null && listaAgente.Count > 0)
            {
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }
    }
}