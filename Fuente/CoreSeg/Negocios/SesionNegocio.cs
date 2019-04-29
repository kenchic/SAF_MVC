using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
namespace CoreSeg.Negocios
{
	public class SesionNegocio
    {
        public void SetObjectAsJson<T>(ISession session, string key, T value)
        {
            session.SetString(key, JsonConvert.SerializeObject(value));
        }

        public T GetObjectFromJson<T>(ISession session, string key)
        {
            var value = session.GetString(key);
            return value == null ? default(T) : JsonConvert.DeserializeObject<T>(value);
        }
    }	
}
