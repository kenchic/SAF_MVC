using System;
using System.ComponentModel.DataAnnotations;
using CoreGeneral.Recursos;

namespace CoreCoreSAF.Modelos
{
    public class VProyectoModelo
    {
        #region Propiedades

        [Key]
        [Display(Name = "EtiquetaId", ResourceType = typeof(Idioma))]
        public Int16 Id { get; set; }

        [Display(Name = "EtiquetaidCliente", ResourceType = typeof(Idioma))]
        public Int32 idCliente { get; set; }

        [Display(Name = "EtiquetaidCiudad", ResourceType = typeof(Idioma))]
        public Int16 idCiudad { get; set; }

        [Display(Name = "EtiquetaCiudadNombre", ResourceType = typeof(Idioma))]
        public String CiudadNombre { get; set; }

        [Display(Name = "EtiquetaClienteNombre", ResourceType = typeof(Idioma))]
        public String ClienteNombre { get; set; }

        [Display(Name = "EtiquetaNombre", ResourceType = typeof(Idioma))]
        public String Nombre { get; set; }

        [Display(Name = "EtiquetaTipo", ResourceType = typeof(Idioma))]
        public String Tipo { get; set; }

        [Display(Name = "EtiquetaDireccion", ResourceType = typeof(Idioma))]
        public String Direccion { get; set; }

        [Display(Name = "EtiquetaTelefono", ResourceType = typeof(Idioma))]
        public String Telefono { get; set; }

        [Display(Name = "EtiquetaObservacion", ResourceType = typeof(Idioma))]
        public String Observacion { get; set; }

        [Display(Name = "EtiquetaFecha", ResourceType = typeof(Idioma))]
        public DateTime Fecha { get; set; }

        [Display(Name = "EtiquetaFormaContacto", ResourceType = typeof(Idioma))]
        public String FormaContacto { get; set; }

        [Display(Name = "EtiquetaSistemaMedida", ResourceType = typeof(Idioma))]
        public String SistemaMedida { get; set; }

        [Display(Name = "EtiquetaIdentificacionResponsable", ResourceType = typeof(Idioma))]
        public String IdentificacionResponsable { get; set; }

        [Display(Name = "EtiquetaNombreResponsable", ResourceType = typeof(Idioma))]
        public String NombreResponsable { get; set; }

        [Display(Name = "EtiquetaTelResponsable", ResourceType = typeof(Idioma))]
        public String TelResponsable { get; set; }

        [Display(Name = "EtiquetaActivo", ResourceType = typeof(Idioma))]
        public Boolean Activo { get; set; }

        [Display(Name = "EtiquetaEstado", ResourceType = typeof(Idioma))]
        public Byte Estado { get; set; }

        #endregion
    }
}