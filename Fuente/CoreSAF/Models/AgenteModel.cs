///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
//////  AgenteModel
//////  SAF - Integral Solutions SAS
//////  Implementacion Modelo:	Agente
//////  Creacion:      			19/07/2018
//////  Autor: 					German Alvarez
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

using CoreGeneral.Recursos;
using System;
using System.ComponentModel.DataAnnotations;

namespace CoreSAF.Models
{
	public class AgenteModel
	{
		
		#region Propiedades

		[Key]
		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
		public Int16 Id { get; set; }

		[StringLength(100, ErrorMessageResourceName = "StringLengthMensaje", ErrorMessageResourceType = typeof(Idioma))]
		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaNombre", ResourceType = typeof(Idioma))]
		public String Nombre { get; set; }

		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaActivo", ResourceType = typeof(Idioma))]
		public Boolean Activo { get; set; }
				
		#endregion
	}
}