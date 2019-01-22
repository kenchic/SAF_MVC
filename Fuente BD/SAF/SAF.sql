USE [master]
GO
/****** Object:  Database [SAF]    Script Date: 21/01/2019 09:29:32 p.m. ******/
CREATE DATABASE [SAF] ON  PRIMARY 
( NAME = N'SAF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\SAF.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SAF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\SAF_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SAF] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SAF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SAF] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SAF] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SAF] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SAF] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SAF] SET ARITHABORT OFF 
GO
ALTER DATABASE [SAF] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SAF] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SAF] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SAF] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SAF] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SAF] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SAF] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SAF] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SAF] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SAF] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SAF] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SAF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SAF] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SAF] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SAF] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SAF] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SAF] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SAF] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SAF] SET RECOVERY FULL 
GO
ALTER DATABASE [SAF] SET  MULTI_USER 
GO
ALTER DATABASE [SAF] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SAF] SET DB_CHAINING OFF 
GO
USE [SAF]
GO
/****** Object:  StoredProcedure [dbo].[pAgente]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pAgente]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdAgente

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdAgente WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdAgente
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdAgente 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Agente
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Agente.Nombre,
				Activo = Agente.Activo
			FROM bdAgente AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Agente ON A.Id = Agente.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdAgente AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Agente ON A.Id = Agente.Id
		END
END


--GO

--EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pAgente'
--GO
GO
/****** Object:  StoredProcedure [dbo].[pCiudad]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pCiudad]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdCiudad

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdCiudad WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdCiudad
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdCiudad 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Ciudad
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Ciudad.Nombre,
				Activo = Ciudad.Activo
			FROM bdCiudad AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Ciudad ON A.Id = Ciudad.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdCiudad AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Ciudad ON A.Id = Ciudad.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pConductor]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pConductor]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo, Placa FROM bdConductor

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo, Placa FROM bdConductor WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT  Id, Nombre, Activo, Placa FROM bdConductor
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdConductor 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Placa' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Placa],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Conductor
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Conductor.Nombre,
				Placa = Conductor.Placa,
				Activo = Conductor.Activo
			FROM bdConductor AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Placa' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Placa],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Conductor ON A.Id = Conductor.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdConductor AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Conductor ON A.Id = Conductor.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pGrupoElemento]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pGrupoElemento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdGrupoElemento

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdGrupoElemento WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdGrupoElemento
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdGrupoElemento 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) GrupoElemento
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = GrupoElemento.Nombre,
				Activo = GrupoElemento.Activo
			FROM bdGrupoElemento AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS GrupoElemento ON A.Id = GrupoElemento.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdGrupoElemento AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS GrupoElemento ON A.Id = GrupoElemento.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pListaPrecio]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pListaPrecio]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdListaPrecio

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdListaPrecio WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdListaPrecio
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdListaPrecio 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) ListaPrecio
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = ListaPrecio.Nombre,
				Activo = ListaPrecio.Activo
			FROM bdListaPrecio AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS ListaPrecio ON A.Id = ListaPrecio.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdListaPrecio AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END




GO
/****** Object:  StoredProcedure [dbo].[pParametro]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pParametro]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Codigo, Nombre, Descripcion, Valor, Activo FROM bdParametro

	IF (@Accion = 1)
		SELECT Codigo, Nombre, Descripcion, Valor, Activo FROM bdParametro WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Codigo, Nombre, Descripcion, Valor, Activo FROM bdParametro
			WHERE Codigo = 
			(SELECT      
				   max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '0' END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdParametro 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Codigo,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS Descripcion,
					max(CASE WHEN name='Valor' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Parametro
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Parametro.Nombre,
				Descripcion = Parametro.Descripcion,
				Valor = Parametro.Valor,
				Activo = Parametro.Activo
			FROM bdParametro AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Codigo,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS Descripcion,
					max(CASE WHEN name='Valor' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Parametro ON A.Codigo = Parametro.Codigo

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdParametro AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS [Codigo]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS ListaPrecio ON A.Codigo = ListaPrecio.Codigo
		END
END





GO
/****** Object:  StoredProcedure [dbo].[pProveedor]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pProveedor]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Identificacion, Nombre, Iniciales, Telefono, Direccion, Activo FROM bdProveedor

	IF (@Accion = 1)
		SELECT Id, Identificacion, Nombre, Iniciales, Telefono, Direccion, Activo FROM bdProveedor WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Identificacion, Nombre, Iniciales, Telefono, Direccion, Activo FROM bdProveedor
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(VARCHAR(10),StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdProveedor 
			SELECT * FROM (SELECT									
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS Identificacion,
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Iniciales' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Iniciales,
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Descripcion,
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Proveedor
		END
	
	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Identificacion = Proveedor.Identificacion,
				Nombre = Proveedor.Nombre,
				Iniciales = Proveedor.Iniciales,
				Telefono = Proveedor.Telefono,
				Direccion = Proveedor.Direccion,
				Activo = Proveedor.Activo
			FROM bdProveedor AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(smallint,StringValue) ELSE 0 END) AS Id,					
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS Identificacion,
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Iniciales' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Iniciales,
					max(CASE WHEN name='Telefono' THEN (CASE WHEN StringValue = 'null' THEN NULL ELSE convert(VARCHAR(10),StringValue) END) ELSE '' END) AS Telefono,
					max(CASE WHEN name='Direccion' THEN (CASE WHEN StringValue = 'null' THEN NULL ELSE convert(VARCHAR(10),StringValue) END) ELSE '' END) AS Direccion,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SAFseg.dbo.fParseJSON
			(@json)
			) AS Proveedor ON A.Id = Proveedor.Id
		END
	
	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdProveedor AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(smallint,StringValue) ELSE 0 END) AS Id
			FROM SAFseg.dbo.fParseJSON
			(@json)
			) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END





GO
/****** Object:  StoredProcedure [dbo].[pTipoDocumento]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pTipoDocumento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdTipoDocumento

	IF (@Accion = 1)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdTipoDocumento WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdTipoDocumento
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdTipoDocumento 
			SELECT * FROM (SELECT					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) TipoDocumento
		END
	
	IF(@Accion = 4)
		BEGIN
			UPDATE A
			SET Nombre = TipoDocumento.Nombre,
				Consecutivo = TipoDocumento.Consecutivo,
				Operacion = TipoDocumento.Operacion,
				EsSistema = TipoDocumento.EsSistema,
				Activo = TipoDocumento.Activo
			FROM bdTipoDocumento AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SAFseg.dbo.fParseJSON
			(@json)
			) AS TipoDocumento ON A.Id = TipoDocumento.Id
		END
	
	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdTipoDocumento AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id
			FROM SAFseg.dbo.fParseJSON
			(@json)
			) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END


GO
/****** Object:  Table [dbo].[bdAgente]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdAgente](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdAgentes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdCiudad]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdCiudad](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdCiudades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdConductor]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdConductor](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NOT NULL,
	[Placa] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdConductores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdGrupoElemento]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdGrupoElemento](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdGruposElementos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdListaPrecio]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdListaPrecio](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdListasPrecios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdParametro]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdParametro](
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[Valor] [varchar](200) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_ParametroSistema] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdProveedor]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdProveedor](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](20) NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Iniciales] [varchar](10) NOT NULL,
	[Telefono] [varchar](100) NULL,
	[Direccion] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdProveedores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdTipoDocumento]    Script Date: 21/01/2019 09:29:32 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdTipoDocumento](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Consecutivo] [bigint] NULL,
	[Operacion] [varchar](1) NOT NULL,
	[EsSistema] [bit] NOT NULL CONSTRAINT [DF_bdTipoDocumento_EsSistema]  DEFAULT ((0)),
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdTiposDocumentos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pConductor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pGrupoElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pListaPrecio'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pProveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pTipoDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdConductor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdGrupoElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdListaPrecio'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdProveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdTipoDocumento'
GO
USE [master]
GO
ALTER DATABASE [SAF] SET  READ_WRITE 
GO
