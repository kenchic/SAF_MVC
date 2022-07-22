using System;
using System.Collections.Generic;
using System.Data;
using CoreGeneral.Modelos.GES;
using Dapper;
using System.Linq;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using Newtonsoft.Json;

namespace GES.Api.Datos
{
	public class CatalogoDatos : BaseDatos
	{
		public CatalogoDatos()
		{
			Procedimiento = "GES.pCatalogo";
		}

		public List<CatalogoDetalleModelo> ListarDetalleTodos(CatalogoDetalleModelo catalogoDetalle)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "ListarDetalleTodos");
				param.Add("@Json", JsonConvert.SerializeObject(catalogoDetalle));
				List<CatalogoDetalleModelo> lista = SqlMapper.Query<CatalogoDetalleModelo>(Conexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
				return lista.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CatalogoDatos - ListarDetalle");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public List<CatalogoDetalleModelo> ListarDetalleActivos(CatalogoDetalleModelo catalogoDetalle)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "ListarDetalleActivos");
				param.Add("@Json", JsonConvert.SerializeObject(catalogoDetalle));
				IList<CatalogoDetalleModelo> LisCatalogo = SqlMapper.Query<CatalogoDetalleModelo>(Conexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CatalogoDatos - ListarDetalleActivos");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public CatalogoDetalleModelo ConsultarDetalle(CatalogoDetalleModelo catalogoDetalle)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "ConsultarDetalle");
				param.Add("@Json", JsonConvert.SerializeObject(catalogoDetalle));
				IList<CatalogoDetalleModelo> LisCatalogo = SqlMapper.Query<CatalogoDetalleModelo>(Conexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
				if (LisCatalogo.Count > 0)
					return LisCatalogo[0];
				else
					return null;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - ConsultarDetalle");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}
	}
}