using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreSAF.Datos;
using CoreGeneral.Modelos.SAF;
using CoreGeneral.Modelos.SEG;

namespace CoreSAF.Negocios
{
	public class BodegaNegocio
    {
		private readonly BodegaDatos ObjBodega = new BodegaDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            ObjBodega.Session = objSesion;
        }

        public List<VBodegaModelo> Listar()
		{
			try
			{
				IList<VBodegaModelo> LisBodega = ObjBodega.Listar("0");
				return LisBodega.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Listar");
				throw;
			}
		}

		public List<VBodegaModelo> ListarActivos()
		{
			try
			{
				IList<VBodegaModelo> LisBodega = ObjBodega.Listar("1");
				return LisBodega.ToList();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - ListarActivos");
				throw;
			}
		}

		public VBodegaModelo Consultar(int id)
		{
			try
			{
                VBodegaModelo objConsultar = new VBodegaModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return ObjBodega.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Consultar");
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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Insertar");
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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Editar");
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
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, ".Negocios.BodegaNegocio - Borrar");
				throw;
			}
		}
	}
}