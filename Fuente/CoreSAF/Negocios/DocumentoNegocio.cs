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
	public class DocumentoNegocio
    {
		private readonly DocumentoDatos ObjDocumento = new DocumentoDatos();
		
		 public void AsignarSesion(SesionModelo objSesion)
        {
            ObjDocumento.objSesion = objSesion;
        }

		public List<VDocumentoModelo> Listar()
		{
			try
			{
				IList<VDocumentoModelo> LisDocumento = ObjDocumento.Listar("0");
				return LisDocumento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoNegocio - Listar");
				throw;
			}
		}

		public List<VDocumentoModelo> ListarActivos()
		{
			try
			{
				IList<VDocumentoModelo> LisDocumento = ObjDocumento.Listar("1");
				return LisDocumento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoNegocio - ListarActivos");
				throw;
			}
		}

		public VDocumentoModelo Consultar(int id)
		{
			try
			{
				VDocumentoModelo objConsultar = new VDocumentoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjDocumento.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(DocumentoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjDocumento.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(DocumentoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjDocumento.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				DocumentoModelo objBorrar = new DocumentoModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjDocumento.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoNegocio - Borrar");
				throw;
			}
		}

        public Int32 InsertarMasivo(MDDocumentoDetallesModelo objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                Int32 intId = ObjDocumento.Insertar("6", Json);
                return intId;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.DocumentoNegocio - Insertar Masivo");
                throw;
            }
        }

        public void EditarMasivo(MDDocumentoDetallesModelo objEditar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objEditar);
                ObjDocumento.Editar("7", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.DocumentoNegocio - Editar Masivo");
                throw;
            }
        }
    }
}