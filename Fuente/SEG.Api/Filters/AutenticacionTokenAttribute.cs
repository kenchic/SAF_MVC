using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Configuration;
using SEG.Api.Datos;
using System;
using System.IO;
using System.Linq;

namespace SEG.Api.Filters
{
    public class AutenticacionTokenAttribute : Attribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            try
            {
                var autorizacion = false;
                if (context.HttpContext.Request.Headers.ContainsKey("autorizacion"))
                {
                    IConfigurationBuilder builder = new ConfigurationBuilder()
                                                    .SetBasePath(Directory.GetCurrentDirectory())
                                                    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

                    IConfiguration configuration = builder.Build();
                    AutenticacionDatos autenticacionDato = new AutenticacionDatos { Configuracion = configuration };
                    string token = context.HttpContext.Request.Headers.First(x => x.Key == "autorizacion").Value;
                    if (autenticacionDato.Verificar(token))
                    {
                        autorizacion = true;
                    }
                }

                if (!autorizacion)
                {
                    context.ModelState.AddModelError("SinAutorización", "Autorización no valida");
                    context.Result = new UnauthorizedObjectResult("Autorización no valida");
                }

            }
            catch
            {
                context.ModelState.AddModelError("SinAutorización", "Autorización no valida");
                context.Result = new UnauthorizedObjectResult("Autorización no valida");
            }
        }
    }
}
