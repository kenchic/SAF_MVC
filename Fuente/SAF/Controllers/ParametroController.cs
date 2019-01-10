using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using CoreCore.Modelos;
using CoreCore.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;

namespace Core.Controllers
{
	[Authorize]
	public class ParametroController : Controller
	{
		private readonly ParametroNegocio ObjParametro = new ParametroNegocio();

		public ParametroController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjParametro.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Contructor");
			}
		}

		public ActionResult ParametroListar()
		{
			try
			{
				return PartialView(ObjParametro.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Listar");
				return PartialView();
			}
		}

		public ActionResult ParametroConsultar(string codigo)
		{
			try
			{
				ParametroModelo objElemento = ObjParametro.Consultar(codigo);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ParametroInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ParametroInsertar(ParametroModelo objParametro)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjParametro.Insertar(objParametro);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Insertar");
				return View();
			}
		}

		public ActionResult ParametroEditar(string codigo)
		{
			try
			{
				ParametroModelo objElemento = ObjParametro.Consultar(codigo);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ParametroEditar(ParametroModelo objParametro)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjParametro.Editar(objParametro);
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Editar");
				return View();
			}
		}


		public ActionResult ParametroBorrar(string codigo)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjParametro.Borrar(codigo);
				}
				return Json(ObjParametro.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ParametroController - Borrar");
				return View();
			}
		}
	}
}