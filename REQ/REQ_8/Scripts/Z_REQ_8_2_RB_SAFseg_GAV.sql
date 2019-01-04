USE [SAFseg]
GO

UPDATE bdSistema SET Version = '18.0.6' WHERE ID = 2 --SAF
UPDATE bdSistema SET Version = '18.0.4' WHERE ID = 3 --CoreGeneral
UPDATE bdSistema SET Version = '18.0.4' WHERE ID = 4 --CoreSAF

UPDATE bdArtefacto SET idEstado = 2, Version='18.0.4' WHERE Id = 29  --Idioma.resx

DELETE bdArtefactoHistorial WHERE idRequerimiento = 8 --bdConductor

DELETE bdArtefacto WHERE Id = 57 --bdConductor
DELETE bdArtefacto WHERE Id = 58 --ConductorController.cs
DELETE bdArtefacto WHERE Id = 59 --ConductorNegocio.cs
DELETE bdArtefacto WHERE Id = 60 --ConductorDatos.cs
DELETE bdArtefacto WHERE Id = 61 --ConductorModelo.cs
DELETE bdArtefacto WHERE Id = 62 --pConductor.sql
DELETE bdArtefacto WHERE Id = 63 --ConductorConsultar.cshtml
DELETE bdArtefacto WHERE Id = 64 --ConductorListar.cshtml
DELETE bdArtefacto WHERE Id = 65 --ConductorEditar.cshtml
DELETE bdArtefacto WHERE Id = 66 --ConductorInsertar.cshtml

DELETE FROM bdRequerimiento WHERE Id = 8