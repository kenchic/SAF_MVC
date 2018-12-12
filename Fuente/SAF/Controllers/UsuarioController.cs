using System;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSeg.Modelos;
using CoreSeg.Negocios;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace SAF.Controllers
{
	[Authorize]
	public class UsuarioController : Controller
	{

		private readonly UsuarioNegocio ObjUsuario = new UsuarioNegocio();

		public UsuarioController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjUsuario.SetConexion(IConfiguracion["BD_SQL_SEG"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UsuarioController - Contructor");
			}
		}

		public ActionResult UsuarioDashBoard()
		{
			return View();
		}

		public ActionResult UsuarioMenu()
		{
			try
			{
				var identificacion = (ClaimsIdentity)User.Identity;
				var idUsuario = identificacion.Claims.Where(c => c.Type == ClaimTypes.NameIdentifier).Select(c => c.Value).SingleOrDefault();
				System.Collections.Generic.List<UsuarioMenuModelo> lisMenus = ObjUsuario.ListarMenu(Convert.ToInt32(idUsuario));
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
								strMenu.Append(string.Concat("<li><a href=\"#\" onclick=\"cargarView('", lisMenus[j].Vista, "');\"><i class=\"", lisMenus[j].Imagen, "\"></i>", lisMenus[j].Nombre, "</a></li>"));
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