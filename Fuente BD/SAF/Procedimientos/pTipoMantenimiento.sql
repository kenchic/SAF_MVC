USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pTipoMantenimiento]    Script Date: 20/01/2021 12:06:53 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [SAF].[pTipoMantenimiento]  
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


