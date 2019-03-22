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
	public class ElementoController : Controller
	{
		private readonly ElementoNegocio ObjElemento = new ElementoNegocio();
        private readonly GrupoElementoNegocio ObjGrupoElemento = new GrupoElementoNegocio();
        private readonly UnidadMedidaNegocio ObjUnidadMedida = new UnidadMedidaNegocio();

        public ElementoController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjElemento.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjGrupoElemento.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjUnidadMedida.SetConexion(IConfiguracion["BD_SQL_SAF"]);
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Contructor");
			}
		}

		public ActionResult ElementoListar()
		{
			try
			{
				return PartialView(ObjElemento.Listar());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Listar");
				return PartialView();
			}
		}

		public ActionResult ElementoConsultar(int id)
		{
			try
			{
				VElementoModelo objElemento = ObjElemento.Consultar(id);
				return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Consultar");
				return PartialView();
			}
		}

		public ActionResult ElementoInsertar()
		{
			try
			{
                ViewBag.ListaGrupoElemento = Utilidades.ListaSeleccion(ObjGrupoElemento.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaUnidadMedida = Utilidades.ListaSeleccion(ObjUnidadMedida.ListarActivos(), "Id", "Nombre", "-1");
                return PartialView();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Insertar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ElementoInsertar(ElementoModelo objElemento)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjElemento.Insertar(objElemento);					
				}
				return Json("{ success: 'true'}");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Insertar");
				return View();
			}
		}

		public ActionResult ElementoEditar(int id)
		{
			try
			{
				VElementoModelo objElemento = ObjElemento.Consultar(id);
                ViewBag.ListaGrupoElemento = Utilidades.ListaSeleccion(ObjGrupoElemento.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaUnidadMedida = Utilidades.ListaSeleccion(ObjUnidadMedida.ListarActivos(), "Id", "Nombre", "-1");
                return PartialView(objElemento);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Editar");
				return PartialView();
			}
		}

		[HttpPost]
		public ActionResult ElementoEditar(ElementoModelo objElemento)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjElemento.Editar(objElemento);
				}
				return Json("false");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Editar");
				return View();
			}
		}


		public ActionResult ElementoBorrar(int id)
		{
			try
			{
				if (ModelState.IsValid)
				{
					ObjElemento.Borrar(id);
				}
				return Json(ObjElemento.Listar().ToString());
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ElementoController - Borrar");
				return View();
			}
		}
	}
}