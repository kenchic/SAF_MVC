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
    public class DocumentoController : Controller
    {
        private readonly DocumentoNegocio objDocumento = new DocumentoNegocio();
        private readonly DocumentoDetalleNegocio objDocumentoDetalle = new DocumentoDetalleNegocio();
        private readonly DocumentoTipoNegocio objDocumentoTipo = new DocumentoTipoNegocio();
        private readonly ElementoNegocio objElemento = new ElementoNegocio();
        private readonly BodegaNegocio objBodega = new BodegaNegocio();

        public ActionResult DocumentoListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objDocumento.Listar());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - Listar");
                return PartialView();
            }
        }

        public ActionResult DocumentoConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objDocumento.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - Consultar");
                return PartialView();
            }
        }

        public ActionResult DocumentoInsertar()
        {
            try
            {
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult DocumentoInsertar(DocumentoModelo objInsertar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objDocumento.Insertar(objInsertar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - Insertar");
                return View();
            }
        }

        public ActionResult DocumentoEditar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objDocumento.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult DocumentoEditar(DocumentoModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objDocumento.Editar(objEditar);
                }
                return Json("false");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - Editar");
                return View();
            }
        }

        public ActionResult DocumentoBorrar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objDocumento.Borrar(id);
                }
                return Json(objDocumento.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - Borrar");
                return View();
            }
        }

        public ActionResult DocumentoDetalleInsertar()
        {
            try
            {
                SesionNegocio ObjSesionNegocio = new SesionNegocio();

                objDocumentoTipo.AsignarSesion(ObjSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objBodega.AsignarSesion(ObjSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objElemento.AsignarSesion(ObjSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objDocumentoDetalle.AsignarSesion(ObjSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                ViewBag.ListaDocumentoTipo = Utilidades.ListaSeleccion(objDocumentoTipo.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaBodega = Utilidades.ListaSeleccion(objBodega.ListarActivos(), "Id", "Nombre", "-1", "");                
                ViewBag.ListaElemento = objElemento.ListarActivosAutoComplete();

                MDDocumentoDetallesModelo objInsertar = new MDDocumentoDetallesModelo();
                objInsertar.Documento = new VDocumentoModelo();
                objInsertar.Documento.Fecha = DateTime.Now;
                objInsertar.Detalle = objDocumentoDetalle.CrearListaDetalleNueva();

                return PartialView(objInsertar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - DocumentoDetalleInsertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult DocumentoDetalleInsertar(MDDocumentoDetallesModelo objInsertar)
        {
            try
            {
                Int32 intId = 0;
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    intId = objDocumento.InsertarMasivo(objInsertar);
                }
                return Json(intId);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - DocumentoDetalleInsertar");
                return View();
            }
        }

        public ActionResult DocumentoDetalleEditar(int id)
        {
            try
            {
                ParametroNegocio objParametro = new ParametroNegocio();
                SesionNegocio objSesionNegocio = new SesionNegocio();

                objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objDocumentoDetalle.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objDocumentoTipo.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objBodega.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objParametro.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                ViewBag.ListaDocumentoTipo = Utilidades.ListaSeleccion(objDocumentoTipo.ListarActivos(), "Id", "Nombre", "-1");
                ViewBag.ListaBodega = Utilidades.ListaSeleccion(objBodega.ListarActivos(), "Id", "Nombre", "-1", "");
                ViewBag.ListaElemento = objElemento.ListarActivosAutoComplete();

                MDDocumentoDetallesModelo objEditar = new MDDocumentoDetallesModelo();
                objEditar.Documento = objDocumento.Consultar(id);
                objEditar.Detalle = objDocumentoDetalle.Consultar(id);

                int intFilas = 0;
                int.TryParse(objParametro.Consultar("NumeroFilasDocumento", "15").Valor, out intFilas);

                if (objEditar.Detalle.Count < intFilas)
                {
                    for (int i = objEditar.Detalle.Count; i < intFilas; i++)
                    {
                        objEditar.Detalle.Add(new VDocumentoDetalleModelo());
                    }
                }

                return PartialView(objEditar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - DocumentoDetalleEditar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult DocumentoDetalleEditar(MDDocumentoDetallesModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objDocumento.EditarMasivo(objEditar);
                }
                return Json(objEditar.Documento.Id);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - DocumentoDetalleEditar");
                return View();
            }
        }

        public ActionResult DocumentoDetalleConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objDocumento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objDocumentoDetalle.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                MDDocumentoDetallesModelo objConsultar = new MDDocumentoDetallesModelo();
                objConsultar.Documento = objDocumento.Consultar(id);
                objConsultar.Detalle = objDocumentoDetalle.Consultar(id);
                return PartialView(objConsultar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "DocumentoController - DocumentoDetalleConsultar");
                return PartialView();
            }
        }

        [HttpGet]
        public ActionResult Search(string nombre)
        {
            return Json(objElemento.ListarActivos());
        }
    }
}