using System;
using System.Collections.Generic;
using System.Data;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreSEG.Datos;

namespace CoreSAF.Datos
{
	public class TipoMantenimientoDatos : SesionDatos
	{
		public List<TipoMantenimientoModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<TipoMantenimientoModelo> LisTipoMantenimiento = SqlMapper.Query<TipoMantenimientoModelo>(Session.SqlConexion, "SAF.pTipoMantenimiento", param, commandType: CommandType.StoredProcedure).ToList();
				return LisTipoMantenimiento.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoMantenimientoDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public TipoMantenimientoModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<TipoMantenimientoModelo> LisTipoMantenimiento = SqlMapper.Query<TipoMantenimientoModelo>(Session.SqlConexion, "SAF.pTipoMantenimiento", param, commandType: CommandType.StoredProcedure).ToList();
				return LisTipoMantenimiento[0];
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoMantenimientoDatos - Consultar");
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
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				Session.SqlConexion.Execute("SAF.pTipoMantenimiento", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoMantenimientoDatos - Insertar");
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
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				Session.SqlConexion.Execute("SAF.pTipoMantenimiento", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoMantenimientoDatos - Editar");
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
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				Session.SqlConexion.Execute("SAF.pTipoMantenimiento", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoMantenimientoDatos - Borrar");
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