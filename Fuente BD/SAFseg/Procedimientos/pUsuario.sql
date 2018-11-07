USE [SAFseg]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pUsuario]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar, 6: Autenticar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario

	IF (@Accion = 1)
		SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdUsuario 
			SELECT * FROM (SELECT
					max(CASE WHEN name='idRol' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idRol],
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Identificacion],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Apellido' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Apellido],
					max(CASE WHEN name='Usuario' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [Usuario],
					max(CASE WHEN name='Clave' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Clave],
					max(CASE WHEN name='Correo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Correo],					
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='Admin' THEN convert(BIT,StringValue) ELSE 0 END) AS [Admin]
			FROM fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Usuario
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE U
			SET Nombre = Usuario.Nombre,
				Activo = Usuario.Activo
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Id = Usuario.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE U
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Id = Usuario.Id
		END

	IF(@Accion = 6)
		BEGIN
			SELECT Id, idRol, Identificacion, Nombre, Apellido, U.Usuario, U.Clave, Correo, Activo, Admin 
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT 
				max(CASE WHEN name='Usuario' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [Usuario],
				max(CASE WHEN name='Clave' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Clave]
			FROM fParseJSON
			(
				@json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Usuario = Usuario.Usuario AND U.Clave = Usuario.Clave
		END
END

GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pUsuario'
GO


