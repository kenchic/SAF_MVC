using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Modelos.SEG;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace CoreSEG.Datos
{
    public class AutenticacionDatos : SesionDatos
    {
		public void Insertar(string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "3");
				param.Add("@Json", Json);
				Session.SqlConexion.Execute("SEG.pAutenticacion", param, commandType: CommandType.StoredProcedure);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Repository.AutenticacionDatos- Insertar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}

		public bool Verificar(string Json)
		{
			try
			{
				AbrirConexion();
				DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "2");
				param.Add("@Json", Json);
				List<AutenticacionModelo> lisAutenticacion = SqlMapper.Query<AutenticacionModelo>(Session.SqlConexion, "SEG.pAutenticacion", param, commandType: CommandType.StoredProcedure).ToList();
				return lisAutenticacion.Count > 0;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Repository.AutenticacionDatos- Verificar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}
	}
}
