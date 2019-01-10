using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CoreCore.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;

namespace CoreCore.Datos
{
	public class ParametroDatos
	{
		private SqlConnection SqlConexion;
		public string Conexion { get; set; }

		private void Conectar()
		{
			SqlConexion = new SqlConnection(Conexion);
		}

		public List<ParametroModelo> Listar(string Accion)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				SqlConexion.Open();
				IList<ParametroModelo> LisParametro = SqlMapper.Query<ParametroModelo>(SqlConexion, "pParametro", param, commandType: CommandType.StoredProcedure).ToList();
				return LisParametro.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Repository.ParametroRepository - Listar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}
		}

		public ParametroModelo Consultar(string Accion, string Json)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				SqlConexion.Open();
				IList<ParametroModelo> LisParametro = SqlMapper.Query<ParametroModelo>(SqlConexion, "pParametro", param, commandType: CommandType.StoredProcedure).ToList();
				return LisParametro[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Repository.ParametroRepository - Consultar");
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
				SqlConexion.Execute("pParametro", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Repository.ParametroRepository - Operacion");
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
				SqlConexion.Execute("pParametro", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Repository.ParametroRepository - Operacion");
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
				SqlConexion.Execute("pParametro", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Repository.ParametroRepository - Operacion");
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