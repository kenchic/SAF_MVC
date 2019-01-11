USE [SAFseg]
GO

ALTER TABLE bdArtefactoHistorial DROP Version;

UPDATE bdSistema SET Version = '18.0.6' WHERE ID = 1 --SAFseg

UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 4  --bdArtefacto.sql
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 5  --bdArtefactoHistorial.sql

DELETE bdArtefactoHistorial WHERE idRequerimiento = 11

DELETE FROM bdRequerimiento WHERE Id = 11