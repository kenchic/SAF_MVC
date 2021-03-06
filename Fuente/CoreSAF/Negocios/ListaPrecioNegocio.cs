using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreSAF.Modelos;
using CoreSEG.Modelos;

namespace CoreSAF.Negocios
{
    public class ListaPrecioNegocio
    {
        private readonly ListaPrecioDatos ObjListaPrecio = new ListaPrecioDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            ObjListaPrecio.objSesion = objSesion;
        }

        public List<ListaPrecioModelo> Listar()
        {
            try
            {
                IList<ListaPrecioModelo> LisListaPrecio = ObjListaPrecio.Listar("0");
                return LisListaPrecio.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - Listar");
                throw;
            }
        }

        public List<ListaPrecioModelo> ListarActivos()
        {
            try
            {
                IList<ListaPrecioModelo> LisListaPrecio = ObjListaPrecio.Listar("1");
                return LisListaPrecio.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - ListarActivos");
                throw;
            }
        }

        public ListaPrecioModelo Consultar(int id)
        {
            try
            {
                ListaPrecioModelo objConsultar = new ListaPrecioModelo();
                objConsultar.Id = (byte)id;
                string Json = JsonConvert.SerializeObject(objConsultar);
                return ObjListaPrecio.Consultar("2", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - Consultar");
                throw;
            }
        }

        public void Insertar(ListaPrecioModelo objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                ObjListaPrecio.Insertar("3", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - Insertar");
                throw;
            }
        }

        public void Editar(ListaPrecioModelo objEditar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objEditar);
                ObjListaPrecio.Editar("4", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - Editar");
                throw;
            }
        }

        public bool Borrar(int id)
        {
            try
            {
                ListaPrecioModelo objBorrar = new ListaPrecioModelo();
                objBorrar.Id = (byte)id;
                string Json = JsonConvert.SerializeObject(objBorrar);
                return ObjListaPrecio.Borrar("5", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - Borrar");
                throw;
            }
        }

        public void InsertarMasivo(MDListaPrecioDetallesModelo objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                ObjListaPrecio.Insertar("6", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - Insertar Masivo");
                throw;
            }
        }

        public void EditarMasivo(MDListaPrecioDetallesModelo objEditar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objEditar);
                ObjListaPrecio.Editar("7", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioNegocio - Editar Masivo");
                throw;
            }
        }
    }
}