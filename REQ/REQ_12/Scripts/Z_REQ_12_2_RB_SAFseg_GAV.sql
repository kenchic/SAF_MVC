USE [SAFseg]
GO

UPDATE bdSistema SET Version = '19.0.1' WHERE ID = 2 --SAF
UPDATE bdSistema SET Version = '19.0.1' WHERE ID = 3 --CoreGeneral
UPDATE bdSistema SET Version = '19.0.1' WHERE ID = 4 --CoreSAF

UPDATE bdArtefacto SET idEstado = 2, Version='19.0.1' WHERE Id = 29  --Idioma.resx

DELETE bdArtefactoHistorial WHERE idRequerimiento = 9 --bdListaPrecio

DELETE bdArtefacto WHERE Id = 67 --bdListaPrecio
DELETE bdArtefacto WHERE Id = 68 --ListaPrecioController.cs
DELETE bdArtefacto WHERE Id = 69 --ListaPrecioNegocio.cs
DELETE bdArtefacto WHERE Id = 70 --ListaPrecioDatos.cs
DELETE bdArtefacto WHERE Id = 71 --ListaPrecioModelo.cs
DELETE bdArtefacto WHERE Id = 72 --pListaPrecio.sql
DELETE bdArtefacto WHERE Id = 73 --ListaPrecioConsultar.cshtml
DELETE bdArtefacto WHERE Id = 74 --ListaPrecioListar.cshtml
DELETE bdArtefacto WHERE Id = 75 --ListaPrecioEditar.cshtml
DELETE bdArtefacto WHERE Id = 76 --ListaPrecioInsertar.cshtml

DELETE FROM bdRequerimiento WHERE Id = 9