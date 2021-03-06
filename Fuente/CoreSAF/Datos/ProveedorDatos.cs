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
	public class ProveedorDatos : SesionDatos
    {
		public List<ProveedorModelo> Listar(string Accion)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", "");
				IList<ProveedorModelo> LisProveedor = SqlMapper.Query<ProveedorModelo>(objSesion.SqlConexion, "SAF.pProveedor", param, commandType: CommandType.StoredProcedure).ToList();
				return LisProveedor.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Datos.ProveedorDatos - Listar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public ProveedorModelo Consultar(string Accion, string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", Accion);
				param.Add("@Json", Json);
				IList<ProveedorModelo> LisProveedor = SqlMapper.Query<ProveedorModelo>(objSesion.SqlConexion, "SAF.pProveedor", param, commandType: CommandType.StoredProcedure).ToList();
				return LisProveedor[0];
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Datos.ProveedorDatos - Consultar");
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
                objSesion.SqlConexion.Execute("SAF.pProveedor", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Datos.ProveedorDatos - Insertar");
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
                objSesion.SqlConexion.Execute("SAF.pProveedor", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Datos.ProveedorDatos - Editar");
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
                objSesion.SqlConexion.Execute("SAF.pProveedor", param, commandType: CommandType.StoredProcedure);
				bolResultado = true;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCoreSAF.Datos.ProveedorDatos - Borrar");
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