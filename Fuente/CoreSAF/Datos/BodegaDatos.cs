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
	public class BodegaDatos : SesionDatos
    {
		public List<VBodegaModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<VBodegaModelo> LisBodega = SqlMapper.Query<VBodegaModelo>(objSesion.SqlConexion, "SAF.pBodega", param, commandType: CommandType.StoredProcedure).ToList();
				return LisBodega.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.BodegaDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public VBodegaModelo Consultar(string Accion, string Json)
		{
			try
			{
                AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<VBodegaModelo> LisBodega = SqlMapper.Query<VBodegaModelo>(objSesion.SqlConexion, "SAF.pBodega", param, commandType: CommandType.StoredProcedure).ToList();
				return LisBodega[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.BodegaDatos - Consultar");
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
                objSesion.SqlConexion.Execute("SAF.pBodega", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.BodegaDatos - Insertar");
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
                objSesion.SqlConexion.Execute("SAF.pBodega", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.BodegaDatos - Editar");
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
                objSesion.SqlConexion.Execute("SAF.pBodega", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.BodegaDatos - Borrar");
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