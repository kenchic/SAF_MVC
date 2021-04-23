using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSEG.Datos;
using CoreSEG.Modelos;

namespace CoreSEG.Negocios
{
	public class SistemaNegocio
    {
		private readonly SistemaDatos objSistema = new SistemaDatos();

        public SistemaNegocio(SesionModelo objSesion)
        {
            objSistema.objSesion = objSesion;
        }

        public List<SistemaModelo> Listar()
		{
			try
			{
				IList<SistemaModelo> LisSistema = objSistema.Listar("0");
				return LisSistema.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Negocios.SistemaNegocio - Listar");
				throw;
			}
		}

		public List<SistemaModelo> ListarActivos()
		{
			try
			{
				IList<SistemaModelo> LisSistema = objSistema.Listar("1");
				return LisSistema.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Negocios.SistemaNegocio - ListarActivos");
				throw;
			}
		}

		public SistemaModelo Consultar(string id)
		{
			try
			{
				SistemaModelo objConsultar = new SistemaModelo();
				objConsultar.Id = id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objSistema.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Negocios.SistemaNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(SistemaModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objSistema.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Negocios.SistemaNegocio - Insertar");
				throw;
			}
		}

		public void Editar(SistemaModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objSistema.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Negocios.SistemaNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(string id)
		{
			try
			{
				SistemaModelo objBorrar = new SistemaModelo();
				objBorrar.Id = id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objSistema.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Negocios.SistemaNegocio - Borrar");
				throw;
			}
		}
	}
	
}
