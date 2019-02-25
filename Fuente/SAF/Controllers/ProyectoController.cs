using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using CoreCoreSAF.Modelos;
using CoreCoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;

namespace CoreSAF.Controllers
{
	[Authorize]
	public class ProyectoController : Controller
	{
		private readonly ProyectoNegocio ObjProyecto = new ProyectoNegocio();

		public ProyectoController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjProyecto.SetConexion(IConfiguracion["BD_SQL_SAF"]);
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
				ProyectoModelo objElemento = ObjProyecto.Consultar(id);
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
				return PartialView();
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
				return Json("{ success: 'true'}");
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
				ProyectoModelo objElemento = ObjProyecto.Consultar(id);
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
				return Json("{ success: 'true'}");
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