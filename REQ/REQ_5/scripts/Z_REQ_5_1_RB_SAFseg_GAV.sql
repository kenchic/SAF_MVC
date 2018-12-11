USE [SAFseg]
GO

UPDATE bdSistema SET Version = '18.0.4' WHERE ID = 1 --SAFseg

DELETE bdArtefactoHistorial WHERE idArtefacto = 15 AND idRequerimiento = 5
DELETE bdArtefactoHistorial WHERE idArtefacto = 16 AND idRequerimiento = 5
DELETE bdArtefactoHistorial WHERE idArtefacto = 26 AND idRequerimiento = 5
DELETE bdArtefactoHistorial WHERE idArtefacto = 31 AND idRequerimiento = 5
DELETE bdArtefactoHistorial WHERE idArtefacto = 32 AND idRequerimiento = 5
DELETE bdArtefactoHistorial WHERE idArtefacto = 33 AND idRequerimiento = 5
DELETE bdArtefactoHistorial WHERE idArtefacto = 34 AND idRequerimiento = 5
DELETE bdArtefactoHistorial WHERE idArtefacto = 35 AND idRequerimiento = 5

UPDATE bdArtefacto SET idEstado = 2, Version='18.0.2' WHERE Id = 15  --UsuarioDashBoard.cshtml
UPDATE bdArtefacto SET idEstado = 2, Version='18.0.1' WHERE Id = 16  --UsuarioMenu.cshtml
UPDATE bdArtefacto SET idEstado = 2, Version='18.0.1' WHERE Id = 26  --UsuarioController
DELETE bdArtefacto WHERE Id = 31 --bdMenu
DELETE bdArtefacto WHERE Id = 32 --bdRol
DELETE bdArtefacto WHERE Id = 33 --bdRolMenu
DELETE bdArtefacto WHERE Id = 34 --bdUsuarioMenu
DELETE bdArtefacto WHERE Id = 35 --bdRolUsuario

DELETE FROM bdRequerimiento WHERE Id = 5
DROP TABLE bdRolMenu
DROP TABLE bdUsuarioMenu
DROP TABLE bdMenu
DROP TABLE bdRolUsuario
DROP TABLE bdRol
DROP PROCEDURE pUsuarioMenu