﻿using System.Collections.Generic;
using System.Reflection;
using System;
using CoreGeneral.Recursos;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CoreGeneral
{
	public static class Utilidades
	{
		public static SelectList ListaSeleccion<T>(List<T> ienLista, string strValorCampo, string strTextoCampo, string strValorEntidad)
		{
			try
			{
				List<SelectListItem> list = new List<SelectListItem>();
				foreach (var item in ienLista)
				{
					string strValor = string.Empty;
					string strTexto = string.Empty;
					foreach (PropertyInfo piInfo in typeof(T).GetProperties())
					{
						if (piInfo.Name == strTextoCampo)
							strTexto = piInfo.GetValue(item, null).ToString();

						if (piInfo.Name == strValorCampo)
							strValor = piInfo.GetValue(item, null).ToString();
					}

					list.Add(new SelectListItem()
					{
						Text = strTexto,
						Value = strValor,
						Selected = strValorEntidad == strValor
					});
				}
				return new SelectList(list, "Value", "Text");
			}
			catch (Exception ex)
			{
				Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, " CoreGeneral.Utilidades.ListaSeleccion ");
				throw;
			}
		}
	}
}