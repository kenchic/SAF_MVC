using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;

namespace SAF
{
    public class Program
    {
        public static void Main(string[] args)
        {
			CoreGeneral.Mensajes.EscribirLog(CoreGeneral.Recursos.Constantes.MensajeInfo, "Inicio", "");
			BuildWebHost(args).Run();
		}

        public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
				.Build();
    }
}
