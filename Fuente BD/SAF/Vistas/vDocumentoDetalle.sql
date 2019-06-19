USE [SAF]
GO

/****** Object:  View [dbo].[vDocumentoDetalle]    Script Date: 14/06/2019 02:51:12 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vDocumentoDetalle]
AS
SELECT     DD.Id, DD.idElemento, DD.idDocumento, D.Descripcion, D.idBodegaDestino, D.idBodegaOrigen, DD.Cantidad, E.Nombre AS ElementoNombre, BO.Nombre AS BodegaOrigenNombre, 
                      BD.Nombre AS BodegaDestinoNombre
FROM         dbo.bdDocumentoDetalle AS DD INNER JOIN
                      dbo.bdDocumento AS D ON DD.idDocumento = D.Id INNER JOIN
                      dbo.bdElemento AS E ON DD.idElemento = E.Id INNER JOIN
                      dbo.bdBodega AS BO ON D.idBodegaOrigen = BO.Id INNER JOIN
                      dbo.bdBodega AS BD ON D.idBodegaDestino = BD.Id



GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDocumentoDetalle'
GO


