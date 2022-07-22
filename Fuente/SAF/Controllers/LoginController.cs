using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using CoreGeneral.Modelos.SEG;
using CoreGeneral.Recursos;
using CoreGeneral.Negocios;
using System.Security.Claims;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authentication;
using CoreGeneral.Modelos.GES;
using SAF.Helper;
using CoreGeneral.Utilidades;
using Newtonsoft.Json;

namespace SAF.Controllers
{
    public class LoginController : Controller
    {
        [HttpGet]
        public IActionResult LoginUsuario()
        {
            try
            {
                Random rdmFoto = new Random();
                ViewBag.Foto = string.Format("/images/fondos/{0}.jpg", rdmFoto.Next(1, 6));
                var resultado = ClienteApi.GetRecurso(Configuracion.UrlApiSAF(), "Sistema/Version");
                if (!string.IsNullOrEmpty(resultado))
                {
                    var sistema = JsonConvert.DeserializeObject<SistemaModelo>(resultado);
                    ViewBag.Version = sistema.Version;
                }
                return View();
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "LoginController - LoginUsuario HttpGet");
                ViewBag.Notificacion = MensajeNegocio.CrearNotificacion(Constantes.MensajeError, ex.Message);
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LoginUsuario(UsuarioModelo usuarioLogin)
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
                    AutenticacionModelo autenticar = new AutenticacionModelo
                    {
                        Usuario = usuarioLogin.Usuario,
                        Clave = usuarioLogin.Clave,
                        FechaInicio = DateTime.Now,
                        FechaFin = DateTime.MinValue
                    };

                    var resultado = ClienteApi.PostRecurso(Configuracion.UrlApiSEG(), "Autenticacion/Autenticar", autenticar);
                    if (!string.IsNullOrEmpty(resultado))
                    {
                        var token = JsonConvert.DeserializeObject<string>(resultado);
                        resultado = ClienteApi.GetRecurso(Configuracion.UrlApiSAF(), "Login/Ingresar", token);
                        var usuario = JsonConvert.DeserializeObject<UsuarioModelo>(resultado);
                        
                        SesionModelo session = new SesionModelo
                        {
                            Usuario = usuario,
                            Token = token
                        };
                        Sesion.SetObjectAsJson(HttpContext.Session, "SesionUsuario", session);

                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Name, usuarioLogin.Usuario),
                            new Claim(ClaimTypes.NameIdentifier, token)
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
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "LoginController - LoginUsuario");
                return View();
            }
        }
    }
}