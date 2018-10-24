///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//////  AgenteController
//////  SAF - Integral Solutions SAS
//////  Implementacion Controlador:	Agente
//////  Creacion:      				23/07/2018
//////  Autor: 						German Alvarez
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

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

		public ActionResult Listar()
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

		public ActionResult Consultar(int id)
		{
			try
			{
				AgenteModelo objElemento = ObjAgente.Consultar(id);
				return View(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Consultar");
				return View();
			}
		}

		public ActionResult Insertar()
		{
			try
			{
				return View();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Insertar");
				return View();
			}
		}

		[HttpPost]
		public ActionResult Insertar(AgenteModelo objAgente)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjAgente.Insertar(objAgente);
					ViewBag.AlertMsg = "Datos insertados correctamente.";
				}

				return RedirectToAction("ListarAgente");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Insertar");
				return View();
			}
		}

		public ActionResult Editar(int id)
		{
			try
			{
				AgenteModelo objElemento = ObjAgente.Consultar(id);
				return View(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Editar");
				return View();
			}
		}

		[HttpPost]
		public ActionResult Editar(AgenteModelo objAgente)
		{
			try
			{
				ObjAgente.Editar(objAgente);
				return RedirectToAction("Listar");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Editar");
				return View();
			}
		}

		public ActionResult Borrar(int id)
		{
			try
			{
				if (ObjAgente.Borrar(id))
				{
					ViewBag.AlertMsg = "Datos eliminados correctamente";
				}
				return RedirectToAction("Listar");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Borrar");
				return RedirectToAction("Listar");
			}
		}

		public ActionResult inicio()
		{
			return PartialView();
		}
	}
}