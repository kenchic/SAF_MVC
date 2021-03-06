USE [SAF]
GO
/****** Object:  StoredProcedure [SEG].[pSistema]    Script Date: 20/01/2021 12:20:26 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [SEG].[pSistema]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Codigo, Version FROM bdSistema

	IF (@Accion = 1)
		SELECT Id, Codigo, Version FROM bdSistema

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Codigo, Version FROM bdSistema
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
					max(CASE WHEN name='Codigo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Codigo],
					max(CASE WHEN name='Version' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Version]
			FROM fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'int'
			GROUP BY parent_ID) Sistema
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE U
			SET Codigo = Sistema.Codigo,
				Version = Sistema.Version
			FROM bdSistema AS U
			INNER JOIN 
			(SELECT
				  max(CASE WHEN name='Codigo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Codigo],
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


