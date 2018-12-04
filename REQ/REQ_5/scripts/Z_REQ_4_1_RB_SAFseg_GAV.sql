USE [SAFseg]
GO

EXEC sp_RENAME 'bdRequerimiento.Descripcion' , 'Descripción', 'COLUMN'
GO

UPDATE bdArtefacto SET idEstado = 1
DELETE FROM  bdArtefactoEstado WHERE Id = 2

UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 15  --UsuarioDashBoard.cshtml
DELETE bdArtefactoHistorial WHERE idArtefacto = 15 AND idRequerimiento = 4
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 27  --LoginUsuario.cshtml
DELETE bdArtefactoHistorial WHERE idArtefacto = 27 AND idRequerimiento = 4
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 6  --bdRequerimiento
DELETE bdArtefactoHistorial WHERE idArtefacto = 6 AND idRequerimiento = 4
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 27  --Idioma
DELETE bdArtefactoHistorial WHERE idArtefacto = 27 AND idRequerimiento = 4
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 17  --AgenteConsultar.cshtml
DELETE bdArtefactoHistorial WHERE idArtefacto = 17 AND idRequerimiento = 4
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 24  --AgenteController.cs
DELETE bdArtefactoHistorial WHERE idArtefacto = 24 AND idRequerimiento = 4
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 18  --AgenteEditar.cshtml
DELETE bdArtefactoHistorial WHERE idArtefacto = 18 AND idRequerimiento = 4
UPDATE bdArtefacto SET idEstado = 1, Version='18.0.1' WHERE Id = 20  --AgenteListar.cshtml
DELETE bdArtefactoHistorial WHERE idArtefacto = 20 AND idRequerimiento = 4


UPDATE bdSistema SET Version = '18.0.1' WHERE ID = 1 --SAFseg
UPDATE bdSistema SET Version = '18.0.1' WHERE ID = 2 --SAF
UPDATE bdSistema SET Version = '18.0.1' WHERE ID = 3 --CoreGeneral

DELETE FROM bdRequerimiento WHERE Id = 4
DELETE FROM bdSistema WHERE Id IN (4,5)
GO