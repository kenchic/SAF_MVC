USE [SAF]
GO
/****** Object:  StoredProcedure [dbo].[pAgente]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pBodega]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pBodega]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idCliente, idProveedor, Nombre, Activo, EsSistema FROM bdBodega

	IF (@Accion = 1)
		SELECT Id, idCliente, idProveedor, Nombre, Activo, EsSistema FROM bdBodega WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT  Id, idCliente, idProveedor, Nombre, Activo, EsSistema FROM bdBodega
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
			INSERT INTO bdBodega 
			SELECT * FROM (SELECT
					max(CASE WHEN name='idCliente' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [idCliente],
					max(CASE WHEN name='idProveedor' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [idProveedor],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS [EsSistema]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Bodega
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET idCliente = Bodega.idCliente,
				idProveedor = Bodega.idProveedor,
				Nombre = Bodega.Nombre,
				Activo = Bodega.Activo,
				EsSistema = Bodega.EsSistema
			FROM bdBodega AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='idCliente' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [idCliente],
					max(CASE WHEN name='idProveedor' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [idProveedor],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS [EsSistema],
					max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Bodega ON A.Id = Bodega.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdBodega AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Bodega ON A.Id = Bodega.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pCiudad]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pCliente]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pCliente]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Nombre, Direccion, Telefono, Celular, Correo, Activo, CiudadNombre FROM VCliente

	IF (@Accion = 1)
		SELECT Id, idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Nombre, Direccion, Telefono, Celular, Correo, Activo, CiudadNombre FROM VCliente WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Nombre, Direccion, Telefono, Celular, Correo, Activo, CiudadNombre FROM VCliente
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
			INSERT INTO bdCliente (idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Telefono, Celular, Correo, Activo)
			SELECT idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Telefono, Celular, Correo, Activo FROM (SELECT
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS [Identificacion],
					max(CASE WHEN name='Nombre1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre1],
					max(CASE WHEN name='Nombre2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre2],
					max(CASE WHEN name='Apellido1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido1],
					max(CASE WHEN name='Apellido2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido2],
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Celular' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Celular],
					max(CASE WHEN name='Correo' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Correo],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Cliente
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE C
			SET idCiudad = Cliente.idCiudad,
				Identificacion = Cliente.Identificacion,
				Nombre1 = Cliente.Nombre1,
				Nombre2 = CASE WHEN Cliente.Nombre2 = 'null' THEN '' ELSE Cliente.Nombre2 END,
				Apellido1 = Cliente.Apellido1,
				Apellido2 = CASE WHEN Cliente.Apellido2 = 'null' THEN '' ELSE Cliente.Apellido2 END,
				Direccion = Cliente.Direccion,
				Telefono = Cliente.Telefono,
				Celular = CASE WHEN Cliente.Celular = 'null' THEN '' ELSE Cliente.Celular END,
				Correo = CASE WHEN Cliente.Correo = 'null' THEN '' ELSE Cliente.Correo END,
				Activo = Cliente.Activo
			FROM bdCliente AS C
			INNER JOIN 
			(SELECT
				    max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS [Identificacion],
					max(CASE WHEN name='Nombre1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre1],
					max(CASE WHEN name='Nombre2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre2],
					max(CASE WHEN name='Apellido1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido1],
					max(CASE WHEN name='Apellido2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido2],
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Celular' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Celular],
					max(CASE WHEN name='Correo' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Correo],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Cliente ON C.Id = Cliente.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE C
			FROM bdCliente AS C
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Cliente ON C.Id = Cliente.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pConductor]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pGrupoElemento]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pListaPrecio]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pParametro]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pProveedor]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pProyecto]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pProyecto]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado
	           ,CiudadNombre, ClienteNombre FROM vProyecto

	IF (@Accion = 1)
		SELECT Id, idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado
	           ,CiudadNombre, ClienteNombre FROM vProyecto WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado
	           ,CiudadNombre, ClienteNombre FROM vProyecto 
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
			INSERT INTO bdProyecto (idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado)
			SELECT idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, GETDATE(), FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, 1, 1
			       FROM (SELECT
				    max(CASE WHEN name='idCliente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCliente],
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Tipo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Tipo],					
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Observacion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Observacion],
					max(CASE WHEN name='FormaContacto' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [FormaContacto],
					max(CASE WHEN name='SistemaMedida' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [SistemaMedida],
					max(CASE WHEN name='IdentificacionResponsable' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [IdentificacionResponsable],
					max(CASE WHEN name='NombreResponsable' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [NombreResponsable],
					max(CASE WHEN name='TelResponsable' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [TelResponsable]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Proyecto
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE P
			SET idCliente = Proyecto.idCliente,
				idCiudad = Proyecto.idCiudad,
				Nombre = Proyecto.Nombre,
				Tipo = Proyecto.Tipo, 
				Direccion = CASE WHEN Proyecto.Direccion = 'null' THEN '' ELSE Proyecto.Direccion END,
				Telefono = CASE WHEN Proyecto.Telefono = 'null' THEN '' ELSE Proyecto.Telefono END,
				Observacion = CASE WHEN Proyecto.Observacion = 'null' THEN '' ELSE Proyecto.Observacion END,				
				FormaContacto = CASE WHEN Proyecto.FormaContacto = 'null' THEN '' ELSE Proyecto.FormaContacto END,
				SistemaMedida = CASE WHEN Proyecto.SistemaMedida = 'null' THEN '' ELSE Proyecto.SistemaMedida END, 
				IdentificacionResponsable = CASE WHEN Proyecto.IdentificacionResponsable = 'null' THEN '' ELSE Proyecto.IdentificacionResponsable END,  
				NombreResponsable = CASE WHEN Proyecto.NombreResponsable = 'null' THEN '' ELSE Proyecto.NombreResponsable END, 
				TelResponsable = CASE WHEN Proyecto.TelResponsable = 'null' THEN '' ELSE Proyecto.TelResponsable END
			FROM bdProyecto AS P
			INNER JOIN 
			(SELECT
				    max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
					max(CASE WHEN name='idCliente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCliente],
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Tipo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Tipo],					
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Observacion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Observacion],					
					max(CASE WHEN name='FormaContacto' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [FormaContacto],
					max(CASE WHEN name='SistemaMedida' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [SistemaMedida],
					max(CASE WHEN name='IdentificacionResponsable' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [IdentificacionResponsable],
					max(CASE WHEN name='NombreResponsable' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [NombreResponsable],
					max(CASE WHEN name='TelResponsable' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [TelResponsable]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Proyecto ON P.Id = Proyecto.Id

		END

	IF(@Accion = 5)
		BEGIN
			UPDATE P
			SET Activo = 0
			FROM bdProyecto AS P
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Proyecto ON P.Id = Proyecto.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pTipoDocumento]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
			WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
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
/****** Object:  StoredProcedure [dbo].[pTipoMantenimiento]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pTipoMantenimiento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Valor, Activo FROM bdTipoMantenimiento

	IF (@Accion = 1)
		SELECT Id, Nombre, Valor, Activo FROM bdTipoMantenimiento WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Valor, Activo FROM bdTipoMantenimiento
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
			INSERT INTO bdTipoMantenimiento 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Valor' THEN convert(numeric(18,0),StringValue) ELSE 0 END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'real'
			GROUP BY parent_ID) TipoMantenimiento
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = TipoMantenimiento.Nombre,
				Valor = TipoMantenimiento.Valor,
				Activo = TipoMantenimiento.Activo
			FROM bdTipoMantenimiento AS A
			INNER JOIN 
			(SELECT				   
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id],
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Valor' THEN convert(numeric(18,0),StringValue) ELSE 0 END) AS Valor,
				   max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS TipoMantenimiento ON A.Id = TipoMantenimiento.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdTipoMantenimiento AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS TipoMantenimiento ON A.Id = TipoMantenimiento.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pUnidadMedida]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pUnidadMedida]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdUnidadMedida

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdUnidadMedida WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdUnidadMedida
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
			INSERT INTO bdUnidadMedida 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) UnidadMedida
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = UnidadMedida.Nombre,
				Activo = UnidadMedida.Activo
			FROM bdUnidadMedida AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS UnidadMedida ON A.Id = UnidadMedida.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdUnidadMedida AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS UnidadMedida ON A.Id = UnidadMedida.Id
		END
END




GO
/****** Object:  Table [dbo].[bdAgente]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdBodega]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdBodega](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[idProveedor] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[EsSistema] [bit] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdBodegas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdCiudad]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdCliente]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdCliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCiudad] [smallint] NOT NULL,
	[Identificacion] [varchar](20) NOT NULL,
	[Nombre1] [varchar](25) NOT NULL,
	[Nombre2] [varchar](25) NULL,
	[Apellido1] [varchar](25) NOT NULL,
	[Apellido2] [varchar](25) NULL,
	[Nombre]  AS (((((([Nombre1]+' ')+[Nombre2])+' ')+[Apellido1])+' ')+[Apellido2]),
	[Direccion] [varchar](200) NOT NULL,
	[Telefono] [varchar](50) NOT NULL,
	[Celular] [varchar](50) NULL,
	[Correo] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdClientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdConductor]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdGrupoElemento]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdListaPrecio]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdParametro]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdProveedor]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdProyecto]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdProyecto](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idCiudad] [smallint] NOT NULL,
	[Nombre] [varchar](200) NOT NULL,
	[Tipo] [varchar](100) NOT NULL,
	[Direccion] [varchar](100) NULL,
	[Telefono] [varchar](50) NULL,
	[Observacion] [varchar](500) NULL,
	[Fecha] [date] NOT NULL,
	[FormaContacto] [varchar](50) NULL,
	[SistemaMedida] [varchar](50) NULL,
	[IdentificacionResponsable] [varchar](15) NULL,
	[NombreResponsable] [varchar](200) NULL,
	[TelResponsable] [varchar](50) NULL,
	[Activo] [bit] NOT NULL CONSTRAINT [DF_bdProyecto_Activo]  DEFAULT ((1)),
	[Estado] [tinyint] NOT NULL CONSTRAINT [DF_bdProyecto_Estado]  DEFAULT ((1)),
 CONSTRAINT [PK_bdProyectos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdTipoDocumento]    Script Date: 06/03/2019 09:13:46 p.m. ******/
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
/****** Object:  Table [dbo].[bdTipoMantenimiento]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdTipoMantenimiento](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Valor] [numeric](18, 0) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_bdTipoMantenimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdUnidadMedida]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdUnidadMedida](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdUnidadesMedidas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vBodega]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vBodega]
AS
SELECT B.Id, B.idCliente, B.idProveedor, B.Nombre, B.Activo, B.EsSistema,C.Nombre ClienteNombre, P.Nombre ProveedorNombre
FROM bdBodega B
INNER JOIN bdCliente C ON B.idCliente = C.Id
INNER JOIN bdProveedor P ON B.idProveedor = P.Id


GO
/****** Object:  View [dbo].[vCliente]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCliente]
AS
SELECT C.Id, C.idCiudad, C.Identificacion, C.Nombre1, C.Nombre2, C.Apellido1, C.Apellido2, C.Nombre, C.Direccion, C.Telefono, C.Celular, C.Correo, C.Activo, U.Nombre CiudadNombre
FROM bdCliente C
INNER JOIN bdCiudad U ON C.idCiudad = U.Id
GO
/****** Object:  View [dbo].[vProyecto]    Script Date: 06/03/2019 09:13:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vProyecto]
AS
SELECT P.Id, P.idCliente, P.idCiudad, P.Nombre, P.Tipo, P.Direccion, P.Telefono, P.Observacion, P.Fecha, P.FormaContacto, P.SistemaMedida, P.IdentificacionResponsable, P.NombreResponsable, P.TelResponsable, P.Activo, P.Estado
	   ,U.Nombre CiudadNombre, C.Nombre ClienteNombre
FROM bdProyecto P
INNER JOIN bdCiudad U ON P.idCiudad = U.Id
INNER JOIN bdCliente C ON P.idCliente = C.Id

GO
ALTER TABLE [dbo].[bdBodega] ADD  CONSTRAINT [DF_bdBodega_idCliente]  DEFAULT ((0)) FOR [idCliente]
GO
ALTER TABLE [dbo].[bdBodega] ADD  CONSTRAINT [DF_bdBodega_idProveedor]  DEFAULT ((0)) FOR [idProveedor]
GO
ALTER TABLE [dbo].[bdBodega] ADD  CONSTRAINT [DF_bdBodega_EsSistema]  DEFAULT ((0)) FOR [EsSistema]
GO
ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_bdBodegaCliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[bdCliente] ([Id])
GO
ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_bdBodegaCliente]
GO
ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_bdBodegaProveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[bdProveedor] ([Id])
GO
ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_bdBodegaProveedor]
GO
ALTER TABLE [dbo].[bdCliente]  WITH CHECK ADD  CONSTRAINT [FK_bdClienteCiudad] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[bdCiudad] ([Id])
GO
ALTER TABLE [dbo].[bdCliente] CHECK CONSTRAINT [FK_bdClienteCiudad]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyecto_bdProyecto] FOREIGN KEY([Id])
REFERENCES [dbo].[bdProyecto] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdProyecto_bdProyecto]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyectoCiudad] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[bdCiudad] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdProyectoCiudad]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyectoCliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[bdCliente] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdProyectoCliente]
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pCliente'
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
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pTipoDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pTipoMantenimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCliente'
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
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdProyecto'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdTipoDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdTipoMantenimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProyecto'
GO
