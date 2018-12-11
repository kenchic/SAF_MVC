USE [SAFseg]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pUsuarioMenu]  
(
	@Accion INT = 0, --0:Listar menus del usUario y menus relacionados con roles del usuario,
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
	BEGIN

		DECLARE @Usuario AS smallint 
		SET @Usuario =  (	SELECT      
							MAX(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
							FROM fParseJSON ( @json )
							WHERE ValueType = 'string' OR ValueType = 'boolean'
							GROUP BY parent_ID)

		CREATE TABLE ##TablaTemporal (Id smallint, Nombre varchar(50), Vista varchar(50), Orden int, SubOrden int, Imagen Varchar(100) )

		DECLARE @idMenu AS smallint 
		DECLARE @idMenuPadre AS smallint 
		DECLARE @Nombre AS Varchar(50)
		DECLARE @Vista AS Varchar(100)
		DECLARE @Orden AS smallint
		DECLARE @Image AS Varchar(100)
		DECLARE @exite AS smallint 
		DECLARE @OrdenPadre AS smallint 

		--Construir Usuario - Menu
		DECLARE UsuarioMenu 
		CURSOR FOR 
			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdUsuarioMenu UM 
			INNER JOIN bdMenu M ON UM.idMenu = M.Id AND UM.Activo = 1
			WHERE UM.idUsuario = @Usuario 

			UNION

			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdRolUsuario RU
			INNER JOIN bdRolMenu RM ON RU.idRol = RM.idRol AND RU.Activo = 1
			INNER JOIN bdMenu M ON RM.idMenu = M.Id AND RM.Activo = 1
			WHERE RU.idUsuario = @Usuario

			UNION

			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdRolUsuario RU
			INNER JOIN bdRol RP ON RU.idRol = RP.idRol AND RU.Activo = 1
			INNER JOIN bdRolMenu RM ON RP.Id = RM.idRol AND RM.Activo = 1
			INNER JOIN bdMenu M ON RM.idMenu = M.Id 
			WHERE  RU.idUsuario = @Usuario

		OPEN UsuarioMenu
		FETCH NEXT FROM UsuarioMenu INTO @idMenu, @idMenuPadre, @Nombre, @Vista, @Orden, @Image
		WHILE @@fetch_status = 0
		BEGIN
			IF ( @idMenuPadre is null)
			BEGIN			
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenu
				IF (@exite IS NULL)
				BEGIN
					INSERT INTO ##TablaTemporal VALUES (@idMenu, @Nombre, @Vista, @Orden, null, @Image)			
					SELECT @OrdenPadre = Orden FROM bdMenu WHERE Id = @idMenu
				END
				INSERT INTO ##TablaTemporal
				SELECT M.id, M.Nombre, M.Vista, @OrdenPadre, M.Orden, M.Imagen FROM bdMenu M WHERE M.idMenu = @idMenu
			END
			ELSE
			BEGIN
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenuPadre
				IF (@exite IS NULL)
				BEGIN	
					INSERT INTO ##TablaTemporal
					SELECT Id, Nombre, Vista, Orden, null, Imagen FROM bdMenu WHERE Id = @idMenuPadre

					SELECT @OrdenPadre = Orden FROM bdMenu WHERE Id = @idMenuPadre
				END

				SET @exite = NULL
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenu
				IF (@exite IS NULL)
					INSERT INTO ##TablaTemporal VALUES (@idMenu, @Nombre, @Vista, @OrdenPadre, @Orden, @Image)
			END	
			FETCH NEXT FROM UsuarioMenu INTO  @idMenu, @idMenuPadre, @Nombre, @Vista, @Orden, @Image
		END

		CLOSE UsuarioMenu
		DEALLOCATE UsuarioMenu

		SELECT * FROM ##TablaTemporal ORDER BY Orden, SubOrden
		DROP TABLE ##TablaTemporal
	END
 END

GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pUsuarioMenu'
GO


