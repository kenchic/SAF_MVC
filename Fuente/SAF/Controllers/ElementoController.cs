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
	public class ElementoController : Controller
	{
		private readonly ElementoNegocio objElemento = new ElementoNegocio();
        private readonly GrupoElementoNegocio objGrupoElemento = new GrupoElementoNegocio();
        private readonly UnidadMedidaNegocio objUnidadMedida = new UnidadMedidaNegocio();

		public ActionResult ElementoListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objElemento.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Listar");
				return PartialView();
			}
		}

		public ActionResult ElementoConsultar(int id)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objElemento.Consultar(id));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ElementoInsertar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                ViewBag.ListaGrupoElemento = Utilidades.ListaSeleccion(objGrupoElemento.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaUnidadMedida = Utilidades.ListaSeleccion(objUnidadMedida.ListarActivos(), "Id", "Nombre", "-1");
                return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ElementoInsertar(ElementoModelo objInsertar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objElemento.Insertar(objInsertar);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Insertar");
				return View();
			}
		}

		public ActionResult ElementoEditar(int id)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                VElementoModelo objEditar = objElemento.Consultar(id);
                ViewBag.ListaGrupoElemento = Utilidades.ListaSeleccion(objGrupoElemento.ListarActivos(), "Id", "Nombre", objEditar.idGrupoElemento.ToString());
                ViewBag.ListaUnidadMedida = Utilidades.ListaSeleccion(objUnidadMedida.ListarActivos(), "Id", "Nombre", objEditar.idUnidadMedida.ToString());
                return PartialView(objEditar);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ElementoEditar(ElementoModelo objEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objElemento.Editar(objEditar);
				}
				return Json("false");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Editar");
				return View();
			}
		}

		public ActionResult ElementoBorrar(int id)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
				{
					objElemento.Borrar(id);
				}
				return Json(objElemento.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Borrar");
				return View();
			}
		}
	}
}