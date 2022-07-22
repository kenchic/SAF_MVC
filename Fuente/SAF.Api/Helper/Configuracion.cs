using Microsoft.Extensions.Configuration;

namespace SAF.Api.Helper
{   
    internal static class Configuracion
    {
        private static readonly IConfigurationRoot configuracion = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", true, true)
            .Build();

        internal static string ValorPropiedad(string propiedad)
        {
            var valor = configuracion[propiedad];
            return string.IsNullOrEmpty(valor) ? string.Empty : valor;
        }

        internal static string UrlApiGES()
        {
            var valor = configuracion["UrlApiGES"];
            return string.IsNullOrEmpty(valor) ? string.Empty : valor;
        }

        internal static string UrlApiSEG()
        {
            var valor = configuracion["UrlApiSEG"];
            return string.IsNullOrEmpty(valor) ? string.Empty : valor;
        }
    }
}
