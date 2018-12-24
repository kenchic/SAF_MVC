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
	public class CiudadController : Controller
	{
		private readonly CiudadNegocio ObjCiudad = new CiudadNegocio();

		public CiudadController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjCiudad.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Contructor");
			}
		}

		public ActionResult CiudadListar()
		{
			try
			{
				return PartialView(ObjCiudad.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Listar");
				return PartialView();
			}
		}

		public ActionResult CiudadConsultar(int id)
		{
			try
			{
				CiudadModelo objElemento = ObjCiudad.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Consultar");
				return PartialView();
			}
		}

		public ActionResult CiudadInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult CiudadInsertar(CiudadModelo objCiudad)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjCiudad.Insertar(objCiudad);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Insertar");
				return View();
			}
		}

		public ActionResult CiudadEditar(int id)
		{
			try
			{
				CiudadModelo objElemento = ObjCiudad.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult CiudadEditar(CiudadModelo objCiudad)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjCiudad.Editar(objCiudad);
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Editar");
				return View();
			}
		}


		public ActionResult CiudadBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjCiudad.Borrar(id);
				}
				return Json(ObjCiudad.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Borrar");
				return View();
			}
		}
	}
}