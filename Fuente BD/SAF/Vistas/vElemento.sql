USE [SAF]
GO

/****** Object:  View [dbo].[vElemento]    Script Date: 19/03/2019 09:25:17 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vElemento]
AS
SELECT  E.Id ,E.idGrupoElemento, E.idUnidadMedida, E.Referencia, E.Nombre, E.Mt2, E.Peso, E.Rotacion, E.Activo, GE.Nombre GrupoElementoNombre, U.Nombre UnidadMedidaNombre
FROM bdElemento E
INNER JOIN bdGrupoElemento GE ON E.idGrupoElemento = GE.Id
INNER JOIN bdUnidadMedida U ON E.idUnidadMedida = U.Id

GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vElemento'
GO


