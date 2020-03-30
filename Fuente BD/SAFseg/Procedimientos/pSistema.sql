USE [SAFseg]
GO

/****** Object:  StoredProcedure [dbo].[pSistema]    Script Date: 27/03/2020 04:44:55 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pSistema]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Version FROM bdSistema

	IF (@Accion = 1)
		SELECT Id, Nombre, Version FROM bdSistema

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Version FROM bdSistema
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'int'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdSistema 
			SELECT * FROM (SELECT					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Version' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Version]
			FROM fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'int'
			GROUP BY parent_ID) Sistema
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE U
			SET Nombre = Sistema.Nombre,
				Version = Sistema.Version
			FROM bdSistema AS U
			INNER JOIN 
			(SELECT
				  max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				  max(CASE WHEN name='Version' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Version],
				  max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Sistema ON U.Id = Sistema.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE U
			FROM bdSistema AS U
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Sistema ON U.Id = Sistema.Id
		END
END


GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'20.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pSistema'
GO


