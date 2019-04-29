using System;
using System.Collections.Generic;
using System.Data;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSeg.Modelos;

namespace CoreSeg.Datos
{
	public class UsuarioDatos : SesionDatos
	{
		public List<UsuarioModelo> Listar(string Accion)
		{
			try
			{
                AbrirConexion("SEG");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				List<UsuarioModelo> LisUsuario = SqlMapper.Query<UsuarioModelo>(objSesion.SqlConexion, "pUsuario", param, commandType: CommandType.StoredProcedure).ToList();
				return LisUsuario.Count == 0 ? null : LisUsuario;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioDatos- Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public UsuarioModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion("SEG");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				List<UsuarioModelo> LisUsuario = SqlMapper.Query<UsuarioModelo>(objSesion.SqlConexion, "pUsuario", param, commandType: CommandType.StoredProcedure).ToList();				
				return LisUsuario.Count == 0 ? null : LisUsuario[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioDatos- Consultar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public void Insertar(string Accion, string Json)
		{
			try
			{
                AbrirConexion("SEG");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				objSesion.SqlConexion.Execute("pUsuario", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioDatos- Insertar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public void Editar(string Accion, string Json)
		{
			try
			{
                AbrirConexion("SEG");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				objSesion.SqlConexion.Execute("pUsuario", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioDatos- Editar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public bool Borrar(string Accion, string Json)
		{
			bool bolResultado = false;
			try
			{
                AbrirConexion("SEG");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				objSesion.SqlConexion.Execute("pUsuario", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioDatos- Borrar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}

			return bolResultado;
		}

		public List<UsuarioMenuModelo> ListarMenu(string Accion, string Json)
		{
			try
			{
				AbrirConexion("SEG");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				List<UsuarioMenuModelo> LisUsuario = SqlMapper.Query<UsuarioMenuModelo>(objSesion.SqlConexion, "pUsuarioMenu", param, commandType: CommandType.StoredProcedure).ToList();
				return LisUsuario.Count == 0 ? null : LisUsuario;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioDatos- ListarMenu");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}
	}
}