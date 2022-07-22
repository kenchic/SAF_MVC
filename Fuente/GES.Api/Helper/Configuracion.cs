using Microsoft.Extensions.Configuration;

namespace GES.Helper
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

        internal static string Conexion()
        {
            var valor = configuracion["BD_SQL"];
            return string.IsNullOrEmpty(valor) ? string.Empty : valor;
        }
    }
}
