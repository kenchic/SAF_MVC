///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//////  LoginController
//////  SAF - Integral Solutions SAS
//////  Implementacion Controlador:	Login
//////  Creacion:      				23/07/2018
//////  Autor: 						German Alvarez
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using CoreSeg.Models;
using CoreSeg.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using System.Security.Claims;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authentication;

namespace SAF.Controllers
{
	public class LoginController : Controller
	{
		private readonly UsuarioNegocio ObjUsuario = new UsuarioNegocio();

		public LoginController(IConfiguration IConfiguracion)
		{
			try
			{
				ObjUsuario.SetConexion(IConfiguracion["BD_SQL_SEG"]);
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Contructor");
			}
		}

		[HttpGet]
		public IActionResult RegisterUser()
		{

			return View();
		}

		[HttpPost]
		public IActionResult RegisterUser([Bind] UsuarioModel usuario)
		{
			if (ModelState.IsValid)
			{
				string RegistrationStatus = "";
				if (RegistrationStatus == "Success")
				{
					ModelState.Clear();
					TempData["Success"] = "Registration Successful!";
					return View();
				}
				else
				{
					TempData["Fail"] = "This User ID already exists. Registration Failed.";
					return View();
				}
			}
			return View();
		}

		[HttpGet]
		public IActionResult UserLogin()
		{
			return View();
		}


		[HttpGet]
		public IActionResult UsuarioLogin()
		{
			Random rdmFoto = new Random();
			ViewBag.Foto = string.Format("/images/fondos/{0}.jpg", rdmFoto.Next(1, 6));
			return View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult UsuarioLogin(UsuarioModel objUsuario)
		{
			try
			{
				ModelState.Remove("Id");
				ModelState.Remove("Identificacion");
				ModelState.Remove("Nombre");
				ModelState.Remove("Apellido");
				ModelState.Remove("Correo");
				ModelState.Remove("Activo");
				ModelState.Remove("Admin");
				if (ModelState.IsValid)
				{
					if (ObjUsuario.Autenticar(objUsuario))
					{
						var claims = new List<Claim>
						{
							new Claim(ClaimTypes.Name, objUsuario.Usuario)
						};
						ClaimsIdentity userIdentity = new ClaimsIdentity(claims, "login");
						ClaimsPrincipal principal = new ClaimsPrincipal(userIdentity);

						HttpContext.SignInAsync(principal);
						return RedirectToAction("DashBoard", "Usuario");
					}
					else
					{
						TempData["UserLoginFailed"] = "Login Failed.Please enter correct credentials";
						return View();
					}
				}
				else
				{
					Random rdmFoto = new Random();
					ViewBag.Foto = string.Format("/images/fondos/{0}.jpg", rdmFoto.Next(1, 6));
					return View();
				}
					
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "AgenteController - Insertar");
				return View();
			}
		}
	}
}