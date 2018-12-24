USE [SAFseg]
GO

UPDATE bdSistema SET Version = '18.0.5' WHERE ID = 1 --SAFseg
UPDATE bdSistema SET Version = '18.0.4' WHERE ID = 2 --SAF
UPDATE bdSistema SET Version = '18.0.2' WHERE ID = 3 --CoreGeneral
UPDATE bdSistema SET Version = '18.0.2' WHERE ID = 4 --CoreSAF
UPDATE bdSistema SET Version = '18.0.2' WHERE ID = 5 --CoreSAFseg

UPDATE bdArtefacto SET idEstado = 2, Version='18.0.2' WHERE Id = 29  --Idioma.resx

DELETE bdArtefactoHistorial WHERE idRequerimiento = 6 --bdCiudad

DELETE bdArtefacto WHERE Id = 37 --bdCiudad
DELETE bdArtefacto WHERE Id = 38 --CiudadController.cs
DELETE bdArtefacto WHERE Id = 39 --CiudadNegocio.cs
DELETE bdArtefacto WHERE Id = 40 --CiudadDatos.cs
DELETE bdArtefacto WHERE Id = 41 --CiudadModelo.cs
DELETE bdArtefacto WHERE Id = 42 --pCiudad.sql
DELETE bdArtefacto WHERE Id = 43 --CiudadConsultar.cshtml
DELETE bdArtefacto WHERE Id = 44 --CiudadListar.cshtml
DELETE bdArtefacto WHERE Id = 45 --CiudadEditar.cshtml
DELETE bdArtefacto WHERE Id = 46 --CiudadInsertar.cshtml

DELETE FROM bdRequerimiento WHERE Id = 6