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
	public class GrupoElementoNegocio
    {
		private readonly GrupoElementoDatos objGrupoElemento = new GrupoElementoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objGrupoElemento.objSesion = objSesion;
        }

        public List<GrupoElementoModelo> Listar()
		{
			try
			{
				IList<GrupoElementoModelo> LisGrupoElemento = objGrupoElemento.Listar("0");
				return LisGrupoElemento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.GrupoElementoNegocio - Listar");
				throw;
			}
		}

		public List<GrupoElementoModelo> ListarActivos()
		{
			try
			{
				IList<GrupoElementoModelo> LisGrupoElemento = objGrupoElemento.Listar("1");
				return LisGrupoElemento.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.GrupoElementoNegocio - ListarActivos");
				throw;
			}
		}

		public GrupoElementoModelo Consultar(int id)
		{
			try
			{
				GrupoElementoModelo objConsultar = new GrupoElementoModelo();
				objConsultar.Id = (byte)id;
				string Json = JsonConvert.SerializeObject(objConsultar);
				return objGrupoElemento.Consultar("2", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.GrupoElementoNegocio - Consultar");
				throw;
			}
		}

		public void Insertar(GrupoElementoModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
                objGrupoElemento.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.GrupoElementoNegocio - Insertar");
				throw;
			}
		}

		public void Editar(GrupoElementoModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);
                objGrupoElemento.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.GrupoElementoNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(int id)
		{
			try
			{
				GrupoElementoModelo objBorrar = new GrupoElementoModelo();
				objBorrar.Id = (byte)id;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objGrupoElemento.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.GrupoElementoNegocio - Borrar");
				throw;
			}
		}
	}
}