using System;
using System.Collections.Generic;
using System.Data;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreSEG.Datos;
using CoreGeneral;
using CoreGeneral.Recursos;

namespace CoreSAF.Datos
{
	public class AgenteDatos : SesionDatos
	{
		public List<AgenteModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<AgenteModelo> LisAgente = SqlMapper.Query<AgenteModelo>(objSesion.SqlConexion, "SAF.pAgente", param, commandType: CommandType.StoredProcedure).ToList();
				return LisAgente.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Listar");
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
				IList<AgenteModelo> LisAgente = SqlMapper.Query<AgenteModelo>(objSesion.SqlConexion, "SAF.pAgente", param, commandType: CommandType.StoredProcedure).ToList();
				return LisAgente[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Consultar");
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
                objSesion.SqlConexion.Execute("SAF.pAgente", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Insertar");
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
                objSesion.SqlConexion.Execute("SAF.pAgente", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Editar");
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
                objSesion.SqlConexion.Execute("SAF.pAgente", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.AgenteDatos - Borrar");
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