USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pDocumentoTipo]    Script Date: 20/01/2021 11:02:35 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [SAF].[pDocumentoTipo]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdDocumentoTipo

	IF (@Accion = 1)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdDocumentoTipo WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdDocumentoTipo
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
			INSERT INTO bdDocumentoTipo 
			SELECT * FROM (SELECT					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
			GROUP BY parent_ID) DocumentoTipo
		END
	
	IF(@Accion = 4)
		BEGIN
			UPDATE A
			SET Nombre = DocumentoTipo.Nombre,
				Consecutivo = DocumentoTipo.Consecutivo,
				Operacion = DocumentoTipo.Operacion,
				EsSistema = DocumentoTipo.EsSistema,
				Activo = DocumentoTipo.Activo
			FROM bdDocumentoTipo AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SEG.fParseJSON
			(@json)
			) AS DocumentoTipo ON A.Id = DocumentoTipo.Id
		END
	
	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdDocumentoTipo AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id
			FROM SEG.fParseJSON
			(@json)
			) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END

