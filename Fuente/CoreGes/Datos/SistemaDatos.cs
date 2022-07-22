using System;
using System.Collections.Generic;
using System.Data;
using Dapper;
using System.Linq;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Modelos.GES;
using CoreSEG.Datos;

namespace CoreGES.Datos
{
	public class SistemaDatos : SesionDatos
	{
		public List<SistemaModelo> Listar(string Accion)
		{
			try
			{
                AbrirConexion("GES");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				List<SistemaModelo> LisSistema = SqlMapper.Query<SistemaModelo>(Session.SqlConexion, "GES.pSistema", param, commandType: CommandType.StoredProcedure).ToList();
				return LisSistema.Count == 0 ? null : LisSistema;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreGES.Repository.SistemaDatos- Listar");
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
				AbrirConexion("GES");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				List<SistemaModelo> LisSistema = SqlMapper.Query<SistemaModelo>(Session.SqlConexion, "GES.pSistema", param, commandType: CommandType.StoredProcedure).ToList();				
				return LisSistema.Count == 0 ? null : LisSistema[0];
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreGES.Repository.SistemaDatos- Consultar");
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
                AbrirConexion("GES");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				Session.SqlConexion.Execute("GES.pSistema", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreGES.Repository.SistemaDatos- Insertar");
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
                AbrirConexion("GES");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				Session.SqlConexion.Execute("GES.pSistema", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreGES.Repository.SistemaDatos- Editar");
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
                AbrirConexion("GES");
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				Session.SqlConexion.Execute("GES.pSistema", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreGES.Repository.SistemaDatos- Borrar");
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