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
	public class ConductorNegocio
    {
		private readonly ConductorDatos ObjConductor = new ConductorDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            ObjConductor.objSesion = objSesion;
        }

        public List<ConductorModelo> Listar()
		{
			try
			{
				IList<ConductorModelo> LisConductor = ObjConductor.Listar("0");
				return LisConductor.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ConductorNegocio - Listar");
				throw;
			}
		}

		public List<ConductorModelo> ListarActivos()
		{
			try
			{
				IList<ConductorModelo> LisConductor = ObjConductor.Listar("1");
				return LisConductor.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ConductorNegocio - ListarActivos");
				throw;
			}
		}

		public ConductorModelo Consultar(int id)
		{
			try
			{
				ConductorModelo objConsultar = new ConductorModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjConductor.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ConductorNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ConductorModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				ObjConductor.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ConductorNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ConductorModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				ObjConductor.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ConductorNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ConductorModelo objBorrar = new ConductorModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return ObjConductor.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ConductorNegocio - Borrar");
				throw;
			}
		}
	}
}