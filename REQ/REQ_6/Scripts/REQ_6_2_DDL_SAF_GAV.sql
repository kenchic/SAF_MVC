USE [SAF]
GO

/****** Object:  StoredProcedure [dbo].[pCiudad]    Script Date: 17/12/2018 02:43:22 p.m. ******/
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

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pCiudad'
GO


