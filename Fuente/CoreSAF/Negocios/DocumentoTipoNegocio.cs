using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreGeneral.Modelos.SAF;
using CoreGeneral.Modelos.SEG;

namespace CoreSAF.Negocios
{
    public class DocumentoTipoNegocio
    {
        private readonly DocumentoTipoDatos objDocumentoTipo = new DocumentoTipoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objDocumentoTipo.Session = objSesion;
        }

        public List<DocumentoTipoModelo> Listar()
        {
            try
            {
                IList<DocumentoTipoModelo> LisDocumentoTipo = objDocumentoTipo.Listar("0");
                return LisDocumentoTipo.ToList();
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoTipoNegocio - Listar");
                throw;
            }
        }

        public List<DocumentoTipoModelo> ListarActivos()
        {
            try
            {
                IList<DocumentoTipoModelo> LisDocumentoTipo = objDocumentoTipo.Listar("1");
                return LisDocumentoTipo.ToList();
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoTipoNegocio - ListarActivos");
                throw;
            }
        }

        public DocumentoTipoModelo Consultar(string id)
        {
            try
            {
                DocumentoTipoModelo objConsultar = new DocumentoTipoModelo();
                objConsultar.Id = id;
                string Json = JsonConvert.SerializeObject(objConsultar);
                return objDocumentoTipo.Consultar("2", Json);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoTipoNegocio - Consultar");
                throw;
            }
        }

        public void Insertar(DocumentoTipoModelo objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                objDocumentoTipo.Insertar("3", Json);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoTipoNegocio - Insertar");
                throw;
            }
        }

        public void Editar(DocumentoTipoModelo objEditar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objEditar);
                objDocumentoTipo.Editar("4", Json);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoTipoNegocio - Editar");
                throw;
            }
        }

        public bool Borrar(string id)
        {
            try
            {
                DocumentoTipoModelo objBorrar = new DocumentoTipoModelo();
                objBorrar.Id = id;
                string Json = JsonConvert.SerializeObject(objBorrar);
                return objDocumentoTipo.Borrar("5", Json);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoTipoNegocio - Borrar");
                throw;
            }
        }
    }
}