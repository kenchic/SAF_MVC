using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreCoreSAF.Datos;
using CoreCoreSAF.Modelos;

namespace CoreCoreSAF.Negocios
{
	public class ProyectoNegocio
    {
		private readonly ProyectoDatos ObjProyecto = new ProyectoDatos();
		
		public void SetConexion(string value)
		{
			ObjProyecto.Conexion = value;
		}

		public List<ProyectoModelo> Listar()
		{
			try
			{
				IList<ProyectoModelo> LisProyecto = ObjProyecto.Listar("0");
				return LisProyecto.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Listar");
				throw;
			}
		}

		public List<ProyectoModelo> ListarActivos()
		{
			try
			{
				IList<ProyectoModelo> LisProyecto = ObjProyecto.Listar("1");
				return LisProyecto.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - ListarActivos");
				throw;
			}
		}

		public ProyectoModelo Consultar(int id)
		{
			try
			{
				ProyectoModelo objConsultar = new ProyectoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjProyecto.Consultar("2", Json);
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
				ObjProyecto.Insertar("3", Json);
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
				ObjProyecto.Editar("4", Json);
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
				return ObjProyecto.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Borrar");
				throw;
			}
		}
	}
}