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
	public class TipoMantenimientoController : Controller
	{
		private readonly TipoMantenimientoNegocio objTipoMantenimiento = new TipoMantenimientoNegocio();

		public ActionResult TipoMantenimientoListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objTipoMantenimiento.Listar());
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
				return PartialView(objTipoMantenimiento.Consultar(id));
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
		public ActionResult TipoMantenimientoInsertar(TipoMantenimientoModelo objInsertar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objTipoMantenimiento.Insertar(objInsertar);					
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
				return PartialView(objTipoMantenimiento.Consultar(id));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult TipoMantenimientoEditar(TipoMantenimientoModelo objTipoEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objTipoMantenimiento.Editar(objTipoEditar);
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
				{
					objTipoMantenimiento.Borrar(id);
				}
				return Json(objTipoMantenimiento.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Borrar");
				return View();
			}
		}
	}
}