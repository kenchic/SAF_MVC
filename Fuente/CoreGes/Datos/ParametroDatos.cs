using System;
using System.Collections.Generic;
using System.Data;
using CoreGeneral.Modelos.GES;
using Dapper;
using System.Linq;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreSEG.Datos;

namespace CoreGES.Datos
{
	public class ParametroDatos : SesionDatos
	{
		public List<ParametroModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<ParametroModelo> LisParametro = SqlMapper.Query<ParametroModelo>(Session.SqlConexion, "GES.pParametro", param, commandType: CommandType.StoredProcedure).ToList();
				return LisParametro.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ParametroDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public ParametroModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<ParametroModelo> LisParametro = SqlMapper.Query<ParametroModelo>(Session.SqlConexion, "GES.pParametro", param, commandType: CommandType.StoredProcedure).ToList();
                if (LisParametro.Count > 0)
                    return LisParametro[0];
                else
                    return null;
            }
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ParametroDatos - Consultar");
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
				Session.SqlConexion.Execute("GES.pParametro", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ParametroDatos - Insertar");
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
				Session.SqlConexion.Execute("GES.pParametro", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ParametroDatos - Editar");
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
				Session.SqlConexion.Execute("GES.pParametro", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ParametroDatos - Borrar");
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