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
	public class AgenteController : Controller
	{
		private readonly AgenteNegocio ObjAgente = new AgenteNegocio();

		public AgenteController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjAgente.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Contructor");
			}
		}

		public ActionResult AgenteListar()
		{
			try
			{
				return PartialView(ObjAgente.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Listar");
				return PartialView();
			}
		}

		public ActionResult AgenteConsultar(int id)
		{
			try
			{
				AgenteModelo objElemento = ObjAgente.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Consultar");
				return PartialView();
			}
		}

		public ActionResult AgenteInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult AgenteInsertar(AgenteModelo objAgente)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjAgente.Insertar(objAgente);
					ViewBag.AlertMsg = "Datos insertados correctamente.";
				}

				return RedirectToActionPreserveMethod("UsuarioDashBoard", "Usuario");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Insertar");
				return View();
			}
		}

		public ActionResult AgenteEditar(int id)
		{
			try
			{
				AgenteModelo objElemento = ObjAgente.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult AgenteEditar(AgenteModelo objAgente)
		{
			try
			{
				ObjAgente.Editar(objAgente);
				return RedirectToActionPreserveMethod("UsuarioDashBoard","Usuario");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Editar");
				return View();
			}
		}

		public ActionResult AgenteBorrar(int id)
		{
			try
			{
				if (ObjAgente.Borrar(id))
				{
					ViewBag.AlertMsg = "Datos eliminados correctamente";
				}
				return RedirectToActionPreserveMethod("UsuarioDashBoard", "Usuario");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Borrar");
				return View();
			}
		}
	}
}