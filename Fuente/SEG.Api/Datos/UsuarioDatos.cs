using System;
using System.Collections.Generic;
using System.Data;
using Dapper;
using System.Linq;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Modelos.SEG;
using Newtonsoft.Json;

namespace SEG.Api.Datos
{
	public class UsuarioDatos : BaseDatos
	{
		public UsuarioDatos()
		{
			Procedimiento = "SEG.pUsuario";
		}

		public bool Autenticar(ref UsuarioModelo usuario)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "Autenticar");
				param.Add("@Json", JsonConvert.SerializeObject(usuario));
				List<UsuarioModelo> LisUsuario = SqlMapper.Query<UsuarioModelo>(Conexion, "SEG.pUsuario", param, commandType: CommandType.StoredProcedure).ToList();
				usuario = LisUsuario.Count == 0 ? null : LisUsuario[0];
				return usuario != null;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "UsuarioDatos - Autenticar");
				throw;
			}
			finally
            {
				CerrarConexion();
            }
		}

		public List<UsuarioMenuModelo> ListarMenu(UsuarioModelo usuario)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "ListarMenu");
				param.Add("@Json", JsonConvert.SerializeObject(usuario));
				List<UsuarioMenuModelo> LisUsuario = SqlMapper.Query<UsuarioMenuModelo>(Conexion, "SEG.pUsuario", param, commandType: CommandType.StoredProcedure).ToList();
				return LisUsuario.Count == 0 ? null : LisUsuario;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "UsuarioDatos- ListarMenu");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}
	}
}