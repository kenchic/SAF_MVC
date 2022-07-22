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
	public class CatalogoDatos : SesionDatos
	{
		public List<CatalogoModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion("GES");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<CatalogoModelo> LisCatalogo = SqlMapper.Query<CatalogoModelo>(Session.SqlConexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public CatalogoModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion("GES");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<CatalogoModelo> LisCatalogo = SqlMapper.Query<CatalogoModelo>(Session.SqlConexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
                if (LisCatalogo.Count > 0)
                    return LisCatalogo[0];
                else
                    return null;
            }
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - Consultar");
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
				Session.SqlConexion.Execute("GES.pCatalogo", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - Insertar");
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
				Session.SqlConexion.Execute("GES.pCatalogo", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - Editar");
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
				Session.SqlConexion.Execute("GES.pCatalogo", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - Borrar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}

			return bolResultado;
		}

		public List<CatalogoDetalleModelo> ListarDetalle(string Accion, string Json)
		{
			try
			{
				AbrirConexion("GES");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				List<CatalogoDetalleModelo> LisCatalogo = SqlMapper.Query<CatalogoDetalleModelo>(Session.SqlConexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - ListarDetalle");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public List<CatalogoDetalleModelo> ListarDetalleActivos(string Accion, string Json)
		{
			try
			{
				AbrirConexion("GES");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<CatalogoDetalleModelo> LisCatalogo = SqlMapper.Query<CatalogoDetalleModelo>(Session.SqlConexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.CatalogoDatos - ListarDetalleActivos");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public CatalogoDetalleModelo ConsultarDetalle(string Accion, string Json)
		{
			try
			{
				AbrirConexion("GES");
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<CatalogoDetalleModelo> LisCatalogo = SqlMapper.Query<CatalogoDetalleModelo>(Session.SqlConexion, "GES.pCatalogo", param, commandType: CommandType.StoredProcedure).ToList();
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