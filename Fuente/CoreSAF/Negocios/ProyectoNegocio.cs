using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreGeneral.Modelos.SAF;
using CoreGeneral.Modelos.SEG;
using System.Data;

namespace CoreSAF.Negocios
{
	public class ProyectoNegocio
    {
		private readonly ProyectoDatos objProyecto = new ProyectoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objProyecto.Session = objSesion;
        }

        public List<VProyectoModelo> Listar()
		{
			try
			{
				IList<VProyectoModelo> lisProyecto = objProyecto.Listar("0");
				return lisProyecto.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Listar");
				throw;
			}
		}

		public List<VProyectoModelo> ListarActivos()
		{
			try
			{
				IList<VProyectoModelo> lisProyecto = objProyecto.Listar("1");
				return lisProyecto.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - ListarActivos");
				throw;
			}
		}

		public VProyectoModelo Consultar(int id)
		{
			try
			{
				VProyectoModelo objConsultar = new VProyectoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objProyecto.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ProyectoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objProyecto.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ProyectoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objProyecto.Editar("4", Json);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ProyectoModelo objBorrar = new ProyectoModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objProyecto.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Borrar");
				throw;
			}
		}

		public DataTable PlantillaListar(int id)
		{
			try
			{
				VProyectoModelo objConsultar = new VProyectoModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				DataTable datPlantilla = objProyecto.PlantillaListar("6", Json);
				return datPlantilla;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Negocios.ProyectoNegocio - Plantilla Listar");
				throw;
			}
		}
	}
}