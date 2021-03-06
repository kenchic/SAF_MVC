using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreSAF.Modelos;
using CoreSEG.Modelos;
using CoreSEG.Negocios;

namespace CoreSAF.Negocios
{
	public class DocumentoDetalleNegocio
    {
		private readonly DocumentoDetalleDatos ObjDocumentoDetalle = new DocumentoDetalleDatos();
		
		 public void AsignarSesion(SesionModelo objSesion)
        {
            ObjDocumentoDetalle.objSesion = objSesion;
        }

		public List<DocumentoDetalleModelo> Listar()
		{
			try
			{
				IList<DocumentoDetalleModelo> LisDocumentoDetalle = ObjDocumentoDetalle.Listar("0");
				return LisDocumentoDetalle.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoDetalleNegocio - Listar");
				throw;
			}
		}

		public List<DocumentoDetalleModelo> ListarActivos()
		{
			try
			{
				IList<DocumentoDetalleModelo> LisDocumentoDetalle = ObjDocumentoDetalle.Listar("1");
				return LisDocumentoDetalle.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoDetalleNegocio - ListarActivos");
				throw;
			}
		}

		public List<VDocumentoDetalleModelo> Consultar(int id)
		{
			try
			{
				VDocumentoDetalleModelo objConsultar = new VDocumentoDetalleModelo();
				objConsultar.idDocumento = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjDocumentoDetalle.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoDetalleNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(DocumentoDetalleModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjDocumentoDetalle.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoDetalleNegocio - Insertar");
				throw;
			}
		}

		public void Editar(DocumentoDetalleModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjDocumentoDetalle.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoDetalleNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				DocumentoDetalleModelo objBorrar = new DocumentoDetalleModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjDocumentoDetalle.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.DocumentoDetalleNegocio - Borrar");
				throw;
			}
		}

        public void InsertarMasivo(List<DocumentoDetalleModelo> objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                ObjDocumentoDetalle.Insertar("3", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - Insertar");
                throw;
            }
        }

        public List<VDocumentoDetalleModelo> CrearListaDetalleNueva()
        {
            try
            {
                ParametroNegocio objParametro = new ParametroNegocio();
                objParametro.AsignarSesion(ObjDocumentoDetalle.objSesion);

                int intFilas = 0;
                int.TryParse(objParametro.Consultar("NumeroFilasDocumento", "15").Valor, out intFilas);

                List<VDocumentoDetalleModelo> ObjDetalle = new List<VDocumentoDetalleModelo>();
                for (int i = 0; i < intFilas; i++)
                {
                    VDocumentoDetalleModelo objLista = new VDocumentoDetalleModelo();
                    objLista.idElemento = 0;
                    objLista.ElementoNombre = string.Empty;
                    objLista.idBodegaDestino = 0;
                    objLista.BodegaDestinoNombre = string.Empty;
                    objLista.idBodegaOrigen = 0;
                    objLista.BodegaOrigenNombre = string.Empty;
                    objLista.Cantidad = 0;
                    ObjDetalle.Add(objLista);
                }
                return ObjDetalle;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioDetalleNegocio - Insertar");
                throw;
            }
        }
    }
}