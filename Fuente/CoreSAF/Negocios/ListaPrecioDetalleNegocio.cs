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
	public class ListaPrecioDetalleNegocio
    {
		private readonly ListaPrecioDetalleDatos objListaPrecioDetalle = new ListaPrecioDetalleDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objListaPrecioDetalle.objSesion = objSesion;
        }

        public List<ListaPrecioDetalleModelo> Listar()
		{
			try
			{
				IList<ListaPrecioDetalleModelo> LisListaPrecioDetalle = objListaPrecioDetalle.Listar("0");
				return LisListaPrecioDetalle.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - Listar");
				throw;
			}
		}

		public List<ListaPrecioDetalleModelo> ListarActivos()
		{
			try
			{
				IList<ListaPrecioDetalleModelo> LisListaPrecioDetalle = objListaPrecioDetalle.Listar("1");
				return LisListaPrecioDetalle.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - ListarActivos");
				throw;
			}
		}

		public List<VListaPrecioDetalleModelo> Consultar(int id)
		{
			try
			{
                VListaPrecioDetalleModelo objConsultar = new VListaPrecioDetalleModelo();
				objConsultar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objListaPrecioDetalle.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(ListaPrecioDetalleModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objListaPrecioDetalle.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ListaPrecioDetalleModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objListaPrecioDetalle.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				ListaPrecioDetalleModelo objBorrar = new ListaPrecioDetalleModelo();
				objBorrar.Id = (short)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objListaPrecioDetalle.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - Borrar");
				throw;
			}
		}

        public void InsertarMasivo(List<ListaPrecioDetalleModelo> objInsertar)
        {
            try
            {
                string Json = JsonConvert.SerializeObject(objInsertar);
                objListaPrecioDetalle.Insertar("3", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ListaPrecioDetalleNegocio - Insertar");
                throw;
            }
        }

         public List<VListaPrecioDetalleModelo> CrearListaDetalleNueva()
        {
            try
            {
                ElementoNegocio objElemento = new ElementoNegocio();
                objElemento.AsignarSesion(objListaPrecioDetalle.objSesion);
                
                List<VElementoModelo> lisElementos = objElemento.Listar();
                List<VListaPrecioDetalleModelo> ObjDetalle = new List<VListaPrecioDetalleModelo>();

                for (int i = 0; i < lisElementos.Count; i++)
                {
                    VListaPrecioDetalleModelo objLista = new VListaPrecioDetalleModelo();
                    objLista.idElemento = lisElementos[i].Id;
                    objLista.ElementoNombre = lisElementos[i].Nombre;
                    objLista.PrecioAlquiler = 0;
                    objLista.PrecioPerdida = 0;
                    objLista.PrecioVenta = 0;
                    ObjDetalle.Add(objLista);
                }
                return ObjDetalle;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ListaPrecioDetalleNegocio - Insertar");
                throw;
            }
        }
    }
}