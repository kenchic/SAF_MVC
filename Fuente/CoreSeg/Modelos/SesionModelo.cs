using System;
using System.Data.SqlClient;

namespace CoreSEG.Modelos
{
	public class SesionModelo
	{
        #region Propiedades

        public long IdSession { get; set; }

        public SqlConnection SqlConexion { get; set; }

        public UsuarioModelo Usuario { get; set; }

        public string Conexion { get; set; }

        public string ConexionSAF { get; set; }

        public string ConexionSEG { get; set; }

        public string ConexionGES { get; set; }

        public string Token { get; set; }

        public DateTime FechaInicio { get; set; }

        public DateTime FechaFin { get; set; }

        #endregion
    }
}