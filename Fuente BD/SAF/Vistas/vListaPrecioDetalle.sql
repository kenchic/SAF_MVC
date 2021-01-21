USE [SAF]
GO

/****** Object:  View [SAF].[vListaPrecioDetalle]    Script Date: 20/01/2021 08:06:18 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [SAF].[vListaPrecioDetalle]
AS
SELECT  LPD.Id, LPD.idListaPrecio, LPD.idElemento, LPD.PrecioAlquiler, LPD.PrecioVenta, LPD.PrecioPerdida, LP.Nombre ListaPrecioNombre, E.Nombre ElementoNombre
FROM bdListaPrecioDetalle LPD
INNER JOIN bdListaPrecio LP ON LPD.idListaPrecio = LP.Id
INNER JOIN bdElemento E ON LPD.idElemento = E.Id

GO