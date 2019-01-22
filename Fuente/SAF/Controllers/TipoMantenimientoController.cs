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
	public class TipoMantenimientoController : Controller
	{
		private readonly TipoMantenimientoNegocio ObjTipoMantenimiento = new TipoMantenimientoNegocio();

		public TipoMantenimientoController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjTipoMantenimiento.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Contructor");
			}
		}

		public ActionResult TipoMantenimientoListar()
		{
			try
			{
				return PartialView(ObjTipoMantenimiento.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Listar");
				return PartialView();
			}
		}

		public ActionResult TipoMantenimientoConsultar(int id)
		{
			try
			{
				TipoMantenimientoModelo objElemento = ObjTipoMantenimiento.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Consultar");
				return PartialView();
			}
		}

		public ActionResult TipoMantenimientoInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult TipoMantenimientoInsertar(TipoMantenimientoModelo objTipoMantenimiento)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjTipoMantenimiento.Insertar(objTipoMantenimiento);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Insertar");
				return View();
			}
		}

		public ActionResult TipoMantenimientoEditar(int id)
		{
			try
			{
				TipoMantenimientoModelo objElemento = ObjTipoMantenimiento.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult TipoMantenimientoEditar(TipoMantenimientoModelo objTipoMantenimiento)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjTipoMantenimiento.Editar(objTipoMantenimiento);
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Editar");
				return View();
			}
		}


		public ActionResult TipoMantenimientoBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjTipoMantenimiento.Borrar(id);
				}
				return Json(ObjTipoMantenimiento.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Borrar");
				return View();
			}
		}
	}
}