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
    public class GrupoElementoController : Controller
    {
        private readonly GrupoElementoNegocio objGrupoElemento = new GrupoElementoNegocio();

        public ActionResult GrupoElementoListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objGrupoElemento.Listar());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Listar");
                return PartialView();
            }
        }

        public ActionResult GrupoElementoConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objGrupoElemento.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Consultar");
                return PartialView();
            }
        }

        public ActionResult GrupoElementoInsertar(string strModoExterno = "false")
        {
            try
            {
                TempData["ModoExterno"] = strModoExterno;
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult GrupoElementoInsertar(GrupoElementoModelo objInsertar)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objGrupoElemento.Insertar(objInsertar);
                }
                string strModoExterno = TempData["ModoExterno"].ToString();
                TempData.Remove("ModoExterno");

                if (strModoExterno.Equals("true"))
                {
                    return Json(objGrupoElemento.ListarActivos());
                }
                else
                {
                    return Json("false");
                }
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Insertar");
                return View();
            }
        }

        public ActionResult GrupoElementoEditar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objGrupoElemento.Consultar(id));
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult GrupoElementoEditar(GrupoElementoModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objGrupoElemento.Editar(objEditar);
                }
                return Json("{ success: 'true'}");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Editar");
                return View();
            }
        }


        public ActionResult GrupoElementoBorrar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objGrupoElemento.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objGrupoElemento.Borrar(id);
                }
                return Json(objGrupoElemento.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Borrar");
                return View();
            }
        }
    }
}