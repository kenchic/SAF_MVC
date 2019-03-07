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
	public class BodegaController : Controller
	{
		private readonly BodegaNegocio ObjBodega = new BodegaNegocio();

		public BodegaController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjBodega.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Contructor");
			}
		}

		public ActionResult BodegaListar()
		{
			try
			{
				return PartialView(ObjBodega.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Listar");
				return PartialView();
			}
		}

		public ActionResult BodegaConsultar(int id)
		{
			try
			{
				BodegaModelo objElemento = ObjBodega.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Consultar");
				return PartialView();
			}
		}

		public ActionResult BodegaInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult BodegaInsertar(BodegaModelo objBodega)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjBodega.Insertar(objBodega);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Insertar");
				return View();
			}
		}

		public ActionResult BodegaEditar(int id)
		{
			try
			{
				BodegaModelo objElemento = ObjBodega.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult BodegaEditar(BodegaModelo objBodega)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjBodega.Editar(objBodega);
				}
				return Json("false");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Editar");
				return View();
			}
		}


		public ActionResult BodegaBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjBodega.Borrar(id);
				}
				return Json(ObjBodega.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Borrar");
				return View();
			}
		}
	}
}