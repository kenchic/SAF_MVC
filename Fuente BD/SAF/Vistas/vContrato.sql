USE [SAF]
GO

/****** Object:  View [dbo].[vContrato]    Script Date: 15/03/2019 05:43:22 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vContrato]
AS
SELECT C.Id, C.idProyecto, C.idListaPrecio, C.idAgente, C.InformacionBD, C.ContratoAlquiler, C.CartaPagare, C.Pagare, C.LetraCambio, C.GarantiasCondiciones 
     , C.Deposito, C.Anticipo, C.PersonaJuridica, C.PersonaNatural, C.FotoCopiaCedula, C.FotoCopiaNit, C.CamaraComercio, C.DescuentoAlquiler, C.DescuentoVenta
     , C.DescuentoReposicion, C.DescuentoMantenimiento, C.DescuentoTransporte, C.PorcentajeAgente, A.Nombre AgenteNombre, L.Nombre ListaPrecioNombre
FROM bdContrato AS C
INNER JOIN bdListaPrecio L ON C.idListaPrecio = L.Id
LEFT JOIN bdAgente AS A ON C.idAgente = A.Id


GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vContrato'
GO


