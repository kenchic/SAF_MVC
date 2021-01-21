USE [SAF]
GO

/****** Object:  View [SAF].[vCliente]    Script Date: 20/01/2021 08:03:41 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SAF].[vCliente]
AS
SELECT C.Id, C.idCiudad, C.Identificacion, C.Nombre1, C.Nombre2, C.Apellido1, C.Apellido2, C.Nombre, C.Direccion, C.Telefono, C.Celular, C.Correo, C.Activo, U.Nombre CiudadNombre
FROM bdCliente C
INNER JOIN bdCiudad U ON C.idCiudad = U.Id
GO