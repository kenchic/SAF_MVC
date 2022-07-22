using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using CoreGeneral.Negocios;
using CoreGeneral.Recursos;
using Dapper;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;

namespace SEG.Api.Datos
{
    public class BaseDatos
    {
        public IDbConnection Conexion { get; set; }

        public IConfiguration Configuracion { get; set; }

        public string Procedimiento { get; set; }

        public void AbrirConexion(string cadenaConexion, string motorBaseDatos = "SQL")
        {
            switch (motorBaseDatos)
            {
                case "SQL":
                    Conexion = new SqlConnection(cadenaConexion);
                    Conexion.Open();
                    break;
            }
        }

        public void AbrirConexion()
        {
            string cadenaConexion = Configuracion["CadenaConexion"];
            string motorBaseDatos = Configuracion["MotorBaseDatos"];
            switch (motorBaseDatos)
            {
                case "SQL":
                    Conexion = new SqlConnection(cadenaConexion);
                    Conexion.Open();
                    break;
            }
        }

        public void CerrarConexion()
        {
            if (Conexion.State == ConnectionState.Open)
                Conexion.Close();
            Conexion.Dispose();
            Conexion = null;
        }

        public List<object> ListarTodos()
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "ListarTodos");
                param.Add("@Json", "");
                List<object> LisUsuario = SqlMapper.Query<object>(Conexion, Procedimiento, param, commandType: CommandType.StoredProcedure).ToList();
                return LisUsuario.Count == 0 ? null : LisUsuario;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BaseDatos - ListarTodos");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public List<object> ListarActivos()
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "ListarActivos");
                param.Add("@Json", "");
                List<object> lista = SqlMapper.Query<object>(Conexion, Procedimiento, param, commandType: CommandType.StoredProcedure).ToList();
                return lista.Count == 0 ? null : lista;
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BaseDatos - ListarActivos");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public object Consultar(object modelo)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "Consultar");
                param.Add("@Json", JsonConvert.SerializeObject(modelo));
                List<object> lista = SqlMapper.Query<object>(Conexion, Procedimiento, param, commandType: CommandType.StoredProcedure).ToList();
                return lista.Count == 0 ? null : lista[0];
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BaseDatos - Consultar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public void Insertar(object modelo)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "Insertar");
                param.Add("@Json", JsonConvert.SerializeObject(modelo));
                SqlMapper.Execute(Conexion, Procedimiento, param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BaseDatos - Insertar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public void Editar(object modelo)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "Editar");
                param.Add("@Json", JsonConvert.SerializeObject(modelo));
                SqlMapper.Execute(Conexion, Procedimiento, param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BaseDatos - Editar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public void Borrar(object modelo)
        {
            try
            {
                AbrirConexion();
                DynamicParameters param = new DynamicParameters();
                param.Add("@Accion", "Borrar");
                param.Add("@Json", JsonConvert.SerializeObject(modelo));
                SqlMapper.Execute(Conexion, Procedimiento, param, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                MensajeNegocio.EscribirLog(Constantes.MensajeError, ex.Message, "BaseDatos- Borrar");
                throw;
            }
            finally
            {
                CerrarConexion();
            }
        }

    }
}
