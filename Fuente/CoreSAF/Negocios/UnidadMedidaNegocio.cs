using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreSAF.Modelos;

namespace CoreSAF.Negocios
{
    public class UnidadMedidaNegocio
    {
        private readonly UnidadMedidaDatos ObjUnidadMedida = new UnidadMedidaDatos();

        public void SetConexion(string value)
        {
            ObjUnidadMedida.Conexion = value;
        }

        public List<UnidadMedidaModelo> Listar()
        {
            try
            {
                IList<UnidadMedidaModelo> LisUnidadMedida = ObjUnidadMedida.Listar("0");
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
                IList<UnidadMedidaModelo> LisUnidadMedida = ObjUnidadMedida.Listar("1");
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
                return ObjUnidadMedida.Consultar("2", Json);
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
                ObjUnidadMedida.Insertar("3", Json);
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
                ObjUnidadMedida.Editar("4", Json);
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
                return ObjUnidadMedida.Borrar("5", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.UnidadMedidaNegocio - Borrar");
                throw;
            }
        }
    }
}