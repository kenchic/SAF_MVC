using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CoreCoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;

namespace CoreCoreSAF.Datos
{
	public class ProveedorDatos
	{
		private SqlConnection SqlConexion;
		public string Conexion { get; set; }

		private void Conectar()
		{
			SqlConexion = new SqlConnection(Conexion);
		}

		public List<ProveedorModelo> Listar(string Accion)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				SqlConexion.Open();
				IList<ProveedorModelo> LisProveedor = SqlMapper.Query<ProveedorModelo>(SqlConexion, "pProveedor", param, commandType: CommandType.StoredProcedure).ToList();
				return LisProveedor.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Repository.ProveedorRepository - Listar");
				throw;
			}
			finally
			{
				SqlConexion.Close();
			}
		}

		public ProveedorModelo Consultar(string Accion, string Json)
		{
			try
			{
				Conectar();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				SqlConexion.Open();
				IList<ProveedorModelo> LisProveedor = SqlMapper.Query<ProveedorModelo>(SqlConexion, "pProveedor", param, commandType: CommandType.StoredProcedure).ToList();
				return LisProveedor[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Repository.ProveedorRepository - Consultar");
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
				SqlConexion.Execute("pProveedor", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Repository.ProveedorRepository - Operacion");
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
				SqlConexion.Execute("pProveedor", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Repository.ProveedorRepository - Operacion");
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
				SqlConexion.Execute("pProveedor", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Repository.ProveedorRepository - Operacion");
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