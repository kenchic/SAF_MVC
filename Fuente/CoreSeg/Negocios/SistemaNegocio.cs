using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSeg.Datos;
using CoreSeg.Modelos;

namespace CoreSeg.Negocios
{
	public class SistemaNegocio
    {
		private readonly SistemaDatos objSistema = new SistemaDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objUsuario.objSesion = objSesion;
        }

        public List<UsuarioModelo> Listar()
		{
			try
			{
				IList<UsuarioModelo> LisUsuario = objUsuario.Listar("0");
				return LisUsuario.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Listar");
				throw;
			}
		}

		public List<UsuarioModelo> ListarActivos()
		{
			try
			{
				IList<UsuarioModelo> LisUsuario = objUsuario.Listar("1");
				return LisUsuario.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - ListarActivos");
				throw;
			}
		}

		public UsuarioModelo Consultar(int id)
		{
			try
			{
				UsuarioModelo objConsultar = new UsuarioModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objUsuario.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(UsuarioModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objUsuario.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Insertar");
				throw;
			}
		}

		public void Editar(UsuarioModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objUsuario.Editar("4", Json);
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
				UsuarioModelo objBorrar = new UsuarioModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objUsuario.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Borrar");
				throw;
			}
		}
		
		public bool Autenticar(ref UsuarioModelo objAutenticar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objAutenticar);
				objAutenticar = objUsuario.Consultar("6", Json);
				return objAutenticar != null;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - Autenticar");
				throw;
			}
		}

		public List<UsuarioMenuModelo> ListarMenu(int id)
		{
			try
			{
				UsuarioModelo objConsultar = new UsuarioModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);

				IList<UsuarioMenuModelo> LisUsuario = objUsuario.ListarMenu("0", Json);
				return LisUsuario == null ? new List<UsuarioMenuModelo>() : LisUsuario.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Negocios.UsuarioNegocio - ListarMenu");
				throw;
			}
		}
	
	}
	
}
