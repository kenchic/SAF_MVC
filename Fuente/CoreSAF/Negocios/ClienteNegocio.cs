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
	public class ClienteNegocio
    {
		private readonly ClienteDatos ObjCliente = new ClienteDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            ObjCliente.objSesion = objSesion;
        }

        public List<VClienteModelo> Listar()
		{
			try
			{
				IList<VClienteModelo> LisCliente = ObjCliente.Listar("0");
				return LisCliente.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ClienteNegocio - Listar");
				throw;
			}
		}

		public List<VClienteModelo> ListarActivos()
		{
			try
			{
				IList<VClienteModelo> LisCliente = ObjCliente.Listar("1");
				return LisCliente.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ClienteNegocio - ListarActivos");
				throw;
			}
		}

		public VClienteModelo Consultar(int id)
		{
			try
			{
                VClienteModelo objConsultar = new VClienteModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjCliente.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ClienteNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ClienteModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjCliente.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ClienteNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ClienteModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjCliente.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ClienteNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ClienteModelo objBorrar = new ClienteModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjCliente.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ClienteNegocio - Borrar");
				throw;
			}
		}
	}
}