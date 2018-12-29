USE [SAFseg]
GO

--UPDATE bdSistema SET Version = '18.0.5' WHERE ID = 1 --SAFseg
UPDATE bdSistema SET Version = '18.0.5' WHERE ID = 2 --SAF
UPDATE bdSistema SET Version = '18.0.3' WHERE ID = 3 --CoreGeneral
UPDATE bdSistema SET Version = '18.0.3' WHERE ID = 4 --CoreSAF
--UPDATE bdSistema SET Version = '18.0.2' WHERE ID = 5 --CoreSAFseg

UPDATE bdArtefacto SET idEstado = 2, Version='18.0.3' WHERE Id = 29  --Idioma.resx

DELETE bdArtefactoHistorial WHERE idRequerimiento = 7 --bdConductor

DELETE bdArtefacto WHERE Id = 47 --bdConductor
DELETE bdArtefacto WHERE Id = 48 --ConductorController.cs
DELETE bdArtefacto WHERE Id = 49 --ConductorNegocio.cs
DELETE bdArtefacto WHERE Id = 50 --ConductorDatos.cs
DELETE bdArtefacto WHERE Id = 51 --ConductorModelo.cs
DELETE bdArtefacto WHERE Id = 52 --pConductor.sql
DELETE bdArtefacto WHERE Id = 53 --ConductorConsultar.cshtml
DELETE bdArtefacto WHERE Id = 54 --ConductorListar.cshtml
DELETE bdArtefacto WHERE Id = 55 --ConductorEditar.cshtml
DELETE bdArtefacto WHERE Id = 56 --ConductorInsertar.cshtml

DELETE FROM bdRequerimiento WHERE Id = 7