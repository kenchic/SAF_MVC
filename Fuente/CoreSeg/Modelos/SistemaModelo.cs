using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreSeg.Modelos
{
	public class SistemaModelo
	{
		#region Propiedades

		[Key]
		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
		public Int16 Id { get; set; }
        
		[StringLength(50, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaNombre", ResourceType = typeof(Idioma))]
		public String Nombre { get; set; }

		[StringLength(20, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaVersion", ResourceType = typeof(Idioma))]
		public String Version { get; set; }

		#endregion
	}
}