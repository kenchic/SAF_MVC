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
	public class ConductorController : Controller
	{
		private readonly ConductorNegocio ObjConductor = new ConductorNegocio();

		public ConductorController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjConductor.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Contructor");
			}
		}

		public ActionResult ConductorListar()
		{
			try
			{
				return PartialView(ObjConductor.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Listar");
				return PartialView();
			}
		}

		public ActionResult ConductorConsultar(int id)
		{
			try
			{
				ConductorModelo objElemento = ObjConductor.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ConductorInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ConductorInsertar(ConductorModelo objConductor)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjConductor.Insertar(objConductor);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Insertar");
				return View();
			}
		}

		public ActionResult ConductorEditar(int id)
		{
			try
			{
				ConductorModelo objElemento = ObjConductor.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ConductorEditar(ConductorModelo objConductor)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjConductor.Editar(objConductor);
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Editar");
				return View();
			}
		}


		public ActionResult ConductorBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjConductor.Borrar(id);
				}
				return Json(ObjConductor.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Borrar");
				return View();
			}
		}
	}
}