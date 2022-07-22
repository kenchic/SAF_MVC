using Microsoft.Extensions.Configuration;

namespace SAF.Helper
{   
    internal static class Configuracion
    {
        private static readonly IConfigurationRoot configuracion = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", true, true)
            .Build();

        internal static string UrlApiGES()
        {
            var valor = configuracion["UrlApiGES"];
            return string.IsNullOrEmpty(valor) ? string.Empty : valor;
        }

        internal static string UrlApiSAF()
        {
            var valor = configuracion["UrlApiSAF"];
            return string.IsNullOrEmpty(valor) ? string.Empty : valor;
        }

        internal static string UrlApiSEG()
        {
            var valor = configuracion["UrlApiSEG"];
            return string.IsNullOrEmpty(valor) ? string.Empty : valor;
        }
    }
}
