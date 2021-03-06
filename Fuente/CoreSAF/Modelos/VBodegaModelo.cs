using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreSAF.Modelos
{
    public class VBodegaModelo
    {
        #region Propiedades

        [Key]
        [Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
        public Int32 Id { get; set; }

        [Display(Name = "EtiquetaClienteNombre", ResourceType = typeof(Idioma))]
        public Int32? idCliente { get; set; }

        [Display(Name = "EtiquetaClienteNombre", ResourceType = typeof(Idioma))]
        public virtual String ClienteNombre { get; set; }

        [Display(Name = "EtiquetaProveedorNombre", ResourceType = typeof(Idioma))]
        public Int16? idProveedor { get; set; }

        [Display(Name = "EtiquetaProveedorNombre", ResourceType = typeof(Idioma))]
        public virtual String ProveedorNombre { get; set; }

        [Display(Name = "EtiquetaNombre", ResourceType = typeof(Idioma))]
        public String Nombre { get; set; }

        [Display(Name = "EtiquetaEsSistema", ResourceType = typeof(Idioma))]
        public Boolean EsSistema { get; set; }

        [Display(Name = "EtiquetaActivo", ResourceType = typeof(Idioma))]
        public Boolean Activo { get; set; }

        #endregion
    }
}