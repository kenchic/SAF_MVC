using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSeg.Datos;
using CoreSeg.Models;

namespace CoreSeg.Negocios
{
	public class UsuarioNegocio
    {
		private readonly UsuarioRepository ObjUsuario = new UsuarioRepository();

		public void SetConexion(string value)
		{
			ObjUsuario.Conexion = value;
		}

		public List<UsuarioModel> Listar()
		{
			try
			{
				IList<UsuarioModel> LisUsuario = ObjUsuario.Listar("0");
				return LisUsuario.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Listar");
				throw;
			}
		}

		public List<UsuarioModel> ListarActivos()
		{
			try
			{
				IList<UsuarioModel> LisUsuario = ObjUsuario.Listar("1");
				return LisUsuario.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - ListarActivos");
				throw;
			}
		}

		public UsuarioModel Consultar(int id)
		{
			try
			{
				UsuarioModel objConsultar = new UsuarioModel();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjUsuario.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(UsuarioModel objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjUsuario.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Insertar");
				throw;
			}
		}

		public void Editar(UsuarioModel objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjUsuario.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				UsuarioModel objBorrar = new UsuarioModel();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjUsuario.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Borrar");
				throw;
			}
		}
		
		public bool Autenticar(UsuarioModel objAutenticar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objAutenticar);
				objAutenticar = ObjUsuario.Consultar("6", Json);
				return objAutenticar != null;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Autenticar");
				throw;
			}
		}
	}
}
