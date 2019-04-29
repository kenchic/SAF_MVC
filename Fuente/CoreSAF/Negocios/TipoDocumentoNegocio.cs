using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreSAF.Modelos;
using CoreSeg.Modelos;

namespace CoreSAF.Negocios
{
    public class TipoDocumentoNegocio
    {
        private readonly TipoDocumentoDatos objTipoDocumento = new TipoDocumentoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objTipoDocumento.objSesion = objSesion;
        }

        public List<TipoDocumentoModelo> Listar()
        {
            try
            {
                IList<TipoDocumentoModelo> LisTipoDocumento = objTipoDocumento.Listar("0");
                return LisTipoDocumento.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoDocumentoNegocio - Listar");
                throw;
            }
        }

        public List<TipoDocumentoModelo> ListarActivos()
        {
            try
            {
                IList<TipoDocumentoModelo> LisTipoDocumento = objTipoDocumento.Listar("1");
                return LisTipoDocumento.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoDocumentoNegocio - ListarActivos");
                throw;
            }
        }

        public TipoDocumentoModelo Consultar(byte id)
        {
            try
            {
                TipoDocumentoModelo objConsultar = new TipoDocumentoModelo();
                objConsultar.Id = id;
                string Json = JsonConvert.SerializeObject(objConsultar);
                return objTipoDocumento.Consultar("2", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoDocumentoNegocio - Consultar");
                throw;
            }
        }

        public void Insertar(TipoDocumentoModelo objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                objTipoDocumento.Insertar("3", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoDocumentoNegocio - Insertar");
                throw;
            }
        }

        public void Editar(TipoDocumentoModelo objEditar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objEditar);
                objTipoDocumento.Editar("4", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoDocumentoNegocio - Editar");
                throw;
            }
        }

        public bool Borrar(byte id)
        {
            try
            {
                TipoDocumentoModelo objBorrar = new TipoDocumentoModelo();
                objBorrar.Id = id;
                string Json = JsonConvert.SerializeObject(objBorrar);
                return objTipoDocumento.Borrar("5", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoDocumentoNegocio - Borrar");
                throw;
            }
        }
    }
}