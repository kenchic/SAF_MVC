using System;
using System.Collections.Generic;
using System.Data;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSEG.Modelos;

namespace CoreSEG.Datos
{
	public class SistemaDatos : SesionDatos
	{
		public List<SistemaModelo> Listar(string Accion)
		{
			try
			{
                AbrirConexion("SEG");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				List<SistemaModelo> LisSistema = SqlMapper.Query<SistemaModelo>(objSesion.SqlConexion, "SEG.pSistema", param, commandType: CommandType.StoredProcedure).ToList();
				return LisSistema.Count == 0 ? null : LisSistema;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Repository.SistemaDatos- Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public SistemaModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion("SEG");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				List<SistemaModelo> LisSistema = SqlMapper.Query<SistemaModelo>(objSesion.SqlConexion, "SEG.pSistema", param, commandType: CommandType.StoredProcedure).ToList();				
				return LisSistema.Count == 0 ? null : LisSistema[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Repository.SistemaDatos- Consultar");
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
				objSesion.SqlConexion.Execute("SEG.pSistema", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Repository.SistemaDatos- Insertar");
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
				objSesion.SqlConexion.Execute("SEG.pSistema", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Repository.SistemaDatos- Editar");
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
				objSesion.SqlConexion.Execute("SEG.pSistema", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Repository.SistemaDatos- Borrar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}

			return bolResultado;
		}
	}
}