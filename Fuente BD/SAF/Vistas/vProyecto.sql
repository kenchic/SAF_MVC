USE [SAF]
GO

/****** Object:  View [dbo].[vProyecto]    Script Date: 18/03/2019 02:31:54 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vProyecto]
AS
SELECT P.Id, P.idCliente, P.idCiudad, P.Nombre, P.Tipo, P.Direccion, P.Telefono, P.Observacion, P.Fecha, P.FormaContacto, P.SistemaMedida, P.IdentificacionResponsable, P.NombreResponsable, P.TelResponsable, P.Activo, P.Estado
	   ,U.Nombre CiudadNombre, C.Nombre ClienteNombre, CN.Id idContrato
FROM bdProyecto P
INNER JOIN bdCiudad U ON P.idCiudad = U.Id
INNER JOIN bdCliente C ON P.idCliente = C.Id
INNER JOIN bdContrato CN ON P.Id = CN.idProyecto


GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProyecto'
GO


