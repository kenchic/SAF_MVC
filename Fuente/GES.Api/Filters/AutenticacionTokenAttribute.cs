using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Configuration;
using RestSharp;
using System;
using System.Linq;

namespace GES.Api.Filters
{
    public class AutenticacionTokenAttribute : Attribute, IAuthorizationFilter
    {
        private static readonly IConfigurationRoot configuracion = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", true, true)
            .Build();

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var autorizacion = false;
            if(context.HttpContext.Request.Headers.ContainsKey("Autorizacion"))
            {
                string token = context.HttpContext.Request.Headers.First(x => x.Key == "autorizacion").Value;
                RestClient cliente = new RestClient($"{configuracion["appSettings:UrlApiSEG"]}");
                var request = new RestRequest("VerificarToken");
                request.AddParameter("token", token);
                var response = cliente.PostAsync(request).GetAwaiter().GetResult();
                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    autorizacion = true;
                }
            }

            if(!autorizacion)
            {
                context.ModelState.AddModelError("SinAutorización", "Autorización no valida");
                context.Result = new UnauthorizedObjectResult("Autorización no valida");
            }
        }
    }
}