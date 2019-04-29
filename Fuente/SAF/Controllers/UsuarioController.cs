using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSeg.Modelos;
using CoreSeg.Negocios;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace SAF.Controllers
{
	[Authorize]
	public class UsuarioController : Controller
	{

		private readonly UsuarioNegocio objUsuario = new UsuarioNegocio();

		public ActionResult UsuarioDashBoard()
		{
			return View();
		}

		public ActionResult UsuarioMenu()
		{
			try
			{
                SesionNegocio objSesionNegocio = new SesionNegocio();
                SesionModelo objSesion = objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario");
                objUsuario.AsignarSesion(objSesion);

                List<UsuarioMenuModelo> lisMenus = objUsuario.ListarMenu(Convert.ToInt32(objSesion.Usuario.Id));
				StringBuilder strMenu = new StringBuilder("<li>");
				for (int i = 0; i < lisMenus.Count; i++)
				{
					if (lisMenus[i].SubOrden == null)
					{
						strMenu.Append("<a href=\"#\" >");
						strMenu.Append(string.Concat("<i class=\"", lisMenus[i].Imagen, "\"></i>"));
						strMenu.Append(string.Concat("<span class=\"label label-primary\">", lisMenus[i].Nombre, "</span>"));
						strMenu.Append("</a>");
						strMenu.Append("<ul class=\"sidebar-submenu\" style=\"display: none;\">");

						for (int j = i; j < lisMenus.Count; j++)
						{
							if (lisMenus[i].Orden == lisMenus[j].Orden && lisMenus[i].Id != lisMenus[j].Id)
							{
								strMenu.Append(string.Concat("<li><a href=\"#\" onclick=\"cargarVista('", lisMenus[j].Vista, "');\"><i class=\"", lisMenus[j].Imagen, "\"></i>", lisMenus[j].Nombre, "</a></li>"));
							}
						}
						strMenu.Append("</ul>");
					}
				}
				strMenu.Append("</li><script>$.sidebarMenu($('.sidebar-menu'));</script>");
				ViewBag.Arbol = strMenu;
				return View();
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UsuarioController - UsuarioMenu");
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