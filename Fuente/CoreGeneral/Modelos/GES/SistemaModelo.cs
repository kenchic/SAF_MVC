using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreGeneral.Modelos.GES
{
	public class SistemaModelo
	{
		#region Propiedades

		[Key]
		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
		public string Id { get; set; }
       
		[StringLength(20, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
		[Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
		[Display(Name = "EtiquetaVersion", ResourceType = typeof(Idioma))]
		public string Version { get; set; }

		#endregion
	}
}