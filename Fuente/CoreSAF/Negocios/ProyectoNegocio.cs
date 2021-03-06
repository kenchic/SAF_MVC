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
	public class ProyectoNegocio
    {
		private readonly ProyectoDatos objProyecto = new ProyectoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objProyecto.objSesion = objSesion;
        }

        public List<VProyectoModelo> Listar()
		{
			try
			{
				IList<VProyectoModelo> LisProyecto = objProyecto.Listar("0");
				return LisProyecto.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Listar");
				throw;
			}
		}

		public List<VProyectoModelo> ListarActivos()
		{
			try
			{
				IList<VProyectoModelo> LisProyecto = objProyecto.Listar("1");
				return LisProyecto.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - ListarActivos");
				throw;
			}
		}

		public VProyectoModelo Consultar(int id)
		{
			try
			{
				VProyectoModelo objConsultar = new VProyectoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objProyecto.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ProyectoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objProyecto.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ProyectoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objProyecto.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ProyectoModelo objBorrar = new ProyectoModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objProyecto.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Borrar");
				throw;
			}
		}
	}
}