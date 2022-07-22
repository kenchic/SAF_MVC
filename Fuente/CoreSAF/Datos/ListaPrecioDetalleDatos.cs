using System;
using System.Collections.Generic;
using System.Data;
using CoreGeneral.Modelos.SAF;
using Dapper;
using System.Linq;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreSEG.Datos;

namespace CoreSAF.Datos
{
	public class ListaPrecioDetalleDatos : SesionDatos
	{
		public List<ListaPrecioDetalleModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<ListaPrecioDetalleModelo> LisListaPrecioDetalle = SqlMapper.Query<ListaPrecioDetalleModelo>(Session.SqlConexion, "SAF.pListaPrecioDetalle", param, commandType: CommandType.StoredProcedure).ToList();
				return LisListaPrecioDetalle.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.ListaPrecioDetalleDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public List<VListaPrecioDetalleModelo> Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<VListaPrecioDetalleModelo> LisListaPrecioDetalle = SqlMapper.Query<VListaPrecioDetalleModelo>(Session.SqlConexion, "SAF.pListaPrecioDetalle", param, commandType: CommandType.StoredProcedure).ToList();
				return LisListaPrecioDetalle.ToList();
            }
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.ListaPrecioDetalleDatos - Consultar");
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
				Session.SqlConexion.Execute("SAF.pListaPrecioDetalle", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.ListaPrecioDetalleDatos - Insertar");
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
				Session.SqlConexion.Execute("SAF.pListaPrecioDetalle", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.ListaPrecioDetalleDatos - Editar");
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
				Session.SqlConexion.Execute("SAF.pListaPrecioDetalle", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.ListaPrecioDetalleDatos - Borrar");
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