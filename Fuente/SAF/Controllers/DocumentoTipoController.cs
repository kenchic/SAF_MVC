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
    public class DocumentoTipoController : Controller
    {
        private readonly DocumentoTipoNegocio ObjDocumentoTipo = new DocumentoTipoNegocio();

        public ActionResult DocumentoTipoListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjDocumentoTipo.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(ObjDocumentoTipo.Listar());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoTipoController - Listar");
                return PartialView();
            }
        }

        public ActionResult DocumentoTipoConsultar(byte id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjDocumentoTipo.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(ObjDocumentoTipo.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoTipoController - Consultar");
                return PartialView();
            }
        }

        public ActionResult DocumentoTipoInsertar()
        {
            try
            {
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoTipoController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult DocumentoTipoInsertar(DocumentoTipoModelo objInsertar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    ObjDocumentoTipo.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    ObjDocumentoTipo.Insertar(objInsertar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoTipoController - Insertar");
                return View();
            }
        }

        public ActionResult DocumentoTipoEditar(byte id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjDocumentoTipo.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(ObjDocumentoTipo.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoTipoController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult DocumentoTipoEditar(DocumentoTipoModelo objDocumentoTipo)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    ObjDocumentoTipo.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    ObjDocumentoTipo.Editar(objDocumentoTipo);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoTipoController - Editar");
                return View();
            }
        }

        public ActionResult DocumentoTipoBorrar(byte id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                ObjDocumentoTipo.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    ObjDocumentoTipo.Borrar(id);
                }
                return Json(ObjDocumentoTipo.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoTipoController - Borrar");
                return View();
            }
        }
    }
}