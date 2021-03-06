using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSEG.Modelos;
using Dapper;
using System;
using System.Data;
using System.Data.SqlClient;

namespace CoreSEG.Datos
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

            if (objSesion.idSesion > 0 && !string.IsNullOrEmpty(objSesion.Token))
            {
                string Json = string.Format("{{\"Id\":{0},\"Token\":\"{1}\"}}", objSesion.idSesion, objSesion.Token);
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "4");
                param.Add("@Json", Json);
                objSesion.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
            }
        }

        public void CerrarConexion()
        {
            if (objSesion.idSesion > 0 && !string.IsNullOrEmpty(objSesion.Token))
            {
                string Json = string.Format("{{\"Id\":{0},\"Token\":\"{1}\"}}", objSesion.idSesion, objSesion.Token);
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "5");
                param.Add("@Json", Json);
                objSesion.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
            }

            if (objSesion.SqlConexion.State == ConnectionState.Open)
                objSesion.SqlConexion.Close();
            objSesion.SqlConexion.Dispose();
            objSesion.SqlConexion = null;
        }

        public void InsertarS(string Accion, string Json)
        {
            try
            {
                AbrirConexion("SEG");
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                param.Add("@Id_Sesion", null, DbType.Int64, ParameterDirection.Output);
                objSesion.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
                objSesion.idSesion = param.Get<long>("@Id_Sesion");
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Datos.SesionDatos - Insertar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public void EditarS(string Accion, string Json)
        {
            try
            {
                AbrirConexion("SEG");
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                objSesion.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Datos.SesionDatos - Editar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }
    }
}