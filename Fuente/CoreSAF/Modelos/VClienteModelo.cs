using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreSAF.Modelos
{
    public class VClienteModelo
    {
        #region Propiedades

        [Key]
        [Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
        public Int32 Id { get; set; }

        [Key]
        [Display(Name = "EtiquetaCiudadNombre", ResourceType = typeof(Idioma))]
        public Int32 idCiudad { get; set; }

        [Display(Name = "EtiquetaCiudadNombre", ResourceType = typeof(Idioma))]
        public String CiudadNombre { get; set; }

        [Display(Name = "EtiquetaIdentificacion", ResourceType = typeof(Idioma))]
        public String Identificacion { get; set; }

        [Display(Name = "EtiquetaNombre1", ResourceType = typeof(Idioma))]
        public String Nombre1 { get; set; }

        [Display(Name = "EtiquetaNombre2", ResourceType = typeof(Idioma))]
        public String Nombre2 { get; set; }

        [Display(Name = "EtiquetaApellido1", ResourceType = typeof(Idioma))]
        public String Apellido1 { get; set; }

        [Display(Name = "EtiquetaApellido2", ResourceType = typeof(Idioma))]
        public String Apellido2 { get; set; }
                
        [Display(Name = "EtiquetaNombre", ResourceType = typeof(Idioma))]
        public String Nombre { get; set; }

        [Display(Name = "EtiquetaDireccion", ResourceType = typeof(Idioma))]
        public String Direccion { get; set; }

        [Display(Name = "EtiquetaTelefono", ResourceType = typeof(Idioma))]
        public String Telefono { get; set; }

        [Display(Name = "EtiquetaCelular", ResourceType = typeof(Idioma))]
        public String Celular { get; set; }

        [Display(Name = "EtiquetaCorreo", ResourceType = typeof(Idioma))]
        public String Correo { get; set; }

        [Display(Name = "EtiquetaActivo", ResourceType = typeof(Idioma))]
        public Boolean Activo { get; set; }

        #endregion
    }
}