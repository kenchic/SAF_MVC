USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pUnidadMedida]    Script Date: 20/01/2021 12:11:28 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [SAF].[pUnidadMedida]  
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
			FROM SEG.fParseJSON
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
			FROM SEG.fParseJSON
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
			FROM SEG.fParseJSON
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
			From SEG.fParseJSON
			(
				  @json
			)) AS UnidadMedida ON A.Id = UnidadMedida.Id
		END
END



