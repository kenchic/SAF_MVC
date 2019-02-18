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
	public class ClienteController : Controller
	{
		private readonly ClienteNegocio ObjCliente = new ClienteNegocio();
        private readonly CiudadNegocio ObjCiudad = new CiudadNegocio();

        public ClienteController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjCliente.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjCiudad.SetConexion(IConfiguracion["BD_SQL_SAF"]);
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Contructor");
			}
		}

		public ActionResult ClienteListar()
		{
			try
			{                
                return PartialView(ObjCliente.Listar());
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
				VClienteModelo objElemento = ObjCliente.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ClienteInsertar()
		{
			try
			{
                ViewBag.ListaCiudad = Utilidades.ListaSeleccion(ObjCiudad.ListarActivos(), "Id", "Nombre", "-1");
                return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ClienteInsertar(ClienteModelo objCliente)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjCliente.Insertar(objCliente);					
				}
				return Json("false");
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
				VClienteModelo objElemento = ObjCliente.Consultar(id);
                ViewBag.ListaCiudad = Utilidades.ListaSeleccion(ObjCiudad.ListarActivos(), "Id", "Nombre", objElemento.idCiudad.ToString());
                return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ClienteEditar(ClienteModelo objCliente)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjCliente.Editar(objCliente);
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
				if (ModelState.IsValid)
				{
					ObjCliente.Borrar(id);
				}
				return Json(ObjCliente.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ClienteController - Borrar");
				return View();
			}
		}
	}
}