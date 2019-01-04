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
    public class GrupoElementoController : Controller
    {
        private readonly GrupoElementoNegocio ObjGrupoElemento = new GrupoElementoNegocio();

        public GrupoElementoController(IConfiguration IConfiguracion)
        {
            try
            {
                ObjGrupoElemento.SetConexion(IConfiguracion["BD_SQL_SAF"]);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Contructor");
            }
        }

        public ActionResult GrupoElementoListar()
        {
            try
            {
                return PartialView(ObjGrupoElemento.Listar());
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
                GrupoElementoModelo objElemento = ObjGrupoElemento.Consultar(id);
                return PartialView(objElemento);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Consultar");
                return PartialView();
            }
        }

        public ActionResult GrupoElementoInsertar()
        {
            try
            {
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult GrupoElementoInsertar(GrupoElementoModelo objGrupoElemento)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    ObjGrupoElemento.Insertar(objGrupoElemento);
                }
                return Json("{ success: 'true'}");
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
                GrupoElementoModelo objElemento = ObjGrupoElemento.Consultar(id);
                return PartialView(objElemento);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult GrupoElementoEditar(GrupoElementoModelo objGrupoElemento)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    ObjGrupoElemento.Editar(objGrupoElemento);
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
                if (ModelState.IsValid)
                {
                    ObjGrupoElemento.Borrar(id);
                }
                return Json(ObjGrupoElemento.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "GrupoElementoController - Borrar");
                return View();
            }
        }
    }
}