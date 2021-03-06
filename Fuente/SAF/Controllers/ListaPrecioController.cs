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
    public class ListaPrecioController : Controller
    {
        private readonly ListaPrecioNegocio objListaPrecio = new ListaPrecioNegocio();
        private readonly ListaPrecioDetalleNegocio objListaPrecioDetalle = new ListaPrecioDetalleNegocio();
        private readonly ElementoNegocio objElemento = new ElementoNegocio();

        public ActionResult ListaPrecioListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objListaPrecio.Listar());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Listar");
                return PartialView();
            }
        }

        public ActionResult ListaPrecioConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objListaPrecio.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Consultar");
                return PartialView();
            }
        }

        public ActionResult ListaPrecioInsertar(string strModoExterno = "false")
        {
            try
            {
                TempData["ModoExterno"] = strModoExterno;
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ListaPrecioInsertar(ListaPrecioModelo objInsertar)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objListaPrecio.Insertar(objInsertar);
                }
                string strModoExterno = TempData["ModoExterno"].ToString();
                TempData.Remove("ModoExterno");

                if (strModoExterno.Equals("true"))
                {
                    return Json(objListaPrecio.ListarActivos());
                }
                else
                {
                    return Json("false");
                }
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Insertar");
                return View();
            }
        }

        public ActionResult ListaPrecioEditar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objListaPrecio.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ListaPrecioEditar(ListaPrecioModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objListaPrecio.Editar(objEditar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Editar");
                return View();
            }
        }

        public ActionResult ListaPrecioBorrar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objListaPrecio.Borrar(id);
                }
                return Json(objListaPrecio.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Borrar");
                return View();
            }
        }

        public ActionResult ListaPrecioDetalleInsertar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecioDetalle.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                MDListaPrecioDetallesModelo objLista = new MDListaPrecioDetallesModelo();
                objLista.ListaPrecio = new ListaPrecioModelo();
                objLista.Detalle = objListaPrecioDetalle.CrearListaDetalleNueva();
                return PartialView(objLista);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - ListaPrecioDetalleInsertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ListaPrecioDetalleInsertar(MDListaPrecioDetallesModelo objInsertar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objListaPrecio.InsertarMasivo(objInsertar);                    
                }
                return Json("false");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - ListaPrecioDetalleInsertar");
                return View();
            }
        }

        public ActionResult ListaPrecioDetalleEditar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objListaPrecioDetalle.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                MDListaPrecioDetallesModelo objEditar = new MDListaPrecioDetallesModelo();
                objEditar.ListaPrecio = objListaPrecio.Consultar(id);
                objEditar.Detalle = objListaPrecioDetalle.Consultar(id);
                return PartialView(objEditar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - ListaPrecioDetalleEditar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ListaPrecioDetalleEditar(MDListaPrecioDetallesModelo objListaPrecioDetalles)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objListaPrecio.EditarMasivo(objListaPrecioDetalles);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - ListaPrecioDetalleEditar");
                return View();
            }
        }

        public ActionResult ListaPrecioDetalleConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objListaPrecio.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objListaPrecioDetalle.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                MDListaPrecioDetallesModelo objConsultar = new MDListaPrecioDetallesModelo();
                objConsultar.ListaPrecio = objListaPrecio.Consultar(id);
                objConsultar.Detalle = objListaPrecioDetalle.Consultar(id);
                return PartialView(objConsultar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - ListaPrecioDetalleConsultar");
                return PartialView();
            }
        }
    }
}