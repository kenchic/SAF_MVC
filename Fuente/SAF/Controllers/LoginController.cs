using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using CoreSEG.Modelos;
using CoreSEG.Negocios;
using CoreGeneral.Recursos;
using CoreGeneral;
using System.Security.Claims;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authentication;

namespace SAF.Controllers
{
    public class LoginController : Controller
    {
        private readonly UsuarioNegocio objUsuario = new UsuarioNegocio();
        private readonly SesionNegocio objSesionNegocio = new SesionNegocio();
        private SesionModelo objSesion = new SesionModelo();

        public LoginController(IConfiguration IConfiguracion)
        {
            try
            {                
                objSesion.ConexionSAF = IConfiguracion["BD_SQL_SAF"];
                objSesion.ConexionSEG = IConfiguracion["BD_SQL_SEG"];
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "LoginController - Contructor");
            }
        }

        [HttpGet]
        public IActionResult LoginUsuario()
        {
            Random rdmFoto = new Random();
            ViewBag.Foto = string.Format("/images/fondos/{0}.jpg", rdmFoto.Next(1, 6));
            objSesionNegocio.SetObjectAsJson(HttpContext.Session, "SesionUsuario", objSesion);

            objSesion = objSesionNegocio.GetObjectFromJson<SesionModelo>(HttpContext.Session, "SesionUsuario");
            SistemaNegocio objSistemaNegocio = new SistemaNegocio(objSesion);
            SistemaModelo objSistema = objSistemaNegocio.Consultar("SAF");
            ViewBag.Version = string.Concat("Version ", objSistema == null ? string.Empty : objSistema.Version);
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LoginUsuario(UsuarioModelo objUsuarioLogin)
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
                    
                    objUsuario.AsignarSesion(objSesion);

                    if (objUsuario.Autenticar(ref objUsuarioLogin))
                    {
                        objSesion.Usuario = objUsuarioLogin;                        
                        objSesionNegocio.AsignarSesion(objSesion);
                        objSesionNegocio.Insertar(objSesion);

                        objSesionNegocio.SetObjectAsJson(HttpContext.Session, "SesionUsuario", objSesion);

                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Name, objUsuarioLogin.Usuario),
                            new Claim(ClaimTypes.NameIdentifier, objUsuarioLogin.Id.ToString())
                        };

                        ClaimsIdentity userIdentity = new ClaimsIdentity(claims, "login");
                        ClaimsPrincipal principal = new ClaimsPrincipal(userIdentity);

                        HttpContext.SignInAsync(principal);

                        return RedirectToAction("UsuarioDashBoard", "Usuario");
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
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "LoginController - LoginUsuario");
                return View();
            }
        }        
    }
}