USE [SAF]
GO

/****** Object:  View [SAF].[vElemento]    Script Date: 20/01/2021 08:05:57 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SAF].[vElemento]
AS
SELECT  E.Id ,E.idGrupoElemento, E.idUnidadMedida, E.Referencia, E.Nombre, E.Mt2, E.Peso, E.Rotacion, E.Activo, GE.Nombre GrupoElementoNombre, U.Nombre UnidadMedidaNombre
FROM bdElemento E
INNER JOIN bdGrupoElemento GE ON E.idGrupoElemento = GE.Id
INNER JOIN bdUnidadMedida U ON E.idUnidadMedida = U.Id

GO