using System.Data.SqlClient;

namespace CoreSeg.Modelos
{
	public class SesionModelo
	{
        #region Propiedades

        public SqlConnection SqlConexion { get; set; }
        public UsuarioModelo Usuario { get; set; }
        public string ConexionSAF { get; set; }
        public string ConexionSEG { get; set; }

		#endregion
	}
}