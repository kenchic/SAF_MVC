using System;
using System.Collections.Generic;
using System.Data;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreGeneral;
using CoreGeneral.Recursos;
using CoreSEG.Datos;

namespace CoreSAF.Datos
{
    public class DocumentoTipoDatos : SesionDatos
    {
        public List<DocumentoTipoModelo> Listar(string Accion)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", "");
                IList<DocumentoTipoModelo> LisDocumentoTipo = SqlMapper.Query<DocumentoTipoModelo>(objSesion.SqlConexion, "SAF.pDocumentoTipo", param, commandType: CommandType.StoredProcedure).ToList();
                return LisDocumentoTipo.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoTipoDatos - Listar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public DocumentoTipoModelo Consultar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                IList<DocumentoTipoModelo> LisDocumentoTipo = SqlMapper.Query<DocumentoTipoModelo>(objSesion.SqlConexion, "SAF.pDocumentoTipo", param, commandType: CommandType.StoredProcedure).ToList();
                return LisDocumentoTipo[0];
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoTipoDatos - Consultar");
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
                objSesion.SqlConexion.Execute("SAF.pDocumentoTipo", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoTipoDatos - Insertar");
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
                objSesion.SqlConexion.Execute("SAF.pDocumentoTipo", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoTipoDatos - Editar");
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
                objSesion.SqlConexion.Execute("SAF.pDocumentoTipo", param, commandType: CommandType.StoredProcedure);
                bolResultado = true;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoTipoDatos - Borrar");
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