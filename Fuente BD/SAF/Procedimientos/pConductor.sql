USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pConductor]    Script Date: 20/01/2021 11:01:53 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [SAF].[pConductor]  
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
			FROM SEG.fParseJSON
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
			FROM SEG.fParseJSON
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
			FROM SEG.fParseJSON
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
			From SEG.fParseJSON
			(
				  @json
			)) AS Conductor ON A.Id = Conductor.Id
		END
END


