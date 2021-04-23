using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSEG.Datos;
using CoreSEG.Modelos;

namespace CoreSEG.Negocios
{
	public class CatalogoNegocio
    {
		private readonly CatalogoDatos objCatalogo = new CatalogoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objCatalogo.objSesion = objSesion;
        }

        public List<CatalogoModelo> Listar()
		{
			try
			{
				IList<CatalogoModelo> LisCatalogo = objCatalogo.Listar("0");
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - Listar");
				throw;
			}
		}

		public List<CatalogoModelo> ListarActivos()
		{
			try
			{
				IList<CatalogoModelo> LisCatalogo = objCatalogo.Listar("1");
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - ListarActivos");
				throw;
			}
		}

		public CatalogoModelo Consultar(string id)
		{
			try
			{
                CatalogoModelo objConsultar = new CatalogoModelo();
                objConsultar.Id = id;
                string Json = JsonConvert.SerializeObject(objConsultar);
                objConsultar = objCatalogo.Consultar("2", Json);                
                return objConsultar;
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - Consultar");
				throw;
			}
		}

        public void Insertar(CatalogoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objCatalogo.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(CatalogoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objCatalogo.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(string id)
		{
			try
			{
				CatalogoModelo objBorrar = new CatalogoModelo();
				objBorrar.Id = id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objCatalogo.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - Borrar");
				throw;
			}
		}

		public List<CatalogoDetalleModelo> ListarDetalle(string idCatalogo)
		{
			try
			{
				CatalogoDetalleModelo objConsultar = new CatalogoDetalleModelo();
				objConsultar.IdCatalogo = idCatalogo;
				string Json = JsonConvert.SerializeObject(objConsultar);
				IList<CatalogoDetalleModelo> LisCatalogo = objCatalogo.ListarDetalle("6", Json);
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - Listar");
				throw;
			}
		}

		public List<CatalogoDetalleModelo> ListarDetalleActivos(string idCatalogo)
		{
			try
			{
				CatalogoDetalleModelo objConsultar = new CatalogoDetalleModelo();
				objConsultar.IdCatalogo = idCatalogo;				
				string Json = JsonConvert.SerializeObject(objConsultar);
				IList<CatalogoDetalleModelo> LisCatalogo = objCatalogo.ListarDetalleActivos("7", Json);
				return LisCatalogo.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.CatalogoNegocio - ListarActivos");
				throw;
			}
		}

		public CatalogoDetalleModelo ConsultarDetalle(string idCatalogo, string id)
		{
			try
			{
				CatalogoDetalleModelo objConsultar = new CatalogoDetalleModelo();
				objConsultar.IdCatalogo = idCatalogo;
				objConsultar.Id = id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objCatalogo.ConsultarDetalle("8", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CatalogoNegocio - ConsultarDetalle");
				throw;
			}
		}

		public void InsertarDetalle(CatalogoDetalleModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objCatalogo.Insertar("9", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CatalogoNegocio - InsertarDetalle");
				throw;
			}
		}

		public void EditarDetalle(CatalogoDetalleModelo objEditar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objEditar);
				objCatalogo.Editar("10", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CatalogoNegocio - EditarDetalle");
				throw;
			}
		}

		public bool BorrarDetalle(string idCatalogo, string id)
		{
			try
			{
				CatalogoDetalleModelo objBorrar = new CatalogoDetalleModelo();
				objBorrar.IdCatalogo = idCatalogo;
				objBorrar.Id = id;
				string Json = JsonConvert.SerializeObject(objBorrar);
				return objCatalogo.Borrar("11", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.CiudadNegocio - Borrar");
				throw;
			}
		}
	}
}