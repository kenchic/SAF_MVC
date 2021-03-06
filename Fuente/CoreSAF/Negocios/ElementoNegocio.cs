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
	public class ElementoNegocio
    {
		private readonly ElementoDatos objElemento = new ElementoDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objElemento.objSesion = objSesion;
        }

        public List<VElementoModelo> Listar()
		{
			try
			{
				IList<VElementoModelo> LisElemento = objElemento.Listar("0");
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
				IList<VElementoModelo> lisElementos = objElemento.Listar("1");
				return lisElementos.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - ListarActivos");
				throw;
			}
		}

        public string ListarActivosAutoComplete()
        {
            try
            {
                IList<VElementoModelo> lisElementos = objElemento.Listar("1");

                string strElementos = string.Empty;
                for (int i = 0; i < lisElementos.Count; i++)
                {
                    strElementos = string.Format("{0},{{value:\"{1}\",label:\"{2}\"}}", strElementos, lisElementos[i].Id, lisElementos[i].Nombre);
                }
                strElementos = "[" + strElementos.Substring(1) + "]";

                return strElementos;
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
				return objElemento.Consultar("2", Json);
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
				objElemento.Insertar("3", Json);
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
				objElemento.Editar("4", Json);
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
				return objElemento.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "SAF.Negocios.ElementoNegocio - Borrar");
				throw;
			}
		}
	}
}