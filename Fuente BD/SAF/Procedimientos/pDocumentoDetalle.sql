USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pDocumentoDetalle]    Script Date: 20/01/2021 11:02:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [SAF].[pDocumentoDetalle]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idDocumento, idElemento, idBodegaDestino, idBodegaOrigen, Cantidad, ElementoNombre, BodegaDestinoNombre, BodegaOrigenNombre, Descripcion  FROM vDocumentoDetalle

	IF (@Accion = 1)
		SELECT Id, idDocumento, idElemento, idBodegaDestino, idBodegaOrigen, Cantidad, ElementoNombre, BodegaDestinoNombre, BodegaOrigenNombre, Descripcion FROM vDocumentoDetalle WHERE Cantidad > 0 

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idDocumento, idElemento, idBodegaDestino, idBodegaOrigen, Cantidad, ElementoNombre, BodegaDestinoNombre, BodegaOrigenNombre, Descripcion FROM vDocumentoDetalle
			WHERE idDocumento = 
			(SELECT      
				   max(CASE WHEN name='idDocumento' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

END





