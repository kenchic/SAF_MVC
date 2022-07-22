using System;
using Microsoft.AspNetCore.Mvc;
using CoreGeneral.Modelos.SAF;
using CoreGeneral.Recursos;
using CoreGeneral.Negocios;
using Microsoft.AspNetCore.Authorization;
using CoreGeneral.Modelos.SEG;

namespace SAF.Controllers
{
	[Authorize]
	public class BodegaController : Controller
	{
  //      private readonly ProyectoNegocio objProyecto = new ProyectoNegocio();
  //      private readonly ProveedorNegocio objProveedor = new ProveedorNegocio();
  //      private readonly BodegaNegocio objBodega = new BodegaNegocio();

		//public ActionResult BodegaListar()
		//{
		//	try
		//	{
  //              SesionNegocio objSesionNegocio = new SesionNegocio();
  //              objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
  //              return PartialView(objBodega.Listar());
		//	}
		//	catch (Exception ex)
		//	{
		//		MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Listar");
		//		return PartialView();
		//	}
		//}

		//public ActionResult BodegaConsultar(int id)
		//{
		//	try
		//	{
  //              SesionNegocio objSesionNegocio = new SesionNegocio();
  //              objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
  //              return PartialView(objBodega.Consultar(id));
		//	}
		//	catch (Exception ex)
		//	{
		//		MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Consultar");
		//		return PartialView();
		//	}
		//}

		//public ActionResult BodegaInsertar(string strModoExterno = "false")
		//{
		//	try
		//	{
  //              TempData["ModoExterno"] = strModoExterno;
  //              SesionNegocio objSesionNegocio = new SesionNegocio();
		//		objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
  //              objProveedor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
  //              ViewBag.ListaCliente = UtilidadesNegocio.ListaSeleccion(objProyecto.ListarActivos(), "Id", "Nombre", "-1");
  //              ViewBag.ListaProveedor = UtilidadesNegocio.ListaSeleccion(objProveedor.ListarActivos(), "Id", "Nombre", "-1");
  //              return PartialView();
		//	}
		//	catch (Exception ex)
		//	{
		//		MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Insertar");
		//		return PartialView();
		//	}
		//}

		//[HttpPost]
		//public ActionResult BodegaInsertar(BodegaModelo objInsertar)
		//{
		//	try
		//	{
  //              SesionNegocio objSesionNegocio = new SesionNegocio();
  //              objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
  //              if (ModelState.IsValid)
  //              {
  //                  objBodega.Insertar(objInsertar);
  //              }

  //              string strModoExterno = TempData["ModoExterno"].ToString();
  //              TempData.Remove("ModoExterno");

  //              if (strModoExterno.Equals("true"))
  //              {
  //                  return Json(objBodega.ListarActivos());
  //              }
  //              else
  //              {
  //                  return Json("false");
  //              }
  //          }
		//	catch (Exception ex)
		//	{
		//		MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Insertar");
		//		return View();
		//	}
		//}

		//public ActionResult BodegaEditar(int id)
		//{
		//	try
		//	{
  //              SesionNegocio objSesionNegocio = new SesionNegocio();
  //              objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
		//		objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
  //              objProveedor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

  //              VBodegaModelo objEditar = objBodega.Consultar(id);
  //              ViewBag.ListaProyecto = UtilidadesNegocio.ListaSeleccion(objProyecto.ListarActivos(), "Id", "Nombre", objEditar.idProyecto.ToString());
  //              ViewBag.ListaProveedor = UtilidadesNegocio.ListaSeleccion(objProveedor.ListarActivos(), "Id", "Nombre", objEditar.idProveedor.ToString());
  //              return PartialView(objEditar);
		//	}
		//	catch (Exception ex)
		//	{
		//		MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Editar");
		//		return PartialView();
		//	}
		//}

		//[HttpPost]
		//public ActionResult BodegaEditar(BodegaModelo objEditar)
		//{
		//	try
		//	{
		//		if (ModelState.IsValid)
		//		{
  //                  SesionNegocio objSesionNegocio = new SesionNegocio();
  //                  objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
  //                  objBodega.Editar(objEditar);
		//		}
		//		return Json("false");
		//	}
		//	catch (Exception ex)
		//	{
		//		MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Editar");
		//		return View();
		//	}
		//}

		//public ActionResult BodegaBorrar(int id)
		//{
		//	try
		//	{
  //              SesionNegocio objSesionNegocio = new SesionNegocio();
  //              objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

  //              if (ModelState.IsValid)
		//		{
		//			objBodega.Borrar(id);
		//		}
		//		return Json(objBodega.Listar().ToString());
		//	}
		//	catch (Exception ex)
		//	{
		//		MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BodegaController - Borrar");
		//		return View();
		//	}
		//}
	}
}