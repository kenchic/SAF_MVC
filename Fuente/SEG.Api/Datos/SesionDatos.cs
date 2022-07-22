using CoreGeneral.Modelos.SEG;

namespace SEG.Api.Datos
{
    public class SesionDatos : BaseDatos
    {
        public SesionModelo Session { get; set; }

        public SesionDatos()
        {
            Procedimiento = "SEG.pSesion";
        }
    }
}