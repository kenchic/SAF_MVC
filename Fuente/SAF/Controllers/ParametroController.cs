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
	public class ParametroController : Controller
	{
		private readonly ParametroNegocio objParametro = new ParametroNegocio();

		public ActionResult ParametroListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objParametro.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objParametro.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Listar");
				return PartialView();
			}
		}

		public ActionResult ParametroConsultar(string codigo)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objParametro.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objParametro.Consultar(codigo, string.Empty));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ParametroInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ParametroInsertar(ParametroModelo objInsertar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objParametro.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objParametro.Insertar(objInsertar);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Insertar");
				return View();
			}
		}

		public ActionResult ParametroEditar(string codigo)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objParametro.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objParametro.Consultar(codigo, string.Empty));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ParametroEditar(ParametroModelo objEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objParametro.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objParametro.Editar(objEditar);
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Editar");
				return View();
			}
		}

		public ActionResult ParametroBorrar(string codigo)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objParametro.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
				{
					objParametro.Borrar(codigo);
				}
				return Json(objParametro.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Borrar");
				return View();
			}
		}
	}
}