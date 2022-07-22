using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Modelos.SEG;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Newtonsoft.Json;
using CoreGeneral.Utilidades;

namespace SEG.Api.Datos
{
    public class AutenticacionDatos : BaseDatos
    {
        public AutenticacionDatos()
        {
            Procedimiento = "SEG.pAutenticacion";
        }

        public bool Autenticar(AutenticacionModelo credencial, out UsuarioModelo usuario)
        {
            try
            {
                usuario = new UsuarioModelo
                {
                    Usuario = credencial.Usuario,
                    Clave = credencial.Clave
                };

                var usuarioLogin = new UsuarioDatos();
                usuarioLogin.Configuracion = Configuracion;
                return usuarioLogin.Autenticar(ref usuario);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AutenticacionDatos - Autenticar");
                usuario = null;
                return false;
            }
        }

        public string CrearToken(UsuarioModelo usuario)
        {
            try
            {
                DateTime fechaInicio = DateTime.Now;
                string token = string.Concat(fechaInicio.ToString("ddMMyyyyHHmmss"), usuario.Usuario, usuario.Clave);
                var autenticacion = new AutenticacionModelo
                {
                    Usuario = usuario.Id,
                    FechaInicio = fechaInicio,
                    Token = token
                };
                Insertar(autenticacion);
                token = Codificacion.CodificarBase64String(JsonConvert.SerializeObject(autenticacion));
                return token;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AutenticacionDatos - CrearToken");
                throw;
            }
        }

		public bool Verificar(string token)
		{
			try
			{
                AbrirConexion();
                string json = Codificacion.DecoficarBase64String(token);
                DynamicParameters param = new DynamicParameters();
				param.Add("@Accion", "Verificar");
				param.Add("@Json", json);
				List<AutenticacionModelo> lisAutenticacion = SqlMapper.Query<AutenticacionModelo>(Conexion, "SEG.pAutenticacion", param, commandType: CommandType.StoredProcedure).ToList();
				return lisAutenticacion.Count > 0;
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "AutenticacionDatos- Verificar");
				throw;
			}
			finally
			{
				CerrarConexion();
			}
		}
	}
}
