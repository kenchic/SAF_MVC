using System;
using System.Collections.Generic;
using System.Data;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSEG.Datos;

namespace CoreSAF.Datos
{
	public class UnidadMedidaDatos : SesionDatos
	{
		public List<UnidadMedidaModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<UnidadMedidaModelo> LisUnidadMedida = SqlMapper.Query<UnidadMedidaModelo>(objSesion.SqlConexion, "SAF.pUnidadMedida", param, commandType: CommandType.StoredProcedure).ToList();
				return LisUnidadMedida.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.UnidadMedidaDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public UnidadMedidaModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<UnidadMedidaModelo> LisUnidadMedida = SqlMapper.Query<UnidadMedidaModelo>(objSesion.SqlConexion, "SAF.pUnidadMedida", param, commandType: CommandType.StoredProcedure).ToList();
				return LisUnidadMedida[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.UnidadMedidaDatos - Consultar");
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
				objSesion.SqlConexion.Execute("SAF.pUnidadMedida", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.UnidadMedidaDatos - Insertar");
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
				objSesion.SqlConexion.Execute("SAF.pUnidadMedida", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.UnidadMedidaDatos - Editar");
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
				objSesion.SqlConexion.Execute("SAF.pUnidadMedida", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.UnidadMedidaDatos - Borrar");
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