using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
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
	public class BodegaController : Controller
	{
        private readonly ClienteNegocio objCliente = new ClienteNegocio();
        private readonly ProveedorNegocio objProveedor = new ProveedorNegocio();
        private readonly BodegaNegocio objBodega = new BodegaNegocio();

		public ActionResult BodegaListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objBodega.Listar());
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objBodega.Consultar(id));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Consultar");
				return PartialView();
			}
		}

		public ActionResult BodegaInsertar(string strModoExterno = "false")
		{
			try
			{
                TempData["ModoExterno"] = strModoExterno;
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objProveedor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                ViewBag.ListaCliente = Utilidades.ListaSeleccion(objCliente.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaProveedor = Utilidades.ListaSeleccion(objProveedor.ListarActivos(), "Id", "Nombre", "-1");
                return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult BodegaInsertar(BodegaModelo objInsertar)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objBodega.Insertar(objInsertar);
                }

                string strModoExterno = TempData["ModoExterno"].ToString();
                TempData.Remove("ModoExterno");

                if (strModoExterno.Equals("true"))
                {
                    return Json(objBodega.ListarActivos());
                }
                else
                {
                    return Json("false");
                }
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objProveedor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                VBodegaModelo objEditar = objBodega.Consultar(id);
                ViewBag.ListaCliente = Utilidades.ListaSeleccion(objCliente.ListarActivos(), "Id", "Nombre", objEditar.idCliente.ToString());
                ViewBag.ListaProveedor = Utilidades.ListaSeleccion(objProveedor.ListarActivos(), "Id", "Nombre", objEditar.idProveedor.ToString());
                return PartialView(objEditar);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult BodegaEditar(BodegaModelo objEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objBodega.Editar(objEditar);
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
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                if (ModelState.IsValid)
				{
					objBodega.Borrar(id);
				}
				return Json(objBodega.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Borrar");
				return View();
			}
		}
	}
}