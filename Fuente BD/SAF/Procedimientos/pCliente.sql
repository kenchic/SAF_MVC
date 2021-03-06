USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pCliente]    Script Date: 20/01/2021 11:01:00 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [SAF].[pCliente]  
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
			FROM SEG.fParseJSON
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
			FROM SEG.fParseJSON
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
			FROM SEG.fParseJSON
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
			From SEG.fParseJSON
			(
				  @json
			)) AS Cliente ON C.Id = Cliente.Id
		END
END


