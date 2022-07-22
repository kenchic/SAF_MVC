using System;
using System.Collections.Generic;
using System.Data;
using CoreGeneral.Modelos.SAF;
using Dapper;
using System.Linq;
using CoreSEG.Datos;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;

namespace CoreSAF.Datos
{
    public class RemisionDatos : SesionDatos
    {
        public List<RemisionModelo> Listar(string Accion)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", "");
                param.Add("@IdRemision", ParameterDirection.Output);
                IList<RemisionModelo> LisRemision = SqlMapper.Query<RemisionModelo>(Session.SqlConexion, "SAF.pRemision", param, commandType: CommandType.StoredProcedure).ToList();
                return LisRemision.ToList();
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.RemisionDatos - Listar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public List<RemisionDetalleModelo> ListarDetalle(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                param.Add("@IdRemision", ParameterDirection.Output);
                IList<RemisionDetalleModelo> LisRemisionDetalle = SqlMapper.Query<RemisionDetalleModelo>(Session.SqlConexion, "SAF.pRemision", param, commandType: CommandType.StoredProcedure).ToList();
                return LisRemisionDetalle.ToList();
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.RemisionDatos - ListarDetalle");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public RemisionModelo Consultar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                param.Add("@IdRemision", ParameterDirection.Output);
                IList<RemisionModelo> LisRemision = SqlMapper.Query<RemisionModelo>(Session.SqlConexion, "SAF.pRemision", param, commandType: CommandType.StoredProcedure).ToList();
                if (LisRemision.Count > 0)
                    return LisRemision[0];
                else
                    return null;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.RemisionDatos - Consultar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public Int32 Insertar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                param.Add("@IdRemision", null, DbType.Int32, ParameterDirection.Output);
                Session.SqlConexion.Execute("SAF.pRemision", param, commandType: CommandType.StoredProcedure);
                int intResultado = param.Get<Int32>("@IdRemision");
                return intResultado;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.RemisionDatos - Insertar");
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
                param.Add("@IdRemision", ParameterDirection.Output);
                Session.SqlConexion.Execute("SAF.pRemision", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.RemisionDatos - Editar");
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
                param.Add("@IdRemision", ParameterDirection.Output);
                Session.SqlConexion.Execute("SAF.pRemision", param, commandType: CommandType.StoredProcedure);
                bolResultado = true;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "CoreSAF.Datos.RemisionDatos - Borrar");
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