using System;
using System.Threading.Tasks;
using CoreGeneral;
using CoreGeneral.Recursos;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace SAF.Controllers
{
	[Authorize]
	public class UsuarioController : Controller
	{
		public ActionResult DashBoard()
		{
			return View();
		}

		public ActionResult UsuarioMenu()
		{
			try
			{				
				string strMenu = "<li>";
				strMenu += "<a href=\"#\" >";
				strMenu += "<i class=\"fa fa-files-o\"></i>";
				strMenu += "<span>Agente</span>";
				strMenu += "<span class=\"label label-primary pull-right\">4</span>";
				strMenu += "</a>";
				strMenu += "<ul class=\"sidebar-submenu\" style=\"display: none;\">";
				strMenu += "<li><a href=\"#\" onclick=\"cargarView('/Agente/Listar');\"><i class=\"fa fa-circle-o\"></i>Listar</a></li>";
				strMenu += "<li><a href=\"#\" onclick=\"cargarView('/Agente/inicio');\"><i class=\"fa fa-circle-o\"></i>Inicio 2</a></li>";
				strMenu += "<li class=\"\">";
				strMenu += "<a href=\"collapsed-sidebar.html\"><i class=\"fa fa-circle-o\"></i> Collapsed Sidebar</a>";
				strMenu += "</li>";
				strMenu += "</ul>";
				strMenu += "</li><script>$.sidebarMenu($('.sidebar-menu'));</script>";
				ViewBag.Tree = strMenu;
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
			return RedirectToAction("UserLogin", "Login");
		}

		
	}
}