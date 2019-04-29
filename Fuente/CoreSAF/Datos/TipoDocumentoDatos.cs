using System;
using System.Collections.Generic;
using System.Data;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSeg.Datos;

namespace CoreSAF.Datos
{
    public class TipoDocumentoDatos : SesionDatos
    {
        public List<TipoDocumentoModelo> Listar(string Accion)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", "");
                IList<TipoDocumentoModelo> LisTipoDocumento = SqlMapper.Query<TipoDocumentoModelo>(objSesion.SqlConexion, "pTipoDocumento", param, commandType: CommandType.StoredProcedure).ToList();
                return LisTipoDocumento.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoDocumentoDatos - Listar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public TipoDocumentoModelo Consultar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                IList<TipoDocumentoModelo> LisTipoDocumento = SqlMapper.Query<TipoDocumentoModelo>(objSesion.SqlConexion, "pTipoDocumento", param, commandType: CommandType.StoredProcedure).ToList();
                return LisTipoDocumento[0];
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoDocumentoDatos - Consultar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public void Insertar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                objSesion.SqlConexion.Execute("pTipoDocumento", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoDocumentoDatos - Insertar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public void Editar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                objSesion.SqlConexion.Execute("pTipoDocumento", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoDocumentoDatos - Editar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public bool Borrar(string Accion, string Json)
        {
            bool bolResultado = false;
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                objSesion.SqlConexion.Execute("pTipoDocumento", param, commandType: CommandType.StoredProcedure);
                bolResultado = true;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.TipoDocumentoDatos - Borrar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }

            return bolResultado;
        }
    }
}