using System;
using Microsoft.AspNetCore.Mvc;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Negocios;
using Microsoft.AspNetCore.Authorization;
using CoreSEG.Negocios;
using CoreSEG.Modelos;
using CoreGES.Negocios;
using CoreGeneral;

namespace SAF.Controllers
{
	[Authorize]
	public class ClienteController : Controller
	{
		private readonly ClienteNegocio objCliente = new ClienteNegocio();
        private readonly CatalogoNegocio objCiudad = new CatalogoNegocio();

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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Listar");
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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ClienteInsertar(string ModoExternoCliente = "false")
		{
			try
			{
                TempData["ModoExternoCliente"] = ModoExternoCliente;
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                ViewBag.ListaCiudad = UtilidadesNegocio.ListaSeleccion(objCiudad.ListarDetalleActivos("CIUDADES"), "Id", "Nombre", "-1");
                return PartialView();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Insertar");
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

                string ModoExternoCliente = TempData["ModoExternoCliente"].ToString();
                TempData.Remove("ModoExternoCliente");

                if (ModoExternoCliente.Equals("true"))
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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Insertar");
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
                ViewBag.ListaCiudad = UtilidadesNegocio.ListaSeleccion(objCiudad.ListarDetalleActivos("CIUDADES"), "Id", "Nombre", objEditar.idCiudad.ToString());
                return PartialView(objEditar);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Editar");
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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Editar");
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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Borrar");
				return View();
			}
		}
	}
}