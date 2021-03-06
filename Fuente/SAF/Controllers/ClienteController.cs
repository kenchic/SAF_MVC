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
	public class ClienteController : Controller
	{
		private readonly ClienteNegocio objCliente = new ClienteNegocio();
        private readonly CiudadNegocio objCiudad = new CiudadNegocio();

        public ActionResult ClienteListar()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objCliente.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Listar");
				return PartialView();
			}
		}

		public ActionResult ClienteConsultar(int id)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objCliente.Consultar(id));
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ClienteInsertar(string strModoExterno = "false")
		{
			try
			{
                TempData["ModoExterno"] = strModoExterno;
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                ViewBag.ListaCiudad = Utilidades.ListaSeleccion(objCiudad.ListarActivos(), "Id", "Nombre", "-1");
                return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ClienteInsertar(ClienteModelo objInsertar)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                
                if (ModelState.IsValid)
				{
					objCliente.Insertar(objInsertar);					
				}

                string strModoExterno = TempData["ModoExterno"].ToString();
                TempData.Remove("ModoExterno");

                if (strModoExterno.Equals("true"))
                {
                    return Json(objCliente.ListarActivos());
                }
                else
                {
                    return Json("false");
                }
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Insertar");
				return View();
			}
		}

		public ActionResult ClienteEditar(int id)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();                
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                VClienteModelo objEditar = objCliente.Consultar(id);
                ViewBag.ListaCiudad = Utilidades.ListaSeleccion(objCiudad.ListarActivos(), "Id", "Nombre", objEditar.idCiudad.ToString());
                return PartialView(objEditar);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ClienteEditar(ClienteModelo objEditar)
		{
			try
			{
				if (ModelState.IsValid)
				{
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objCliente.Editar(objEditar);
				}
				return Json("false");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Editar");
				return View();
			}
		}

		public ActionResult ClienteBorrar(int id)
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
				{
					objCliente.Borrar(id);
				}
				return Json(objCliente.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Borrar");
				return View();
			}
		}
	}
}