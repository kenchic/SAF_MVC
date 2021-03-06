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
	public class TipoMantenimientoNegocio
    {
		private readonly TipoMantenimientoDatos objTipoMantenimiento = new TipoMantenimientoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objTipoMantenimiento.objSesion = objSesion;
        }

        public List<TipoMantenimientoModelo> Listar()
		{
			try
			{
				IList<TipoMantenimientoModelo> LisTipoMantenimiento = objTipoMantenimiento.Listar("0");
				return LisTipoMantenimiento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoMantenimientoNegocio - Listar");
				throw;
			}
		}

		public List<TipoMantenimientoModelo> ListarActivos()
		{
			try
			{
				IList<TipoMantenimientoModelo> LisTipoMantenimiento = objTipoMantenimiento.Listar("1");
				return LisTipoMantenimiento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoMantenimientoNegocio - ListarActivos");
				throw;
			}
		}

		public TipoMantenimientoModelo Consultar(int id)
		{
			try
			{
				TipoMantenimientoModelo objConsultar = new TipoMantenimientoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objTipoMantenimiento.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoMantenimientoNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(TipoMantenimientoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objTipoMantenimiento.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoMantenimientoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(TipoMantenimientoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objTipoMantenimiento.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoMantenimientoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				TipoMantenimientoModelo objBorrar = new TipoMantenimientoModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objTipoMantenimiento.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.TipoMantenimientoNegocio - Borrar");
				throw;
			}
		}
	}
}