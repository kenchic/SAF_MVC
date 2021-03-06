using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreSAF.Modelos
{
    public class VDocumentoModelo
    {
        #region Propiedades

        [Key]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
        public Int32 Id { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDocumentoTipoNombre", ResourceType = typeof(Idioma))]
        public Int32 idDocumentoTipo { get; set; }

        [Display(Name = "EtiquetaDocumentoTipoNombre", ResourceType = typeof(Idioma))]
        public virtual String DocumentoTipoNombre { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaBodegaOrigenNombre", ResourceType = typeof(Idioma))]
        public Int32 idBodegaOrigen { get; set; }

        [Display(Name = "EtiquetaBodegaOrigenNombre", ResourceType = typeof(Idioma))]
        public virtual String BodegaOrigenNombre { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaBodegaDestinoNombre", ResourceType = typeof(Idioma))]
        public Int32 idBodegaDestino { get; set; }

        [Display(Name = "EtiquetaBodegaDestinoNombre", ResourceType = typeof(Idioma))]
        public virtual String BodegaDestinoNombre { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaNumero", ResourceType = typeof(Idioma))]
        public Int32 Numero { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [Display(Name = "EtiquetaFecha", ResourceType = typeof(Idioma))]
        public DateTime Fecha { get; set; }
                
        [Display(Name = "EtiquetaFecha", ResourceType = typeof(Idioma))]
        public string DFecha
        {
            get
            {
                string strFormato = Fecha == null ? string.Empty : Fecha.ToString("dd/MM/yyyy");
                return strFormato;
            }
        }
        [StringLength(1000, ErrorMessageResourceName = "MensajeTamanoMaximo", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDescripcion", ResourceType = typeof(Idioma))]
        public String Descripcion { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaAnulado", ResourceType = typeof(Idioma))]
        public Boolean Anulado { get; set; }

    #endregion
}
}