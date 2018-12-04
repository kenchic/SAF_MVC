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
		public ActionResult UsuarioDashBoard()
		{
			return View();
		}

		public ActionResult UsuarioMenu()
		{
			try
			{


				//< div onclick = "mostrarVistaModal('/Agente/AgenteEditar/' + @item.Id);" class="btn-lista-vista">
				//						<i class="fa fa-edit"></i>
				//					</div>

				string strMenu = "<li>";
				strMenu += "<a href=\"#\" >";
				strMenu += "<i class=\"fa fa-files-o\"></i>";
				strMenu += crearPadre("Agente");
				strMenu += "<span class=\"label label-primary\">Agente</span>";
				strMenu += "</a>";
				strMenu += "<ul class=\"sidebar-submenu\" style=\"display: none;\">";
				strMenu += "<li><a href=\"#\" onclick=\"cargarView('/Agente/AgenteListar');\"><i class=\"fa fa-circle-o\"></i>Listar</a></li>";
				strMenu += "<li><a href=\"#\" onclick=\"cargarView('/Agente/inicio');\"><i class=\"fa fa-circle-o\"></i>Inicio 2</a></li>";
				strMenu += "<li class=\"\">";
				strMenu += "<a href=\"collapsed-sidebar.html\"><i class=\"fa fa-circle-o\"></i> Collapsed Sidebar</a>";
				strMenu += "</li>";
				strMenu += "</ul>";
				strMenu += "</li><script>$.sidebarMenu($('.sidebar-menu'));</script>";
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

		private string crearPadre(string strNombrePadre)
		{
			string strResultado = string.Empty;
			try
			{
				strNombrePadre = string.Empty;
				strResultado = strNombrePadre;
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "UsuarioController - UsuarioMenu");
				throw;
			}

			return strResultado;
		}
		
	}
}