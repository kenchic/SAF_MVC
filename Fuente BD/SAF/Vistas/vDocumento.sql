USE [SAF]
GO

/****** Object:  View [dbo].[vDocumento]    Script Date: 03/06/2019 04:22:51 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[vDocumento]
AS
SELECT D.Id, D.idTipoDocumento, D.idBodegaOrigen, D.idBodegaDestino, D.Numero, D.Fecha, D.Descripcion, D.Anulado, TD.Nombre TipoDocumentoNombre, BO.Nombre BodegaOrigenNombre, BD.Nombre BodegaDestinoNombre
FROM bdDocumento D
INNER JOIN bdTipoDocumento TD ON D.idTipoDocumento = TD.Id
INNER JOIN bdBodega BO ON D.idBodegaOrigen = BO.Id
INNER JOIN bdBodega BD ON D.idBodegaDestino = BD.Id




GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDocumento'
GO


