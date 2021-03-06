using System;
using Microsoft.AspNetCore.Mvc;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;
using CoreSEG.Negocios;
using CoreSEG.Modelos;

namespace SAF.Controllers
{
	[Authorize]
	public class ConductorController : Controller
	{
		private readonly ConductorNegocio objConductor = new ConductorNegocio();

		public ActionResult ConductorListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objConductor.Listar());
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
				return PartialView(objConductor.Consultar(id));
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
		public ActionResult ConductorInsertar(ConductorModelo objInsertar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objConductor.Insertar(objInsertar);					
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
				return PartialView(objConductor.Consultar(id));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ConductorEditar(ConductorModelo objEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objConductor.Editar(objEditar);
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
				{
					objConductor.Borrar(id);
				}
				return Json(objConductor.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Borrar");
				return View();
			}
		}
	}
}