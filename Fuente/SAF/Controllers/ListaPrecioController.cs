using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using Microsoft.AspNetCore.Authorization;
using System.Collections.Generic;

namespace SAF.Controllers
{
    [Authorize]
    public class ListaPrecioController : Controller
    {
        private readonly ListaPrecioNegocio ObjListaPrecio = new ListaPrecioNegocio();
        private readonly ListaPrecioDetalleNegocio ObjListaPrecioDetalle = new ListaPrecioDetalleNegocio();
        private readonly ElementoNegocio ObjElemento = new ElementoNegocio();

        public ListaPrecioController(IConfiguration IConfiguracion)
        {
            try
            {
                ObjListaPrecio.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjElemento.SetConexion(IConfiguracion["BD_SQL_SAF"]);
                ObjListaPrecioDetalle.SetConexion(IConfiguracion["BD_SQL_SAF"]);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Contructor");
            }
        }

        public ActionResult ListaPrecioListar()
        {
            try
            {
                return PartialView(ObjListaPrecio.Listar());
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
                ListaPrecioModelo objElemento = ObjListaPrecio.Consultar(id);
                return PartialView(objElemento);
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
        public ActionResult ListaPrecioInsertar(ListaPrecioModelo objListaPrecio)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    ObjListaPrecio.Insertar(objListaPrecio);
                }
                string strModoExterno = TempData["ModoExterno"].ToString();
                TempData.Remove("ModoExterno");

                if (strModoExterno.Equals("true"))
                {
                    return Json(ObjListaPrecio.ListarActivos());
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
                ListaPrecioModelo objElemento = ObjListaPrecio.Consultar(id);
                return PartialView(objElemento);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ListaPrecioEditar(ListaPrecioModelo objListaPrecio)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    ObjListaPrecio.Editar(objListaPrecio);
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
                if (ModelState.IsValid)
                {
                    ObjListaPrecio.Borrar(id);
                }
                return Json(ObjListaPrecio.Listar().ToString());
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Borrar");
                return View();
            }
        }

        public ActionResult ListaPrecioDetallesInsertar()
        {
            try
            {
                MDListaPrecioDetallesModelo objLista = new MDListaPrecioDetallesModelo();
                objLista.ListaPrecio = new ListaPrecioModelo();
                objLista.Detalle = ObjListaPrecioDetalle.CrearListaDetalleNueva();
                ViewBag.ListaElemento = Utilidades.ListaSeleccion(ObjElemento.ListarActivos(), "Id", "Nombre", "-1");
                return PartialView(objLista);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ListaPrecioDetallesInsertar(MDListaPrecioDetallesModelo objListaPrecioDetalles)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    ObjListaPrecio.InsertarMasivo(objListaPrecioDetalles);                    
                }
                return Json("false");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "ListaPrecioController - Insertar");
                return View();
            }
        }
    }
}