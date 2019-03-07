USE [SAF]
GO

/****** Object:  View [dbo].[vCliente]    Script Date: 06/03/2019 09:06:24 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vCliente]
AS
SELECT C.Id, C.idCiudad, C.Identificacion, C.Nombre1, C.Nombre2, C.Apellido1, C.Apellido2, C.Nombre, C.Direccion, C.Telefono, C.Celular, C.Correo, C.Activo, U.Nombre CiudadNombre
FROM bdCliente C
INNER JOIN bdCiudad U ON C.idCiudad = U.Id
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCliente'
GO


