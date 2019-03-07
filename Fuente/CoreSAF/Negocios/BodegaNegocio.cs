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
	public class BodegaNegocio
    {
		private readonly BodegaDatos ObjBodega = new BodegaDatos();
		
		public void SetConexion(string value)
		{
			ObjBodega.Conexion = value;
		}

		public List<BodegaModelo> Listar()
		{
			try
			{
				IList<BodegaModelo> LisBodega = ObjBodega.Listar("0");
				return LisBodega.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Listar");
				throw;
			}
		}

		public List<BodegaModelo> ListarActivos()
		{
			try
			{
				IList<BodegaModelo> LisBodega = ObjBodega.Listar("1");
				return LisBodega.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - ListarActivos");
				throw;
			}
		}

		public BodegaModelo Consultar(int id)
		{
			try
			{
				BodegaModelo objConsultar = new BodegaModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjBodega.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(BodegaModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjBodega.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Insertar");
				throw;
			}
		}

		public void Editar(BodegaModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjBodega.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				BodegaModelo objBorrar = new BodegaModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjBodega.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Borrar");
				throw;
			}
		}
	}
}