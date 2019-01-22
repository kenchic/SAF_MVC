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
    public class TipoDocumentoController : Controller
    {
        private readonly TipoDocumentoNegocio ObjTipoDocumento = new TipoDocumentoNegocio();

        public TipoDocumentoController(IConfiguration IConfiguracion)
        {
            try
            {
                ObjTipoDocumento.SetConexion(IConfiguracion["BD_SQL_SAF"]);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "TipoDocumentoController - Contructor");
            }
        }

        public ActionResult TipoDocumentoListar()
        {
            try
            {
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
                TipoDocumentoModelo objElemento = ObjTipoDocumento.Consultar(id);
                return PartialView(objElemento);
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
        public ActionResult TipoDocumentoInsertar(TipoDocumentoModelo objTipoDocumento)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    ObjTipoDocumento.Insertar(objTipoDocumento);
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
                TipoDocumentoModelo objElemento = ObjTipoDocumento.Consultar(id);
                return PartialView(objElemento);
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