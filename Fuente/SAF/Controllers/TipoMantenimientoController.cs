using System;
using Microsoft.AspNetCore.Mvc;
using CoreGeneral.Recursos;
using CoreGeneral.Negocios;
using Microsoft.AspNetCore.Authorization;
using CoreGeneral.Modelos.SEG;
using CoreGeneral.Modelos.GES;
using CoreGeneral;

namespace SAF.Controllers
{
    [Authorize]
    public class TipoMantenimientoController : Controller
    {
        //private readonly CatalogoNegocio objTipoMantenimiento = new CatalogoNegocio();
        //private const string IdCatalogo = "TIPO_MANTE";

        //public ActionResult TipoMantenimientoListar()
        //{
        //    try
        //    {
        //        SesionNegocio objSesionNegocio = new SesionNegocio();
        //        objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //        return PartialView(objTipoMantenimiento.ListarDetalle(IdCatalogo));
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Listar");
        //        return PartialView();
        //    }
        //}

        //public ActionResult TipoMantenimientoConsultar(string id)
        //{
        //    try
        //    {
        //        SesionNegocio objSesionNegocio = new SesionNegocio();
        //        objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //        return PartialView(objTipoMantenimiento.ConsultarDetalle(IdCatalogo, id));
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Consultar");
        //        return PartialView();
        //    }
        //}

        //public ActionResult TipoMantenimientoInsertar()
        //{
        //    try
        //    {
        //        CatalogoDetalleModelo objInsertar = new CatalogoDetalleModelo();
        //        objInsertar.IdCatalogo = IdCatalogo;
        //        objInsertar.Id = UtilidadesNegocio.CodigoAleatorio(10);
        //        return PartialView(objInsertar);
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Insertar");
        //        return PartialView();
        //    }
        //}

        //[HttpPost]
        //public ActionResult TipoMantenimientoInsertar(CatalogoDetalleModelo objInsertar)
        //{
        //    try
        //    {
        //        if (ModelState.IsValid)
        //        {
        //            SesionNegocio objSesionNegocio = new SesionNegocio();
        //            objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //            objInsertar.IdCatalogo = IdCatalogo;
        //            objTipoMantenimiento.InsertarDetalle(objInsertar);
        //        }
        //        return Json("{ success: 'true'}");
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Insertar");
        //        return View();
        //    }
        //}

        //public ActionResult TipoMantenimientoEditar(string id)
        //{
        //    try
        //    {
        //        SesionNegocio objSesionNegocio = new SesionNegocio();
        //        objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //        return PartialView(objTipoMantenimiento.ConsultarDetalle(IdCatalogo, id));
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Editar");
        //        return PartialView();
        //    }
        //}

        //[HttpPost]
        //public ActionResult TipoMantenimientoEditar(CatalogoDetalleModelo objTipoEditar)
        //{
        //    try
        //    {
        //        if (ModelState.IsValid)
        //        {
        //            SesionNegocio objSesionNegocio = new SesionNegocio();
        //            objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //            objTipoMantenimiento.EditarDetalle(objTipoEditar);
        //        }
        //        return Json("{ success: 'true'}");
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Editar");
        //        return View();
        //    }
        //}

        //public ActionResult TipoMantenimientoBorrar(string id)
        //{
        //    try
        //    {
        //        if (ModelState.IsValid)
        //        {
        //            SesionNegocio objSesionNegocio = new SesionNegocio();
        //            objTipoMantenimiento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //            objTipoMantenimiento.BorrarDetalle(IdCatalogo, id);
        //        }
        //        return Json(objTipoMantenimiento.ListarDetalle(IdCatalogo).ToString());
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "TipoMantenimientoController - Borrar");
        //        return View();
        //    }
        //}
    }
}