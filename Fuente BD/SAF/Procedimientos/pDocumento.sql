USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pDocumento]    Script Date: 20/01/2021 11:02:15 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [SAF].[pDocumento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar, 6: Insertar Lista y Detalle, 7: Editar Lista y Detalle
	@Json NVARCHAR(max)	,
	@IdDocumento INT OUTPUT
)
AS 
BEGIN
	SET @IdDocumento = 0

	IF (@Accion = 0)
		SELECT Id, Numero, idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Estado, DocumentoTipoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento

	IF (@Accion = 1)
		SELECT Id, Numero, idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Estado, DocumentoTipoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento WHERE Estado = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Numero, idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Estado, DocumentoTipoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento
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
			INSERT INTO bdDocumento (idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado)
			SELECT idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado 
					FROM (SELECT
					max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idDocumentoTipo],
					max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
					max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
					max(CASE WHEN name='Numero' THEN convert(INT,StringValue) ELSE 0 END) AS [Numero],
					max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
					max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Documento
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE D
			SET idDocumentoTipo = Documento.idDocumentoTipo,
				idBodegaOrigen = Documento.idBodegaOrigen,
				idBodegaDestino = Documento.idBodegaDestino,
				Fecha = Documento.Fecha,
				Descripcion = Documento.Descripcion,
				Estado = Documento.Estado
			FROM bdDocumento AS D
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
				    max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idDocumentoTipo],
					max(CASE WHEN name='idUnidadMedida' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idBodegaOrigen],
					max(CASE WHEN name='idBodegaDestino' THEN convert(VARCHAR(50),StringValue) ELSE 0 END) AS [idBodegaDestino],
					max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Descripcion],
					max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Documento ON D.Id = Documento.Id
		END

	IF(@Accion = 5)
		BEGIN
			DELETE D
			FROM bdDocumento AS D
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Documento ON D.Id = Documento.Id
		END

	IF(@Accion = 6)
		BEGIN
			BEGIN TRANSACTION;  
			BEGIN TRY 

				--Insertar Documento				
				INSERT INTO bdDocumento (idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado)
						SELECT idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado 
						FROM (SELECT
						max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idDocumentoTipo],
						max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
						max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
						max(CASE WHEN name='Numero' THEN convert(INT,StringValue) ELSE 0 END) AS [Numero],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
						max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
						max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado]
							FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
						GROUP BY parent_ID) Documento
				WHERE Documento.Fecha <> ''

				SELECT @IdDocumento = SCOPE_IDENTITY()

				--Insertar Detalle
				INSERT INTO bdDocumentoDetalle (idDocumento, idElemento, Cantidad)
				SELECT @IdDocumento, idElemento, Cantidad
				FROM (SELECT
							max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='idElemento' THEN convert(INT,StringValue) ELSE 0 END) AS [idElemento],
							max(CASE WHEN name='Cantidad' THEN convert(INT,StringValue) ELSE 0 END) AS [Cantidad]
						FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
						GROUP BY parent_ID) DocumentoDetalle
				WHERE DocumentoDetalle.Fecha = '' AND DocumentoDetalle.Cantidad > 0 AND DocumentoDetalle.idElemento > 0
				
			END TRY  
			BEGIN CATCH  
				SELECT   
					ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;  
	
				IF @@TRANCOUNT > 0  
					ROLLBACK TRANSACTION;  
			END CATCH;  
  
			IF @@TRANCOUNT > 0  
				COMMIT TRANSACTION;  
		END

	IF(@Accion = 7)
		BEGIN
			BEGIN TRANSACTION;  
			BEGIN TRY
				--Editar Documento
				UPDATE A
				SET idDocumentoTipo = Documento.idDocumentoTipo,
					idBodegaOrigen = Documento.idBodegaOrigen,
					idBodegaDestino = Documento.idBodegaDestino,
					Fecha = Documento.Fecha,
					Descripcion = Documento.Descripcion,
					Estado =  Documento.Estado
				FROM bdDocumento AS A
				INNER JOIN 
					(SELECT
							max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idDocumentoTipo],
							max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
							max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
							max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
							max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado],
							max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
					FROM SEG.fParseJSON
						(@json)
					WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
					GROUP BY parent_ID) AS Documento ON A.Id = Documento.Id
				WHERE Documento.Fecha <> ''
					
				--Borrar Detalle
				DELETE DD
				FROM bdDocumentoDetalle DD
				INNER JOIN 
				(SELECT max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha]
				FROM SEG.fParseJSON
					(@json)
				WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
				GROUP BY parent_ID) AS Documento ON DD.idDocumento = Documento.Id 
				WHERE Documento.Fecha <> ''
				
				--Insertar Detalle
				SELECT @IdDocumento  = Documento.Id 
				FROM
				(SELECT max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha]
				FROM SEG.fParseJSON
					(@json)
				WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
				GROUP BY parent_ID) AS Documento 
				WHERE Documento.Fecha <> ''

				INSERT INTO bdDocumentoDetalle (idDocumento, idElemento, Cantidad)
				SELECT @IdDocumento, idElemento, Cantidad
				FROM (SELECT
							max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='idElemento' THEN convert(INT,StringValue) ELSE 0 END) AS [idElemento],
							max(CASE WHEN name='Cantidad' THEN convert(INT,StringValue) ELSE 0 END) AS [Cantidad]
						FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
						GROUP BY parent_ID) DocumentoDetalle
				WHERE DocumentoDetalle.Fecha = '' AND DocumentoDetalle.Cantidad > 0 AND DocumentoDetalle.idElemento > 0

			END TRY  
			BEGIN CATCH  
				SELECT   
					ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;  
  
				IF @@TRANCOUNT > 0  
					ROLLBACK TRANSACTION;  
			END CATCH;  
  
			IF @@TRANCOUNT > 0  
				COMMIT TRANSACTION;  
		END
END




