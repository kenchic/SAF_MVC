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
	public class ContratoController : Controller
	{
		private readonly ContratoNegocio objContrato = new ContratoNegocio();
        private readonly ListaPrecioNegocio objListaPrecio = new ListaPrecioNegocio();
        private readonly AgenteNegocio objAgente = new AgenteNegocio();

		public ActionResult ContratoListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objContrato.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objContrato.Listar());
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objContrato.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
				return PartialView(objContrato.Consultar(id));
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
		public ActionResult ContratoInsertar(ContratoModelo objInsertar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objContrato.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objContrato.Insertar(objInsertar);					
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objContrato.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objAgente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                ContratoModelo objEditar = objContrato.Consultar(id);
                ViewBag.ListaPrecio = Utilidades.ListaSeleccion(objListaPrecio.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaAgente = Utilidades.ListaSeleccion(objAgente.ListarActivos(), "Id", "Nombre", "-1", "No Aplica");
                return PartialView(objEditar);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ContratoEditar(ContratoModelo objEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objContrato.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objContrato.Editar(objEditar);
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objContrato.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
				{
					objContrato.Borrar(id);
				}
				return Json(objContrato.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ContratoController - Borrar");
				return View();
			}
		}
	}
}