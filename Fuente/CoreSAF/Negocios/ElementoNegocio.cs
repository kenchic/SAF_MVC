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
	public class ElementoNegocio
    {
		private readonly ElementoDatos ObjElemento = new ElementoDatos();
		
		public void SetConexion(string value)
		{
			ObjElemento.Conexion = value;
		}

		public List<VElementoModelo> Listar()
		{
			try
			{
				IList<VElementoModelo> LisElemento = ObjElemento.Listar("0");
				return LisElemento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - Listar");
				throw;
			}
		}

		public List<VElementoModelo> ListarActivos()
		{
			try
			{
				IList<VElementoModelo> LisElemento = ObjElemento.Listar("1");
				return LisElemento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - ListarActivos");
				throw;
			}
		}

		public VElementoModelo Consultar(int id)
		{
			try
			{
				VElementoModelo objConsultar = new VElementoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjElemento.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ElementoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjElemento.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ElementoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjElemento.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ElementoModelo objBorrar = new ElementoModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjElemento.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - Borrar");
				throw;
			}
		}
	}
}