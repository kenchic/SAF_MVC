using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreSAF.Modelos;

namespace CoreSAF.Negocios
{
	public class ContratoNegocio
    {
		private readonly ContratoDatos ObjContrato = new ContratoDatos();
		
		public void SetConexion(string value)
		{
			ObjContrato.Conexion = value;
		}

		public List<ContratoModelo> Listar()
		{
			try
			{
				IList<ContratoModelo> LisContrato = ObjContrato.Listar("0");
				return LisContrato.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ContratoNegocio - Listar");
				throw;
			}
		}

		public List<ContratoModelo> ListarActivos()
		{
			try
			{
				IList<ContratoModelo> LisContrato = ObjContrato.Listar("1");
				return LisContrato.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ContratoNegocio - ListarActivos");
				throw;
			}
		}

		public ContratoModelo Consultar(int id)
		{
			try
			{
				ContratoModelo objConsultar = new ContratoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjContrato.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ContratoNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ContratoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjContrato.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ContratoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ContratoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjContrato.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ContratoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ContratoModelo objBorrar = new ContratoModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjContrato.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ContratoNegocio - Borrar");
				throw;
			}
		}
	}
}