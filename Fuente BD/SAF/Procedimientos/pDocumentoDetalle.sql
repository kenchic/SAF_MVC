USE [SAF]
GO

/****** Object:  StoredProcedure [dbo].[pDocumentoDetalle]    Script Date: 14/06/2019 02:52:47 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[pDocumentoDetalle]  
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
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

END





GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pDocumentoDetalle'
GO


