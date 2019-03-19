using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;

namespace SAF.Controllers
{
	[Authorize]
	public class ContratoController : Controller
	{
		private readonly ContratoNegocio ObjContrato = new ContratoNegocio();
        private readonly ListaPrecioNegocio ObjListaPrecio = new ListaPrecioNegocio();
        private readonly AgenteNegocio ObjAgente = new AgenteNegocio();

        public ContratoController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjContrato.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjListaPrecio.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjAgente.SetConexion(IConfiguracion["BD_SQL_SAF"]);
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Contructor");
			}
		}

		public ActionResult ContratoListar()
		{
			try
			{
				return PartialView(ObjContrato.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Listar");
				return PartialView();
			}
		}

		public ActionResult ContratoConsultar(int id)
		{
			try
			{
				ContratoModelo objElemento = ObjContrato.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ContratoInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ContratoInsertar(ContratoModelo objContrato)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjContrato.Insertar(objContrato);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Insertar");
				return View();
			}
		}

		public ActionResult ContratoEditar(int id)
		{
			try
			{
				ContratoModelo objElemento = ObjContrato.Consultar(id);
                ViewBag.ListaPrecio = Utilidades.ListaSeleccion(ObjListaPrecio.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaAgente = Utilidades.ListaSeleccion(ObjAgente.ListarActivos(), "Id", "Nombre", "-1", "No Aplica");
                return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ContratoEditar(ContratoModelo objContrato)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjContrato.Editar(objContrato);
				}
				return Json("false");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Editar");
				return View();
			}
		}


		public ActionResult ContratoBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjContrato.Borrar(id);
				}
				return Json(ObjContrato.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Borrar");
				return View();
			}
		}
	}
}