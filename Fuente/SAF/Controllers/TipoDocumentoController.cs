using System;
using Microsoft.AspNetCore.Mvc;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;
using CoreSeg.Negocios;
using CoreSeg.Modelos;

namespace SAF.Controllers
{
    [Authorize]
    public class TipoDocumentoController : Controller
    {
        private readonly TipoDocumentoNegocio ObjTipoDocumento = new TipoDocumentoNegocio();

        public ActionResult TipoDocumentoListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjTipoDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(ObjTipoDocumento.Listar());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Listar");
                return PartialView();
            }
        }

        public ActionResult TipoDocumentoConsultar(byte id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjTipoDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(ObjTipoDocumento.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Consultar");
                return PartialView();
            }
        }

        public ActionResult TipoDocumentoInsertar()
        {
            try
            {
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult TipoDocumentoInsertar(TipoDocumentoModelo objInsertar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    ObjTipoDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    ObjTipoDocumento.Insertar(objInsertar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Insertar");
                return View();
            }
        }

        public ActionResult TipoDocumentoEditar(byte id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjTipoDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(ObjTipoDocumento.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult TipoDocumentoEditar(TipoDocumentoModelo objTipoDocumento)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    ObjTipoDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    ObjTipoDocumento.Editar(objTipoDocumento);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Editar");
                return View();
            }
        }

        public ActionResult TipoDocumentoBorrar(byte id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjTipoDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    ObjTipoDocumento.Borrar(id);
                }
                return Json(ObjTipoDocumento.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Borrar");
                return View();
            }
        }
    }
}