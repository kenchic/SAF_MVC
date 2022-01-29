using System;
using Microsoft.AspNetCore.Mvc;
using CoreSAF.Modelos;
using CoreSAF.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Negocios;
using Microsoft.AspNetCore.Authorization;
using CoreSEG.Negocios;
using CoreSEG.Modelos;
using System.Data;
using CoreGES.Negocios;
using CoreGeneral;

namespace CoreSAF.Controllers
{
    [Authorize]
    public class ProyectoController : Controller
    {
        private readonly ProyectoNegocio objProyecto = new ProyectoNegocio();
        private readonly CatalogoNegocio objCiudad = new CatalogoNegocio();
        private readonly ClienteNegocio objCliente = new ClienteNegocio();

        public ActionResult ProyectoListar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objProyecto.Listar());
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Listar");
                return PartialView();
            }
        }

        public ActionResult ProyectoConsultar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                return PartialView(objProyecto.Consultar(id));
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Consultar");
                return PartialView();
            }
        }

        public ActionResult ProyectoInsertar()
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                ViewBag.ListaCiudad = UtilidadesNegocio.ListaSeleccion(objCiudad.ListarDetalleActivos("CIUDADES"), "Id", "Nombre", "-1");
                ViewBag.ListaCliente = UtilidadesNegocio.ListaSeleccion(objCliente.ListarActivos(), "Id", "Nombre", "-1");
                ProyectoModelo objInsertar = new ProyectoModelo();
                objInsertar.Activo = true;
                objInsertar.Estado = 1;
                objInsertar.Fecha = DateTime.Now;
                objInsertar.Id = 0;
                return PartialView(objInsertar);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Insertar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ProyectoInsertar(ProyectoModelo objInsertar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objProyecto.Insertar(objInsertar);
                }
                return Json("false");
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Insertar");
                return View();
            }
        }

        public ActionResult ProyectoEditar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objCiudad.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                objCliente.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                VProyectoModelo objEditar = objProyecto.Consultar(id);
                ViewBag.ListaCiudad = UtilidadesNegocio.ListaSeleccion(objCiudad.ListarDetalleActivos("CIUDADES"), "Id", "Nombre", objEditar.idCiudad.ToString());
                ViewBag.ListaCliente = UtilidadesNegocio.ListaSeleccion(objCliente.ListarActivos(), "Id", "Nombre", objEditar.idCliente.ToString());

                return PartialView(objEditar);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Editar");
                return PartialView();
            }
        }

        [HttpPost]
        public ActionResult ProyectoEditar(ProyectoModelo objEditar)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SesionNegocio objSesionNegocio = new SesionNegocio();
                    objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                    objProyecto.Editar(objEditar);
                }
                return Json("false");
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Editar");
                return View();
            }
        }

        public ActionResult ProyectoBorrar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));
                if (ModelState.IsValid)
                {
                    objProyecto.Borrar(id);
                }
                return Json(objProyecto.Listar().ToString());
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - Borrar");
                return View();
            }
        }

        public ActionResult ProyectoPlantillaListar(int id)
        {
            try
            {
                SesionNegocio objSesionNegocio = new SesionNegocio();
                objProyecto.AsignarSesion(objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario"));

                DataTable datPlantilla = objProyecto.PlantillaListar(id);
                ViewBag.idProyecto = id;

                return View(datPlantilla);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "ProyectoController - ProyectoPlantillaListar");
                return PartialView();
            }
        }
    }
}