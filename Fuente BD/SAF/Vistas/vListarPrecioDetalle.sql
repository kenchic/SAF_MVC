USE [SAF]
GO

/****** Object:  View [dbo].[vListaPrecioDetalle]    Script Date: 23/04/2019 06:01:32 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vListaPrecioDetalle]
AS
SELECT  LPD.Id, LPD.idListaPrecio, LPD.idElemento, LPD.PrecioAlquiler, LPD.PrecioVenta, LPD.PrecioPerdida, LP.Nombre ListaPrecioNombre, E.Nombre ElementoNombre
FROM bdListaPrecioDetalle LPD
INNER JOIN bdListaPrecio LP ON LPD.idListaPrecio = LP.Id
INNER JOIN bdElemento E ON LPD.idElemento = E.Id

GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vListaPrecioDetalle'
GO


