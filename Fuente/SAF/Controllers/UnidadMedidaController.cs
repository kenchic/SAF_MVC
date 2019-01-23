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
	public class UnidadMedidaController : Controller
	{
		private readonly UnidadMedidaNegocio ObjUnidadMedida = new UnidadMedidaNegocio();

		public UnidadMedidaController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjUnidadMedida.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Contructor");
			}
		}

		public ActionResult UnidadMedidaListar()
		{
			try
			{
				return PartialView(ObjUnidadMedida.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Listar");
				return PartialView();
			}
		}

		public ActionResult UnidadMedidaConsultar(byte id)
		{
			try
			{
				UnidadMedidaModelo objElemento = ObjUnidadMedida.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Consultar");
				return PartialView();
			}
		}

		public ActionResult UnidadMedidaInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult UnidadMedidaInsertar(UnidadMedidaModelo objUnidadMedida)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjUnidadMedida.Insertar(objUnidadMedida);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Insertar");
				return View();
			}
		}

		public ActionResult UnidadMedidaEditar(byte id)
		{
			try
			{
				UnidadMedidaModelo objElemento = ObjUnidadMedida.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult UnidadMedidaEditar(UnidadMedidaModelo objUnidadMedida)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjUnidadMedida.Editar(objUnidadMedida);
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Editar");
				return View();
			}
		}


		public ActionResult UnidadMedidaBorrar(byte id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjUnidadMedida.Borrar(id);
				}
				return Json(ObjUnidadMedida.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Borrar");
				return View();
			}
		}
	}
}