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
    public class ListaPrecioDatos : SesionDatos
    {
        public List<ListaPrecioModelo> Listar(string Accion)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", "");
                IList<ListaPrecioModelo> LisListaPrecio = SqlMapper.Query<ListaPrecioModelo>(objSesion.SqlConexion, "SAF.pListaPrecio", param, commandType: CommandType.StoredProcedure).ToList();
                return LisListaPrecio.ToList();
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ListaPrecioDatos - Listar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public ListaPrecioModelo Consultar(string Accion, string Json)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", Accion);
                param.Add("@Json", Json);
                IList<ListaPrecioModelo> LisListaPrecio = SqlMapper.Query<ListaPrecioModelo>(objSesion.SqlConexion, "SAF.pListaPrecio", param, commandType: CommandType.StoredProcedure).ToList();
                return LisListaPrecio[0];
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ListaPrecioDatos - Consultar");
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
                objSesion.SqlConexion.Execute("SAF.pListaPrecio", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ListaPrecioDatos - Insertar");
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
                objSesion.SqlConexion.Execute("SAF.pListaPrecio", param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ListaPrecioDatos - Editar");
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
                objSesion.SqlConexion.Execute("SAF.pListaPrecio", param, commandType: CommandType.StoredProcedure);
                bolResultado = true;
            }
            catch (Exception ex)
            {
                Mensajes.EscribirLog(Constantes.MensajeError, ex.Message, "CoreCore.Datos.ListaPrecioDatos - Borrar");
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