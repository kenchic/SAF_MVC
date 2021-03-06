using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreSAF.Modelos
{
    public class ContratoModelo
    {
        #region Propiedades

        [Key]        
        [Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
        public Int16 Id { get; set; }
        
        public Int16 idProyecto { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaListaPrecioNombre", ResourceType = typeof(Idioma))]
        public Byte idListaPrecio { get; set; }

        [Display(Name = "EtiquetaAgenteNombre", ResourceType = typeof(Idioma))]
        public Int16? idAgente { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaInformacionBD", ResourceType = typeof(Idioma))]
        public Boolean InformacionBD { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaContratoAlquiler", ResourceType = typeof(Idioma))]
        public Boolean ContratoAlquiler { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaCartaPagare", ResourceType = typeof(Idioma))]
        public Boolean CartaPagare { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaPagare", ResourceType = typeof(Idioma))]
        public Boolean Pagare { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaLetraCambio", ResourceType = typeof(Idioma))]
        public Boolean LetraCambio { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaGarantiasCondiciones", ResourceType = typeof(Idioma))]
        public Boolean GarantiasCondiciones { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDeposito", ResourceType = typeof(Idioma))]
        public Boolean Deposito { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaAnticipo", ResourceType = typeof(Idioma))]
        public Boolean Anticipo { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaPersonaJuridica", ResourceType = typeof(Idioma))]
        public Boolean PersonaJuridica { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaPersonaNatural", ResourceType = typeof(Idioma))]
        public Boolean PersonaNatural { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaFotoCopiaCedula", ResourceType = typeof(Idioma))]
        public Boolean FotoCopiaCedula { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaFotoCopiaNit", ResourceType = typeof(Idioma))]
        public Boolean FotoCopiaNit { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaCamaraComercio", ResourceType = typeof(Idioma))]
        public Boolean CamaraComercio { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDescuentoAlquiler", ResourceType = typeof(Idioma))]
        public Byte DescuentoAlquiler { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDescuentoVenta", ResourceType = typeof(Idioma))]
        public Byte DescuentoVenta { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDescuentoReposicion", ResourceType = typeof(Idioma))]
        public Byte DescuentoReposicion { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDescuentoMantenimiento", ResourceType = typeof(Idioma))]
        public Byte DescuentoMantenimiento { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDescuentoTransporte", ResourceType = typeof(Idioma))]
        public Byte DescuentoTransporte { get; set; }

        [Display(Name = "EtiquetaPorcentajeAgente", ResourceType = typeof(Idioma))]
        public Byte? PorcentajeAgente { get; set; }

        #endregion
    }
}