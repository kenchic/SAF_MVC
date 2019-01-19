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
	public class ProveedorController : Controller
	{
		private readonly ProveedorNegocio ObjProveedor = new ProveedorNegocio();

		public ProveedorController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjProveedor.SetConexion(IConfiguracion["BD_SQL_SAF"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Contructor");
			}
		}

		public ActionResult ProveedorListar()
		{
			try
			{
				return PartialView(ObjProveedor.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Listar");
				return PartialView();
			}
		}

		public ActionResult ProveedorConsultar(int id)
		{
			try
			{
				ProveedorModelo objElemento = ObjProveedor.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ProveedorInsertar()
		{
			try
			{
				return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ProveedorInsertar(ProveedorModelo objProveedor)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjProveedor.Insertar(objProveedor);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Insertar");
				return View();
			}
		}

		public ActionResult ProveedorEditar(int id)
		{
			try
			{
				ProveedorModelo objElemento = ObjProveedor.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ProveedorEditar(ProveedorModelo objProveedor)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjProveedor.Editar(objProveedor);
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Editar");
				return View();
			}
		}


		public ActionResult ProveedorBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjProveedor.Borrar(id);
				}
				return Json(ObjProveedor.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ProveedorController - Borrar");
				return View();
			}
		}
	}
}