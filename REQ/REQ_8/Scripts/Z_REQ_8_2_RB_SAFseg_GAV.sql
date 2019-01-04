USE [SAFseg]
GO

UPDATE bdSistema SET Version = '18.0.6' WHERE ID = 2 --SAF
UPDATE bdSistema SET Version = '18.0.4' WHERE ID = 3 --CoreGeneral
UPDATE bdSistema SET Version = '18.0.4' WHERE ID = 4 --CoreSAF

UPDATE bdArtefacto SET idEstado = 2, Version='18.0.4' WHERE Id = 29  --Idioma.resx

DELETE bdArtefactoHistorial WHERE idRequerimiento = 8 --bdGrupoElemento

DELETE bdArtefacto WHERE Id = 57 --bdGrupoElemento
DELETE bdArtefacto WHERE Id = 58 --GrupoElementoController.cs
DELETE bdArtefacto WHERE Id = 59 --GrupoElementoNegocio.cs
DELETE bdArtefacto WHERE Id = 60 --GrupoElementoDatos.cs
DELETE bdArtefacto WHERE Id = 61 --GrupoElementoModelo.cs
DELETE bdArtefacto WHERE Id = 62 --pGrupoElemento.sql
DELETE bdArtefacto WHERE Id = 63 --GrupoElementoConsultar.cshtml
DELETE bdArtefacto WHERE Id = 64 --GrupoElementoListar.cshtml
DELETE bdArtefacto WHERE Id = 65 --GrupoElementoEditar.cshtml
DELETE bdArtefacto WHERE Id = 66 --GrupoElementoInsertar.cshtml

DELETE FROM bdRequerimiento WHERE Id = 8