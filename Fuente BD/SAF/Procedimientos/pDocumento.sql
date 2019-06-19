USE [SAF]
GO

/****** Object:  StoredProcedure [dbo].[pDocumento]    Script Date: 17/06/2019 01:19:24 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[pDocumento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar, 6: Insertar Lista y Detalle, 7: Editar Lista y Detalle
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Numero, idTipoDocumento, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Anulado, TipoDocumentoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento

	IF (@Accion = 1)
		SELECT Id, Numero, idTipoDocumento, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Anulado, TipoDocumentoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento WHERE Anulado = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Numero, idTipoDocumento, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Anulado, TipoDocumentoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento
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
			INSERT INTO bdDocumento (idTipoDocumento, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Anulado)
			SELECT idTipoDocumento, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Anulado 
					FROM (SELECT
					max(CASE WHEN name='idTipoDocumento' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idTipoDocumento],
					max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
					max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
					max(CASE WHEN name='Numero' THEN convert(INT,StringValue) ELSE 0 END) AS [Numero],
					max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
					max(CASE WHEN name='Anulado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Anulado]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Documento
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE D
			SET idTipoDocumento = Documento.idTipoDocumento,
				idBodegaOrigen = Documento.idBodegaOrigen,
				idBodegaDestino = Documento.idBodegaDestino,
				Fecha = Documento.Fecha,
				Descripcion = Documento.Descripcion,
				Anulado = Documento.Anulado
			FROM bdDocumento AS D
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
				    max(CASE WHEN name='idTipoDocumento' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idTipoDocumento],
					max(CASE WHEN name='idUnidadMedida' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idBodegaOrigen],
					max(CASE WHEN name='idBodegaDestino' THEN convert(VARCHAR(50),StringValue) ELSE 0 END) AS [idBodegaDestino],
					max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Descripcion],
					max(CASE WHEN name='Anulado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Anulado]
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Documento ON D.Id = Documento.Id
		END

	IF(@Accion = 6)
		BEGIN
			BEGIN TRANSACTION;  
			BEGIN TRY 
				DECLARE @ID_DOCUMENTO AS INT

				--Insertar Documento				
				INSERT INTO bdDocumento (idTipoDocumento, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Anulado)
						SELECT idTipoDocumento, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Anulado 
						FROM (SELECT
						max(CASE WHEN name='idTipoDocumento' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idTipoDocumento],
						max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
						max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
						max(CASE WHEN name='Numero' THEN convert(INT,StringValue) ELSE 0 END) AS [Numero],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
						max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
						max(CASE WHEN name='Anulado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Anulado]
							FROM SAFseg.dbo.fParseJSON
							( @Json )
						WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
						GROUP BY parent_ID) Documento
				WHERE Documento.Fecha <> ''

				SELECT @ID_DOCUMENTO = SCOPE_IDENTITY()

				--Insertar Detalle
				INSERT INTO bdDocumentoDetalle (idDocumento, idElemento, Cantidad)
				SELECT @ID_DOCUMENTO, idElemento, Cantidad
				FROM (SELECT
							max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='idElemento' THEN convert(INT,StringValue) ELSE 0 END) AS [idElemento],
							max(CASE WHEN name='Cantidad' THEN convert(INT,StringValue) ELSE 0 END) AS [Cantidad]
						FROM SAFseg.dbo.fParseJSON
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
				SET idTipoDocumento = Documento.idTipoDocumento,
					idBodegaOrigen = Documento.idBodegaOrigen,
					idBodegaDestino = Documento.idBodegaDestino,
					Fecha = Documento.Fecha,
					Descripcion = Documento.Descripcion,
					Anulado =  Documento.Anulado
				FROM bdDocumento AS A
				INNER JOIN 
					(SELECT
							max(CASE WHEN name='idTipoDocumento' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idTipoDocumento],
							max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
							max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
							max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
							max(CASE WHEN name='Anulado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Anulado],
							max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
					FROM SAFseg.dbo.fParseJSON
						(@json)
					WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
					GROUP BY parent_ID) AS Documento ON A.Id = Documento.Id
				WHERE Documento.Fecha <> ''
					
				--Editar Detalle
				UPDATE DD
				SET idElemento = DocumentoDetalle.idElemento,
					Cantidad = DocumentoDetalle.Cantidad
				FROM bdDocumentoDetalle AS DD
				INNER JOIN 
				(SELECT
						max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
						max(CASE WHEN name='idElemento' THEN convert(INT,StringValue) ELSE 0 END) AS [idElemento],
						max(CASE WHEN name='Cantidad' THEN convert(INT,StringValue) ELSE 0 END) AS [Cantidad]
				FROM SAFseg.dbo.fParseJSON
					(@json)
				WHERE ValueType = 'string' OR ValueType = 'int'
				GROUP BY parent_ID) AS DocumentoDetalle ON DD.Id = DocumentoDetalle.Id
				WHERE DocumentoDetalle.Fecha = ''
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





GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pDocumento'
GO


