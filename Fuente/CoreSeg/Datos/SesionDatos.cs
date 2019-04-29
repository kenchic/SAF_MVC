using CoreSeg.Modelos;
using System.Data;
using System.Data.SqlClient;

namespace CoreSeg.Datos
{
    public class SesionDatos
    {
        public SesionModelo objSesion { get; set; }

        public void AbrirConexion(string strNombreConexion = "SAF")
        {
            if (strNombreConexion.Equals("SAF"))
                objSesion.SqlConexion = new SqlConnection(objSesion.ConexionSAF);
            else
                objSesion.SqlConexion = new SqlConnection(objSesion.ConexionSEG);
            objSesion.SqlConexion.Open();
        }

        public void CerrarConexion()
        {
            if (objSesion.SqlConexion.State == ConnectionState.Open)
                objSesion.SqlConexion.Close();
            objSesion.SqlConexion.Dispose();
            objSesion.SqlConexion = null;
        }
    }
}