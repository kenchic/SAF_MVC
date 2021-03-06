using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreSEG.Modelos
{
    public class ParametroModelo
    {
        #region Propiedades

        [Key]
        [StringLength(10, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaCodigo", ResourceType = typeof(Idioma))]
        public String Codigo { get; set; }

        [StringLength(100, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaNombre", ResourceType = typeof(Idioma))]
        public String Nombre { get; set; }

        [StringLength(500, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDescripcion", ResourceType = typeof(Idioma))]
        public String Descripcion { get; set; }

        [StringLength(200, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaValor", ResourceType = typeof(Idioma))]
        public String Valor { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaActivo", ResourceType = typeof(Idioma))]
        public Boolean Activo { get; set; }

        #endregion
    }
}