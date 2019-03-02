using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;

namespace CoreSAF.Controllers
{
	[Authorize]
	public class ProyectoController : Controller
	{
		private readonly ProyectoNegocio ObjProyecto = new ProyectoNegocio();
        private readonly CiudadNegocio ObjCiudad = new CiudadNegocio();
        private readonly ClienteNegocio ObjCliente = new ClienteNegocio();

        public ProyectoController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjProyecto.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjCiudad.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjCliente.SetConexion(IConfiguracion["BD_SQL_SAF"]);
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Contructor");
			}
		}

		public ActionResult ProyectoListar()
		{
			try
			{
				return PartialView(ObjProyecto.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Listar");
				return PartialView();
			}
		}

		public ActionResult ProyectoConsultar(int id)
		{
			try
			{
				VProyectoModelo objElemento = ObjProyecto.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ProyectoInsertar()
		{
			try
			{
                ViewBag.ListaCiudad = Utilidades.ListaSeleccion(ObjCiudad.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaCliente = Utilidades.ListaSeleccion(ObjCliente.ListarActivos(), "Id", "Nombre", "-1");
                ProyectoModelo objProyecto = new ProyectoModelo();
                objProyecto.Activo = true;
                objProyecto.Estado = 1;
                objProyecto.Fecha = DateTime.Now;
                objProyecto.Id = 0;
                return PartialView(objProyecto);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ProyectoInsertar(ProyectoModelo objProyecto)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjProyecto.Insertar(objProyecto);					
				}
                return Json("false");
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Insertar");
				return View();
			}
		}

		public ActionResult ProyectoEditar(int id)
		{
			try
			{
                ViewBag.ListaCiudad = Utilidades.ListaSeleccion(ObjCiudad.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaCliente = Utilidades.ListaSeleccion(ObjCliente.ListarActivos(), "Id", "Nombre", "-1");
                VProyectoModelo objElemento = ObjProyecto.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ProyectoEditar(ProyectoModelo objProyecto)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjProyecto.Editar(objProyecto);
				}
                return Json("false");
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Editar");
				return View();
			}
		}


		public ActionResult ProyectoBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjProyecto.Borrar(id);
				}
				return Json(ObjProyecto.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Borrar");
				return View();
			}
		}
	}
}