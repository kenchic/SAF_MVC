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
    public class RemisionController : Controller
    {
        private readonly RemisionNegocio objRemision = new RemisionNegocio();
        private readonly ElementoNegocio objElemento = new ElementoNegocio();
        private readonly CatalogoNegocio objConductor = new CatalogoNegocio();
        public ActionResult RemisionListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objRemision.Listar());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - Listar");
                return PartialView();
            }
        }

        public ActionResult RemisionConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objRemision.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - Consultar");
                return PartialView();
            }
        }

        public ActionResult RemisionInsertar()
        {
            try
            {
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult RemisionInsertar(RemisionModelo objInsertar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objRemision.Insertar(objInsertar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - Insertar");
                return View();
            }
        }

        public ActionResult RemisionEditar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objRemision.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult RemisionEditar(RemisionModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objRemision.Editar(objEditar);
                }
                return Json("false");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - Editar");
                return View();
            }
        }

        public ActionResult RemisionBorrar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objRemision.Borrar(id);
                }
                return Json(objRemision.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - Borrar");
                return View();
            }
        }

        public ActionResult RemisionDetalleInsertar(int id)
        {
            try
            {
                SesionNegocio ObjSesionNegocio = new SesionNegocio();
                objElemento.AsignarSesion(ObjSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objRemision.AsignarSesion(ObjSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));               
                ViewBag.ListaElemento = objElemento.ListarActivosAutoComplete();

                MDRemisionModelo objInsertar = new MDRemisionModelo();
                objInsertar.Remision = new RemisionModelo();
                objInsertar.Remision.FechaSistema = DateTime.Now;
                objInsertar.Remision.Fecha = DateTime.Now;
                objInsertar.Remision.idProyecto = id;
                objInsertar.Remision.idProyecto =
                ViewBag.idProyecto = id;
                objInsertar.Detalle = objRemision.CrearListaDetalle();

                return PartialView(objInsertar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - RemisionDetalleInsertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult RemisionDetalleInsertar(MDRemisionModelo objInsertar)
        {
            try
            {
                Int32 intId = 0;
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    intId = objRemision.InsertarMasivo(objInsertar);
                }
                return Json(intId);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - RemisionDetalleInsertar");
                return View();
            }
        }

        public ActionResult RemisionDetalleEditar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                ViewBag.ListaElemento = objElemento.ListarActivosAutoComplete();

                MDRemisionModelo objEditar = new MDRemisionModelo();
                objEditar.Remision = objRemision.Consultar(id);
                objEditar.Detalle = objRemision.ConsultarDetalle(id);
                ViewBag.idProyecto = id;
                return PartialView(objEditar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - RemisionDetalleEditar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult RemisionDetalleEditar(MDRemisionModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objRemision.EditarMasivo(objEditar);
                }
                return Json(objEditar.Remision.Id);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - RemisionDetalleEditar");
                return View();
            }
        }

        public ActionResult RemisionDetalleConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objRemision.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                MDRemisionModelo objConsultar = new MDRemisionModelo();
                objConsultar.Remision = objRemision.Consultar(id);
                objConsultar.Detalle = objRemision.ConsultarDetalle(id);
                return PartialView(objConsultar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "RemisionController - RemisionDetalleConsultar");
                return PartialView();
            }
        }
    }
}