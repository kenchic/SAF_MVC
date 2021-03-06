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
	public class UnidadMedidaController : Controller
	{
		private readonly UnidadMedidaNegocio objUnidadMedida = new UnidadMedidaNegocio();

		public ActionResult UnidadMedidaListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objUnidadMedida.Listar());
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
				return PartialView(objUnidadMedida.Consultar(id));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Consultar");
				return PartialView();
			}
		}

		public ActionResult UnidadMedidaInsertar(string strModoExterno = "false")
		{
			try
			{
                TempData["ModoExterno"] = strModoExterno;
                return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult UnidadMedidaInsertar(UnidadMedidaModelo objInsertar)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objUnidadMedida.Insertar(objInsertar);
                }
                string strModoExterno = TempData["ModoExterno"].ToString();
                TempData.Remove("ModoExterno");

                if (strModoExterno.Equals("true"))
                {
                    return Json(objUnidadMedida.ListarActivos());
                }
                else
                {
                    return Json("false");
                }
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objUnidadMedida.Consultar(id));
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult UnidadMedidaEditar(UnidadMedidaModelo objEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objUnidadMedida.Editar(objEditar);
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objUnidadMedida.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
				{
					objUnidadMedida.Borrar(id);
				}
				return Json(objUnidadMedida.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UnidadMedidaController - Borrar");
				return View();
			}
		}
	}
}