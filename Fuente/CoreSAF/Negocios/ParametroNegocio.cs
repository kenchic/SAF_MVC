using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreCore.Datos;
using CoreCore.Modelos;

namespace CoreCore.Negocios
{
	public class ParametroNegocio
    {
		private readonly ParametroDatos ObjParametro = new ParametroDatos();
		
		public void SetConexion(string value)
		{
			ObjParametro.Conexion = value;
		}

		public List<ParametroModelo> Listar()
		{
			try
			{
				IList<ParametroModelo> LisParametro = ObjParametro.Listar("0");
				return LisParametro.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Listar");
				throw;
			}
		}

		public List<ParametroModelo> ListarActivos()
		{
			try
			{
				IList<ParametroModelo> LisParametro = ObjParametro.Listar("1");
				return LisParametro.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - ListarActivos");
				throw;
			}
		}

		public ParametroModelo Consultar(string codigo)
		{
			try
			{
				ParametroModelo objConsultar = new ParametroModelo();
				objConsultar.Codigo = codigo;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjParametro.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ParametroModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjParametro.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ParametroModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjParametro.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(string codigo)
		{
			try
			{
				ParametroModelo objBorrar = new ParametroModelo();
				objBorrar.Codigo = codigo;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjParametro.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Borrar");
				throw;
			}
		}
	}
}