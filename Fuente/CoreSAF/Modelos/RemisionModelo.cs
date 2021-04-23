using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreSAF.Modelos
{
    public class RemisionModelo
    {
        #region Propiedades

        [Key]
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
        public Int32 Id { get; set; }

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
        [Display(Name = "EtiquetaProyecto", ResourceType = typeof(Idioma))]
        public Int32 idProyecto { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaProyecto", ResourceType = typeof(Idioma))]
        public virtual String ProyectoNombre { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaDocumentoTipoNombre", ResourceType = typeof(Idioma))]
        public Int32 idDocumentoTipo { get; set; }

        [Display(Name = "EtiquetaDocumentoTipoNombre", ResourceType = typeof(Idioma))]
        public virtual String DocumentoTipoNombre { get; set; }

        [Display(Name = "EtiquetaConductor", ResourceType = typeof(Idioma))]
        public Int32 idCondutcor { get; set; }

        [Display(Name = "EtiquetaConductorNombre", ResourceType = typeof(Idioma))]
        public virtual String ConductorNombre { get; set; }

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

        [Display(Name = "EtiquetaFechaSistema", ResourceType = typeof(Idioma))]
        public DateTime FechaSistema { get; set; }

        [Display(Name = "EtiquetaTransporte", ResourceType = typeof(Idioma))]
        public Boolean Transporte { get; set; }

        [Display(Name = "EtiquetaValorTransporte", ResourceType = typeof(Idioma))]
        public Int32 ValorTransporte { get; set; }

        [Display(Name = "EtiquetaDespachado", ResourceType = typeof(Idioma))]
        public Boolean Despachado { get; set; }

        [Display(Name = "EtiquetaEquipoAdecuado", ResourceType = typeof(Idioma))]
        public Boolean EquipoAdecuado { get; set; }

        [Display(Name = "EtiquetaPesoEquipo", ResourceType = typeof(Idioma))]
        public Decimal PesoEquipo { get; set; }

        [Display(Name = "EtiquetaValorEquipo", ResourceType = typeof(Idioma))]
        public Int64 ValorEquipo { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "MensajeRequerido", ErrorMessageResourceType = typeof(Idioma))]
        [Display(Name = "EtiquetaEstado", ResourceType = typeof(Idioma))]
        public Boolean Estado { get; set; }

    #endregion
}
}