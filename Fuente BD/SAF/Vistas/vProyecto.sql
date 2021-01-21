USE [SAF]
GO

/****** Object:  View [SAF].[vProyecto]    Script Date: 20/01/2021 08:07:18 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [SAF].[vProyecto]
AS
SELECT P.Id, P.idCliente, P.idCiudad, P.Nombre, P.Tipo, P.Direccion, P.Telefono, P.Observacion, P.Fecha, P.FormaContacto, P.SistemaMedida, P.IdentificacionResponsable, P.NombreResponsable, P.TelResponsable, P.Activo, P.Estado
	   ,U.Nombre CiudadNombre, C.Nombre ClienteNombre, CN.Id idContrato
FROM bdProyecto P
INNER JOIN bdCiudad U ON P.idCiudad = U.Id
INNER JOIN bdCliente C ON P.idCliente = C.Id
INNER JOIN bdContrato CN ON P.Id = CN.idProyecto


GO