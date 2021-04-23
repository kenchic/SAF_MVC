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
    public class CiudadController : Controller
    {
        private readonly CatalogoNegocio objCiudad = new CatalogoNegocio();
        private const string IdCatalogo = "CIUDADES";

        public ActionResult CiudadListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objCiudad.ListarDetalle(IdCatalogo));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Listar");
                return PartialView();
            }
        }

        public ActionResult CiudadConsultar(string id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objCiudad.ConsultarDetalle(IdCatalogo, id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Consultar");
                return PartialView();
            }
        }

        public ActionResult CiudadInsertar(string strModoExterno = "false")
        {
            try
            {
                TempData["ModoExterno"] = strModoExterno;
                CatalogoDetalleModelo objInsertar = new CatalogoDetalleModelo();
                objInsertar.IdCatalogo = IdCatalogo;
                objInsertar.Id = Utilidades.CodigoAleatorio(10);
                return PartialView(objInsertar);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult CiudadInsertar(CatalogoDetalleModelo objInsertar)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objInsertar.IdCatalogo = IdCatalogo;
                if (ModelState.IsValid)
                {
                    objCiudad.InsertarDetalle(objInsertar);
                }
                string strModoExterno = TempData["ModoExterno"].ToString();
                TempData.Remove("ModoExterno");

                if(strModoExterno.Equals("true"))
                {
                    return Json(objCiudad.ListarActivos());
                }
                else
                {   
                    return Json("false");
                }
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Insertar");
                return View();
            }
        }

        public ActionResult CiudadEditar(string id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objCiudad.ConsultarDetalle(IdCatalogo, id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult CiudadEditar(CatalogoDetalleModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objCiudad.EditarDetalle(objEditar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Editar");
                return View();
            }
        }

        public ActionResult CiudadBorrar(string id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                if (ModelState.IsValid)
                {
                    objCiudad.BorrarDetalle(IdCatalogo, id);
                }
                return Json(objCiudad.ListarDetalle(IdCatalogo).ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CiudadController - Borrar");
                return View();
            }
        }
    }
}