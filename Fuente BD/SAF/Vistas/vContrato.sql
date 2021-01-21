USE [SAF]
GO

/****** Object:  View [SAF].[vContrato]    Script Date: 20/01/2021 08:04:00 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [SAF].[vContrato]
AS
SELECT C.Id, C.idProyecto, C.idListaPrecio, C.idAgente, C.InformacionBD, C.ContratoAlquiler, C.CartaPagare, C.Pagare, C.LetraCambio, C.GarantiasCondiciones 
     , C.Deposito, C.Anticipo, C.PersonaJuridica, C.PersonaNatural, C.FotoCopiaCedula, C.FotoCopiaNit, C.CamaraComercio, C.DescuentoAlquiler, C.DescuentoVenta
     , C.DescuentoReposicion, C.DescuentoMantenimiento, C.DescuentoTransporte, C.PorcentajeAgente, A.Nombre AgenteNombre, L.Nombre ListaPrecioNombre
FROM bdContrato AS C
INNER JOIN bdListaPrecio L ON C.idListaPrecio = L.Id
LEFT JOIN bdAgente AS A ON C.idAgente = A.Id


GO