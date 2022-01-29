using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using CoreGeneral.Negocios;

namespace SAF
{
    public static class Program
    {
        public static void Main(string[] args)
        {
			MensajeNegocio.EscribirLog(CoreGeneral.Recursos.Constantes.MensajeInfo, "Inicio", "");
			BuildWebHost(args).Run();
		}

        public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
				.Build();
    }
}
