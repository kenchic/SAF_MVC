using System;
using Microsoft.AspNetCore.Mvc;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;
using CoreSEG.Negocios;
using CoreSEG.Modelos;

namespace SAF.Controllers
{
    [Authorize]
    public class ConductorController : Controller
    {
        private readonly CatalogoNegocio objConductor = new CatalogoNegocio();
        private const string IdCatalogo = "CONDUCTORES";

        public ActionResult ConductorListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objConductor.ListarDetalle(IdCatalogo));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Listar");
                return PartialView();
            }
        }

        public ActionResult ConductorConsultar(string id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objConductor.ConsultarDetalle(IdCatalogo, id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Consultar");
                return PartialView();
            }
        }

        public ActionResult ConductorInsertar()
        {
            try
            {
                CatalogoDetalleModelo objInsertar = new CatalogoDetalleModelo();
                objInsertar.IdCatalogo = IdCatalogo;
                objInsertar.Id = Utilidades.CodigoAleatorio(10);
                return PartialView(objInsertar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ConductorInsertar(CatalogoDetalleModelo objInsertar)
        {
            try
            {

                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objInsertar.IdCatalogo = IdCatalogo;
                if (ModelState.IsValid)
                {
                    objConductor.InsertarDetalle(objInsertar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Insertar");
                return View();
            }
        }

        public ActionResult ConductorEditar(string id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objConductor.ConsultarDetalle(IdCatalogo, id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ConductorEditar(CatalogoDetalleModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objConductor.EditarDetalle(objEditar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Editar");
                return View();
            }
        }

        public ActionResult ConductorBorrar(string id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objConductor.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objConductor.BorrarDetalle(IdCatalogo, id);
                }
                return Json(objConductor.ListarDetalle(IdCatalogo).ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ConductorController - Borrar");
                return View();
            }
        }
    }
}