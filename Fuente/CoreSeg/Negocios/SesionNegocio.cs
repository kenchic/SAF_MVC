using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
using CoreSEG.Modelos;
using CoreSEG.Datos;
using System;
using CoreGeneral.Recursos;
using CoreGeneral;
using System.Linq;

namespace CoreSEG.Negocios
{
	public class SesionNegocio
    {
        private readonly SesionDatos objSesion = new SesionDatos();

        public void AsignarSesion(SesionModelo objSesionIn)
        {
            objSesion.objSesion = objSesionIn;
        }

        public void SetObjectAsJson<T>(ISession session, string key, T value)
        {
            session.SetString(key, JsonConvert.SerializeObject(value));
        }

        public T GetObjectFromJson<T>(ISession session, string key)
        {
            var value = session.GetString(key);
            return value == null ? default(T) : JsonConvert.DeserializeObject<T>(value);
        }

        public void Insertar(SesionModelo objInsertar)
        {
            try
            {
                byte[] time = BitConverter.GetBytes(DateTime.UtcNow.ToBinary());
                byte[] key = Guid.NewGuid().ToByteArray();
                objInsertar.Token = Convert.ToBase64String(time.Concat(key).ToArray());
                objInsertar.FechaInicio = DateTime.Now;

                string Json = JsonConvert.SerializeObject(objInsertar);
                objSesion.InsertarS("3", Json);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Negocios.SesionNegocio - Insertar");
                throw;
            }
        }
    }	
}
