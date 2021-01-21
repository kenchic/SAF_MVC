using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreSAF.Modelos;
using CoreSEG.Modelos;

namespace CoreSAF.Negocios
{
	public class AgenteNegocio
    {
		private readonly AgenteDatos ObjAgente = new AgenteDatos();

		public void AsignarSesion(SesionModelo objSesion)
		{
			ObjAgente.objSesion = objSesion;
		}

        public List<AgenteModelo> Listar()
		{
			try
			{
				IList<AgenteModelo> LisAgente = ObjAgente.Listar("0");
				return LisAgente.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - Listar");
				throw;
			}
		}

		public List<AgenteModelo> ListarActivos()
		{
			try
			{
				IList<AgenteModelo> LisAgente = ObjAgente.Listar("1");
				return LisAgente.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.AgenteNegocio - ListarActivos");
				throw;
			}
		}

		public AgenteModelo Consultar(int id)
		{
			try
			{				
				AgenteModelo objConsultar = new AgenteModelo();
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

		public void Insertar(AgenteModelo objInsertar)
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

		public void Editar(AgenteModelo objEditar)
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
				AgenteModelo objBorrar = new AgenteModelo();
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
