using System;
using System.Collections.Generic;
using System.Data;
using CoreSAF.Modelos;
using Dapper;
using System.Linq;
using CoreSeg.Datos;
using CoreGeneral;
using CoreGeneral.Recursos;

namespace CoreSAF.Datos
{
    public class DocumentoDatos : SesionDatos
    {
        public List<VDocumentoModelo> Listar(string Accion)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", "");
                IList<VDocumentoModelo> LisDocumento = SqlMapper.Query<VDocumentoModelo>(objSesion.SqlConexion, "pDocumento", param, commandType: CommandType.StoredProcedure).ToList();
                return LisDocumento.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoDatos - Listar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public VDocumentoModelo Consultar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                IList<VDocumentoModelo> LisDocumento = SqlMapper.Query<VDocumentoModelo>(objSesion.SqlConexion, "pDocumento", param, commandType: CommandType.StoredProcedure).ToList();
                return LisDocumento[0];
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoDatos - Consultar");
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
                objSesion.SqlConexion.Execute("pDocumento", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoDatos - Insertar");
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
                objSesion.SqlConexion.Execute("pDocumento", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoDatos - Editar");
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
                objSesion.SqlConexion.Execute("pDocumento", param, commandType: CommandType.StoredProcedure);
                bolResultado = true;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.DocumentoDatos - Borrar");
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