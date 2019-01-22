using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;

namespace CoreSAF.Datos
{
    public class TipoDocumentoDatos
    {
        private SqlConnection SqlConexion;
        public string Conexion { get; set; }

        private void Conectar()
        {
            SqlConexion = new SqlConnection(Conexion);
        }

        public List<TipoDocumentoModelo> Listar(string Accion)
        {
            try
            {
                Conectar();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", "");
                SqlConexion.Open();
                IList<TipoDocumentoModelo> LisTipoDocumento = SqlMapper.Query<TipoDocumentoModelo>(SqlConexion, "pTipoDocumento", param, commandType: CommandType.StoredProcedure).ToList();
                return LisTipoDocumento.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoDocumentoRepository - Listar");
                throw;
            }
            finally
            {
                SqlConexion.Close();
            }
        }

        public TipoDocumentoModelo Consultar(string Accion, string Json)
        {
            try
            {
                Conectar();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                SqlConexion.Open();
                IList<TipoDocumentoModelo> LisTipoDocumento = SqlMapper.Query<TipoDocumentoModelo>(SqlConexion, "pTipoDocumento", param, commandType: CommandType.StoredProcedure).ToList();
                return LisTipoDocumento[0];
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoDocumentoRepository - Consultar");
                throw;
            }
            finally
            {
                SqlConexion.Close();
            }
        }

        public void Insertar(string Accion, string Json)
        {
            try
            {
                Conectar();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                SqlConexion.Open();
                SqlConexion.Execute("pTipoDocumento", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoDocumentoRepository - Operacion");
                throw;
            }
            finally
            {
                SqlConexion.Close();
            }
        }

        public void Editar(string Accion, string Json)
        {
            try
            {
                Conectar();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                SqlConexion.Open();
                SqlConexion.Execute("pTipoDocumento", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoDocumentoRepository - Operacion");
                throw;
            }
            finally
            {
                SqlConexion.Close();
            }
        }

        public bool Borrar(string Accion, string Json)
        {
            bool bolResultado = false;
            try
            {
                Conectar();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                SqlConexion.Open();
                SqlConexion.Execute("pTipoDocumento", param, commandType: CommandType.StoredProcedure);
                bolResultado = true;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Repository.TipoDocumentoRepository - Operacion");
                throw;
            }
            finally
            {
                SqlConexion.Close();
            }

            return bolResultado;
        }
    }
}