using System;
using System.Collections.Generic;
using System.Data;
using Dapper;
using System.Linq;
using CoreGeneral.Modelos.SAF;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Datos;

namespace CoreSAF.Datos
{
	public class AgenteDatos : BaseDatos
	{
		public List<AgenteModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<AgenteModelo> LisAgente = SqlMapper.Query<AgenteModelo>(Session.SqlConexion, "SAF.pAgente", param, commandType: CommandType.StoredProcedure).ToList();
				return LisAgente.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public AgenteModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<AgenteModelo> LisAgente = SqlMapper.Query<AgenteModelo>(Session.SqlConexion, "SAF.pAgente", param, commandType: CommandType.StoredProcedure).ToList();
				return LisAgente[0];
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Consultar");
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
                Session.SqlConexion.Execute("SAF.pAgente", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Insertar");
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
                Session.SqlConexion.Execute("SAF.pAgente", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Editar");
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
                Session.SqlConexion.Execute("SAF.pAgente", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Borrar");
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