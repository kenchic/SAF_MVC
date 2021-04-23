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
	public class RemisionNegocio
    {
		private readonly RemisionDatos ObjRemision = new RemisionDatos();
		private const string strCodigoDocumento = "REM";
		public void AsignarSesion(SesionModelo objSesion)
        {
            ObjRemision.objSesion = objSesion;
        }

		public List<RemisionModelo> Listar()
		{
			try
			{
				IList<RemisionModelo> LisRemision = ObjRemision.Listar("0");
				return LisRemision.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.RemisionNegocio - Listar");
				throw;
			}
		}

		public List<RemisionModelo> ListarActivos()
		{
			try
			{
				IList<RemisionModelo> LisRemision = ObjRemision.Listar("1");
				return LisRemision.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.RemisionNegocio - ListarActivos");
				throw;
			}
		}

		public RemisionModelo Consultar(int id)
		{
			try
			{
				RemisionModelo objConsultar = new RemisionModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjRemision.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.RemisionNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(RemisionModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjRemision.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.RemisionNegocio - Insertar");
				throw;
			}
		}

		public void Editar(RemisionModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjRemision.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.RemisionNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				RemisionModelo objBorrar = new RemisionModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjRemision.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.RemisionNegocio - Borrar");
				throw;
			}
		}

        public Int32 InsertarMasivo(MDRemisionModelo objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                Int32 intId = ObjRemision.Insertar("6", Json);
                return intId;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.RemisionNegocio - Insertar Masivo");
                throw;
            }
        }

        public void EditarMasivo(MDRemisionModelo objEditar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objEditar);
                ObjRemision.Editar("7", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.RemisionNegocio - Editar Masivo");
                throw;
            }
        }


		public List<RemisionDetalleModelo> CrearListaDetalle()
		{
			try
			{
				DocumentoTipoNegocio objDocumentoTipo = new DocumentoTipoNegocio();
				objDocumentoTipo.AsignarSesion(ObjRemision.objSesion);

				List<RemisionDetalleModelo> ObjDetalle = new List<RemisionDetalleModelo>();
				for (int i = 0; i < objDocumentoTipo.Consultar("REM").CantidadFilas; i++)
				{
					RemisionDetalleModelo objLista = new RemisionDetalleModelo();
					objLista.idElemento = 0;
					objLista.ElementoNombre = string.Empty;
					objLista.Cantidad = 0;
					ObjDetalle.Add(objLista);
				}
				return ObjDetalle;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.RemisionNegocio - CrearListaDetalle");
				throw;
			}
		}

		public List<RemisionDetalleModelo> ConsultarDetalle(int id)
		{
			try
			{
				DocumentoTipoNegocio objDocumentoTipo = new DocumentoTipoNegocio();
				RemisionModelo objBorrar = new RemisionModelo();

				objDocumentoTipo.AsignarSesion(ObjRemision.objSesion);				
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);

				List<RemisionDetalleModelo> LisRemisionDetalle = ObjRemision.ListarDetalle("8", Json);				
				int? intFilas = objDocumentoTipo.Consultar("REM").CantidadFilas;

				if (LisRemisionDetalle.Count < intFilas)
				{
					for (int i = LisRemisionDetalle.Count; i < intFilas; i++)
					{
						LisRemisionDetalle.Add(new RemisionDetalleModelo());
					}
				}
				return LisRemisionDetalle;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.RemisionNegocio - ConsultarListaDetalle");
				throw;
			}
		}
	}
}