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
	public class CiudadNegocio
    {
		private readonly CiudadDatos ObjCiudad = new CiudadDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            ObjCiudad.objSesion = objSesion;
        }

        public List<CiudadModelo> Listar()
		{
			try
			{
				IList<CiudadModelo> LisCiudad = ObjCiudad.Listar("0");
				return LisCiudad.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CiudadNegocio - Listar");
				throw;
			}
		}

		public List<CiudadModelo> ListarActivos()
		{
			try
			{
				IList<CiudadModelo> LisCiudad = ObjCiudad.Listar("1");
				return LisCiudad.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CiudadNegocio - ListarActivos");
				throw;
			}
		}

		public CiudadModelo Consultar(int id)
		{
			try
			{
				CiudadModelo objConsultar = new CiudadModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjCiudad.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CiudadNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(CiudadModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjCiudad.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CiudadNegocio - Insertar");
				throw;
			}
		}

		public void Editar(CiudadModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjCiudad.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CiudadNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				CiudadModelo objBorrar = new CiudadModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjCiudad.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CiudadNegocio - Borrar");
				throw;
			}
		}
	}
}