using System;
using Microsoft.AspNetCore.Mvc;
using CoreGeneral.Recursos;
using CoreGeneral.Negocios;
using Microsoft.AspNetCore.Authorization;
using CoreGeneral.Modelos.SEG;
using CoreGeneral.Utilidades;
using SAF.Helper;
using Newtonsoft.Json;
using System.Collections.Generic;
using CoreGeneral.Modelos.SAF;

namespace SAF.Controllers
{
    [Authorize]
    public class AgenteController : Controller
    {
        public ActionResult Listar()
        {
            try
            {
                SesionModelo sesion =  Sesion.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario");
                string resultado = ClienteApi.GetRecurso(Configuracion.UrlApiSAF(), "Agente/ListarTodos", sesion.Token);
                if (!string.IsNullOrEmpty(resultado))
                {
                    return PartialView(JsonConvert.DeserializeObject<List<AgenteModelo>>(resultado));
                }
                else
                {
                    return PartialView(new List<AgenteModelo>());
                }
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Listar");
                return PartialView();
            }
        }

        //public ActionResult Consultar(int id)
        //{
        //    try
        //    {
        //        SesionNegocio objSesionNegocio = new SesionNegocio();
        //        objAgente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //        return PartialView(objAgente.Consultar(id));
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Consultar");
        //        return PartialView();
        //    }
        //}

        public ActionResult Insertar(string strModoExterno = "false")
        {
            try
            {
                TempData["ModoExterno"] = strModoExterno;
                return PartialView();
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult Insertar(AgenteModelo agente)
        {
            try
            {
                SesionModelo sesion = Sesion.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario");

                string resultado = string.Empty;
                if (ModelState.IsValid)
                {
                    resultado = ClienteApi.PostRecurso(Configuracion.UrlApiSAF(), "Agente/Insertar", agente, sesion.Token);

                    if (!string.IsNullOrEmpty(resultado))
                    {
                        string strModoExterno = TempData["ModoExterno"].ToString();
                        TempData.Remove("ModoExterno");

                        if (strModoExterno.Equals("true"))
                        {
                            resultado = ClienteApi.GetRecurso(Configuracion.UrlApiSAF(), "Agente/ListarActivos", agente, sesion.Token);
                            if (!string.IsNullOrEmpty(resultado))
                            {
                                return Json(JsonConvert.DeserializeObject<List<AgenteModelo>>(resultado));
                            }
                        }
                    }
                }
                return Json("false");
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Insertar");
                return View();
            }
        }

        //public ActionResult Editar(int id)
        //{
        //    try
        //    {
        //        SesionNegocio objSesionNegocio = new SesionNegocio();
        //        objAgente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //        return PartialView(objAgente.Consultar(id));
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Editar");
        //        return PartialView();
        //    }
        //}

        //[HttpPost]
        //public ActionResult Editar(AgenteModelo objEditar)
        //{
        //    try
        //    {
        //        if (ModelState.IsValid)
        //        {
        //            SesionNegocio objSesionNegocio = new SesionNegocio();
        //            objAgente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //            objAgente.Editar(objEditar);
        //        }
        //        return Json("{ success: 'true'}");
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Editar");
        //        return View();
        //    }
        //}


        //public ActionResult Borrar(int id)
        //{
        //    try
        //    {
        //        SesionNegocio objSesionNegocio = new SesionNegocio();
        //        objAgente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
        //        if (ModelState.IsValid)
        //        {
        //            objAgente.Borrar(id);
        //        }
        //        return Json(objAgente.Listar().ToString());
        //    }
        //    catch (Exception ex)
        //    {
        //        MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Borrar");
        //        return View();
        //    }
        //}
    }
}