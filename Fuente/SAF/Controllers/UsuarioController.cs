using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral.Modelos.SEG;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using CoreGeneral.Utilidades;
using SAF.Helper;
using Newtonsoft.Json;

namespace SAF.Controllers
{
	[Authorize]
	public class UsuarioController : Controller
	{
        public ActionResult DashBoard()
		{
			return View();
		}

		public ActionResult Menu()
		{
			try
			{
                SesionModelo sesion = Sesion.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario");
                var parametros = new Dictionary<string, string>();
                parametros.Add("Usuario", sesion.Usuario.Id);
                string resultado = ClienteApi.GetRecurso(Configuracion.UrlApiSAF(), "Usuario/Menu", parametros, sesion.Token);
                if (!string.IsNullOrEmpty(resultado))
                {
                    var menus = JsonConvert.DeserializeObject<List<UsuarioMenuModelo>>(resultado);
                    var strMenu = new StringBuilder("<li>");
                    for (int i = 0; i < menus.Count; i++)
                    {
                        if (menus[i].SubOrden == null)
                        {
                            strMenu.Append("<button class=\"dropdown-btn\">");
                            strMenu.Append(string.Concat("<i class=\"", menus[i].Imagen, "\"></i>&nbsp;&nbsp;", menus[i].Nombre));
                            strMenu.Append("</button>");

                            strMenu.Append("<div class=\"dropdown-container\">");
                            for (int j = i; j < menus.Count; j++)
                            {
                                if (menus[i].Orden == menus[j].Orden && menus[i].Id != menus[j].Id)
                                {
                                    strMenu.Append(string.Concat("<a href=\"#\" onclick=\"cargarVista('", menus[j].Vista, "');\"><i class=\"", menus[j].Imagen, "\"></i>&nbsp;&nbsp;", menus[j].Nombre, "</a>"));
                                }
                            }
                            strMenu.Append("</div>");
                        }
                    }
                    strMenu.Append("</li>");
                    ViewBag.Arbol = strMenu;
                }
                return View();
			}
			catch (Exception ex)
			{
				MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "UsuarioController - UsuarioMenu");
				return View();
			}
		}

		[HttpGet]
		public async Task<IActionResult> Logout()
		{
			await HttpContext.SignOutAsync();
			return RedirectToAction("LoginUsuario", "Login");
		}
	}
}