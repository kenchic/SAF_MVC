using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreCoreSAF.Modelos
{
    public class ProyectoModelo
    {
        #region Propiedades

        [Key]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
        public Int16 Id { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaidCliente", ResourceType = typeof(Idioma))]
        public Int32 idCliente { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaidCiudad", ResourceType = typeof(Idioma))]
        public Int16 idCiudad { get; set; }

        [StringLength(200, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaNombre", ResourceType = typeof(Idioma))]
        public String Nombre { get; set; }

        [StringLength(100, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaTipo", ResourceType = typeof(Idioma))]
        public String Tipo { get; set; }

        [StringLength(100, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDireccion", ResourceType = typeof(Idioma))]
        public String Direccion { get; set; }

        [StringLength(50, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaTelefono", ResourceType = typeof(Idioma))]
        public String Telefono { get; set; }

        [StringLength(500, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaObservacion", ResourceType = typeof(Idioma))]
        public String Observacion { get; set; }

        [StringLength(10, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaFecha", ResourceType = typeof(Idioma))]
        public DateTime Fecha { get; set; }

        [StringLength(50, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaFormaContacto", ResourceType = typeof(Idioma))]
        public String FormaContacto { get; set; }

        [StringLength(50, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaSistemaMedida", ResourceType = typeof(Idioma))]
        public String SistemaMedida { get; set; }

        [StringLength(15, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaIdentificacionResponsable", ResourceType = typeof(Idioma))]
        public String IdentificacionResponsable { get; set; }

        [StringLength(200, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaNombreResponsable", ResourceType = typeof(Idioma))]
        public String NombreResponsable { get; set; }

        [StringLength(50, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaTelResponsable", ResourceType = typeof(Idioma))]
        public String TelResponsable { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaActivo", ResourceType = typeof(Idioma))]
        public Boolean Activo { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaEstado", ResourceType = typeof(Idioma))]
        public Byte Estado { get; set; }

        #endregion
    }
}