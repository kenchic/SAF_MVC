using System.ComponentModel.DataAnnotations;

namespace SEG.Api.Modelos
{
    public class Credencial
    {
        [Required]
        public string Usuario { get; set; }

        [Required]
        public string Clave { get; set; }
    }
}
