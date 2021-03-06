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
    public class UnidadMedidaNegocio
    {
        private readonly UnidadMedidaDatos objUnidadMedida = new UnidadMedidaDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objUnidadMedida.objSesion = objSesion;
        }

        public List<UnidadMedidaModelo> Listar()
        {
            try
            {
                IList<UnidadMedidaModelo> LisUnidadMedida = objUnidadMedida.Listar("0");
                return LisUnidadMedida.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.UnidadMedidaNegocio - Listar");
                throw;
            }
        }

        public List<UnidadMedidaModelo> ListarActivos()
        {
            try
            {
                IList<UnidadMedidaModelo> LisUnidadMedida = objUnidadMedida.Listar("1");
                return LisUnidadMedida.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.UnidadMedidaNegocio - ListarActivos");
                throw;
            }
        }

        public UnidadMedidaModelo Consultar(byte id)
        {
            try
            {
                UnidadMedidaModelo objConsultar = new UnidadMedidaModelo();
                objConsultar.Id = id;
                string Json = JsonConvert.SerializeObject(objConsultar);
                return objUnidadMedida.Consultar("2", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.UnidadMedidaNegocio - Consultar");
                throw;
            }
        }

        public void Insertar(UnidadMedidaModelo objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                objUnidadMedida.Insertar("3", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.UnidadMedidaNegocio - Insertar");
                throw;
            }
        }

        public void Editar(UnidadMedidaModelo objEditar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objEditar);
                objUnidadMedida.Editar("4", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.UnidadMedidaNegocio - Editar");
                throw;
            }
        }

        public bool Borrar(byte id)
        {
            try
            {
                UnidadMedidaModelo objBorrar = new UnidadMedidaModelo();
                objBorrar.Id = id;
                string Json = JsonConvert.SerializeObject(objBorrar);
                return objUnidadMedida.Borrar("5", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.UnidadMedidaNegocio - Borrar");
                throw;
            }
        }
    }
}