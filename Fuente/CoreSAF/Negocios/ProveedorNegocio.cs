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
	public class ProveedorNegocio
    {
		private readonly ProveedorDatos ObjProveedor = new ProveedorDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            ObjProveedor.objSesion = objSesion;
        }

        public List<ProveedorModelo> Listar()
		{
			try
			{
				IList<ProveedorModelo> LisProveedor = ObjProveedor.Listar("0");
				return LisProveedor.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProveedorNegocio - Listar");
				throw;
			}
		}

		public List<ProveedorModelo> ListarActivos()
		{
			try
			{
				IList<ProveedorModelo> LisProveedor = ObjProveedor.Listar("1");
				return LisProveedor.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProveedorNegocio - ListarActivos");
				throw;
			}
		}

		public ProveedorModelo Consultar(int id)
		{
			try
			{
				ProveedorModelo objConsultar = new ProveedorModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjProveedor.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProveedorNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ProveedorModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjProveedor.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProveedorNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ProveedorModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjProveedor.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProveedorNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ProveedorModelo objBorrar = new ProveedorModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjProveedor.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProveedorNegocio - Borrar");
				throw;
			}
		}
	}
}