USE [SAFseg]
GO
/****** Object:  Table [dbo].[bdMenu]    Script Date: 03/12/2018 09:46:06 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdMenu](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idMenu] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Vista] [varchar](100) NULL,
	[Orden] [smallint] NOT NULL,
	[Imagen] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdRol]    Script Date: 03/12/2018 09:46:06 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdRol](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdRolMenu]    Script Date: 03/12/2018 09:46:06 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdRolMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdRolUsuario]    Script Date: 04/12/2018 04:00:47 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdRolUsuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolUsuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdUsuarioMenu]    Script Date: 03/12/2018 09:46:06 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdUsuarioMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdUsuarioMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
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
							WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
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
ALTER TABLE [dbo].[bdMenu] ADD  CONSTRAINT [DF_bdMenu_Activo]  DEFAULT ((0)) FOR [Activo]
GO
ALTER TABLE [dbo].[bdMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdMenuPadre] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO
ALTER TABLE [dbo].[bdMenu] CHECK CONSTRAINT [FK_bdMenuPadre]
GO
ALTER TABLE [dbo].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO
ALTER TABLE [dbo].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Menu]
GO
ALTER TABLE [dbo].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Rol] FOREIGN KEY([idRol])
REFERENCES [dbo].[bdRol] ([Id])
GO
ALTER TABLE [dbo].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Rol]
GO
ALTER TABLE [dbo].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO
ALTER TABLE [dbo].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Menu]
GO
ALTER TABLE [dbo].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Usuario] FOREIGN KEY([Id])
REFERENCES [dbo].[bdUsuarioMenu] ([Id])
GO
ALTER TABLE [dbo].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Usuario]
GO
ALTER TABLE [dbo].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRol] FOREIGN KEY([idRol])
REFERENCES [dbo].[bdRol] ([Id])
GO
ALTER TABLE [dbo].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRol]
GO
ALTER TABLE [dbo].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRolUsuario] FOREIGN KEY([Id])
REFERENCES [dbo].[bdRolUsuario] ([Id])
GO
ALTER TABLE [dbo].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRolUsuario]
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRolUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRol'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRolMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdUsuarioMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pUsuarioMenu'
GO
