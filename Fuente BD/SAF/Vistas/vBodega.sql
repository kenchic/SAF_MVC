USE [SAF]
GO

/****** Object:  View [dbo].[vBodega]    Script Date: 11/03/2019 05:17:23 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vBodega]
AS
SELECT B.Id, B.idCliente, B.idProveedor, B.Nombre, B.Activo, B.EsSistema,C.Nombre ClienteNombre, P.Nombre ProveedorNombre
FROM bdBodega B
INNER JOIN bdCliente C ON B.idCliente = C.Id
INNER JOIN bdProveedor P ON B.idProveedor = P.Id


GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBodega'
GO


