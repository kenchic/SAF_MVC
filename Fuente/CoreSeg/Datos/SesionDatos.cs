using CoreGeneral.Negocios;
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
        public SesionModelo Session { get; set; }

        public void AbrirConexion(string nombreConexion = "SAF")
        {
            switch (nombreConexion)
            {
                case "SAF":
                    Session.SqlConexion = new SqlConnection(Session.ConexionSAF);
                    break;
                case "SEG":
                    Session.SqlConexion = new SqlConnection(Session.ConexionSEG);
                    break;
                case "GES":
                    Session.SqlConexion = new SqlConnection(Session.ConexionGES);
                    break;
                default:
                    break;
            }

            Session.SqlConexion.Open();
            if (Session.IdSession > 0 && !string.IsNullOrEmpty(Session.Token))
            {
                string Json = string.Format("{{\"Id\":{0},\"Token\":\"{1}\"}}", Session.IdSession, Session.Token);
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "4");
                param.Add("@Json", Json);
                Session.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
            }
        }

        public void CerrarConexion()
        {
            if (Session.IdSession > 0 && !string.IsNullOrEmpty(Session.Token))
            {
                string Json = string.Format("{{\"Id\":{0},\"Token\":\"{1}\"}}", Session.IdSession, Session.Token);
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "5");
                param.Add("@Json", Json);
                Session.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
            }

            if (Session.SqlConexion.State == ConnectionState.Open)
                Session.SqlConexion.Close();
            Session.SqlConexion.Dispose();
            Session.SqlConexion = null;
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
                Session.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
                Session.IdSession = param.Get<long>("@Id_Sesion");
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Datos.SesionDatos - Insertar");
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
                Session.SqlConexion.Execute("SEG.pSesion", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSEG.Datos.SesionDatos - Editar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }
    }
}