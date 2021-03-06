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
	public class ParametroNegocio
    {
		private readonly ParametroDatos objParametro = new ParametroDatos();

        public void AsignarSesion(SesionModelo objSesion)
        {
            objParametro.objSesion = objSesion;
        }

        public List<ParametroModelo> Listar()
		{
			try
			{
				IList<ParametroModelo> LisParametro = objParametro.Listar("0");
				return LisParametro.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Listar");
				throw;
			}
		}

		public List<ParametroModelo> ListarActivos()
		{
			try
			{
				IList<ParametroModelo> LisParametro = objParametro.Listar("1");
				return LisParametro.ToList();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - ListarActivos");
				throw;
			}
		}

		public ParametroModelo Consultar(string codigo, string strValorDefecto)
		{
			try
			{
                ParametroModelo objConsultar = new ParametroModelo();
                objConsultar.Codigo = codigo;
                string Json = JsonConvert.SerializeObject(objConsultar);
                objConsultar = objParametro.Consultar("2", Json);
                if (objConsultar == null)
                {
                    objConsultar = new ParametroModelo();
                    objConsultar.Valor = strValorDefecto;
                }
                return objConsultar;
            }
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Consultar");
				throw;
			}
		}

        public void Insertar(ParametroModelo objInsertar)
		{
			try
			{
				string Json = JsonConvert.SerializeObject(objInsertar);
				objParametro.Insertar("3", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Insertar");
				throw;
			}
		}

		public void Editar(ParametroModelo objEditar)
		{
			try
			{				
				string Json = JsonConvert.SerializeObject(objEditar);				
				objParametro.Editar("4", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Editar");
				throw;
			}
		}

		public bool Borrar(string codigo)
		{
			try
			{
				ParametroModelo objBorrar = new ParametroModelo();
				objBorrar.Codigo = codigo;
				string Json = JsonConvert.SerializeObject(objBorrar);				
				return objParametro.Borrar("5", Json);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "Core.Negocios.ParametroNegocio - Borrar");
				throw;
			}
		}
	}
}