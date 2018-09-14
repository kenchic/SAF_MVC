///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//////  UsuarioRepository
//////  SAF - Integral Solutions SAS
//////  Implementacion Repositorio:	Usuario
//////  Creacion:      				23/07/2018
//////  Autor: 						German Alvarez
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//////  UsuarioRepository
//////  CoreSeg - Integral Solutions SAS
//////  Implementacion Repositorio:	Usuario
//////  Creacion:      				10/09/2018
//////  Autor: 						German Alvarez
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSeg.Models;

namespace CoreSeg.Datos
{
	public class UsuarioRepository
	{
		private SqlConnection SqlConexion;
		public string Conexion { get; set; }

		private void Conectar()
		{
			SqlConexion = new SqlConnection(Conexion);
		}

		public List<UsuarioModel> Listar(string Accion)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				SqlConexion.Open();
				IList<UsuarioModel> LisUsuario = SqlMapper.Query<UsuarioModel>(SqlConexion, "PUsuario", param, commandType: CommandType.StoredProcedure).ToList();
				return LisUsuario.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioRepository - Listar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}
		}

		public UsuarioModel Consultar(string Accion, string Json)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				SqlConexion.Open();
				IList<UsuarioModel> LisUsuario = SqlMapper.Query<UsuarioModel>(SqlConexion, "PUsuario", param, commandType: CommandType.StoredProcedure).ToList();
				return LisUsuario[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioRepository - Consultar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}
		}

		public void Insertar(string Accion, string Json)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				SqlConexion.Open();
				SqlConexion.Execute("PUsuario", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioRepository - Insertar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}
		}

		public void Editar(string Accion, string Json)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				SqlConexion.Open();
				SqlConexion.Execute("PUsuario", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioRepository - Editar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}
		}

		public bool Borrar(string Accion, string Json)
		{
			bool bolResultado = false;
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				SqlConexion.Open();
				SqlConexion.Execute("PUsuario", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSeg.Repository.UsuarioRepository - Borrar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}

			return bolResultado;
		}
	}
}