using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;

namespace CoreSAF.Datos
{
	public class TipoMantenimientoDatos
	{
		private SqlConnection SqlConexion;
		public string Conexion { get; set; }

		private void Conectar()
		{
			SqlConexion = new SqlConnection(Conexion);
		}

		public List<TipoMantenimientoModelo> Listar(string Accion)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				SqlConexion.Open();
				IList<TipoMantenimientoModelo> LisTipoMantenimiento = SqlMapper.Query<TipoMantenimientoModelo>(SqlConexion, "pTipoMantenimiento", param, commandType: CommandType.StoredProcedure).ToList();
				return LisTipoMantenimiento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoMantenimientoRepository - Listar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}
		}

		public TipoMantenimientoModelo Consultar(string Accion, string Json)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				SqlConexion.Open();
				IList<TipoMantenimientoModelo> LisTipoMantenimiento = SqlMapper.Query<TipoMantenimientoModelo>(SqlConexion, "pTipoMantenimiento", param, commandType: CommandType.StoredProcedure).ToList();
				return LisTipoMantenimiento[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoMantenimientoRepository - Consultar");
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
				SqlConexion.Execute("pTipoMantenimiento", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoMantenimientoRepository - Operacion");
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
				SqlConexion.Execute("pTipoMantenimiento", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoMantenimientoRepository - Operacion");
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
				SqlConexion.Execute("pTipoMantenimiento", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoMantenimientoRepository - Operacion");
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