﻿using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreSAF.Models;

namespace CoreSAF.Negocios
{
	public class AgenteNegocio
    {
		private readonly AgenteRepository ObjAgente = new AgenteRepository();

		public void SetConexion(string value)
		{
			ObjAgente.Conexion = value;
		}

		public List<AgenteModel> Listar()
		{
			try
			{
				IList<AgenteModel> LisAgente = ObjAgente.Listar("0");
				return LisAgente.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - Listar");
				throw;
			}
		}

		public List<AgenteModel> ListarActivos()
		{
			try
			{
				IList<AgenteModel> LisAgente = ObjAgente.Listar("1");
				return LisAgente.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - ListarActivos");
				throw;
			}
		}

		public AgenteModel Consultar(int id)
		{
			try
			{				
				AgenteModel objConsultar = new AgenteModel();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjAgente.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(AgenteModel objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjAgente.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - Insertar");
				throw;
			}
		}

		public void Editar(AgenteModel objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjAgente.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				AgenteModel objBorrar = new AgenteModel();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjAgente.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - Borrar");
				throw;
			}
		}
	}
}
